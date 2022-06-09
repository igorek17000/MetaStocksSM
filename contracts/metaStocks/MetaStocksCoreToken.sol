// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./../managers/feesManagers/FeesManager.sol";
import "./../interfaces/dexRouterInterfaces/IAutoLiquidityInjecter.sol";
import "./../managers/feesManagers/FeesSplitManager.sol";
import "./../managers/DexRouterManager.sol";

contract MetaStocksCoreToken is ERC20Upgradeable, IAutoLiquidityInjecter {
    // ADDRESSESS -------------------------------------------------------------------------------------------
    address private owner; // contract owner
    address private DEAD_ADDRESS; // DEAD Address for burn tokens
    address private lpPair; // Liquidity token address
    uint256 private swapThreshold; // swap tokens limit
    uint256 private maxWalletAmount; // max balance amount (Anti-whale)
    uint256 private maxTransactionAmount; // max balance amount (Anti-whale)
    bool private tradingEnabled;

    FeesManager private feesManager;
    FeesSplitManager private feesSplitManager;
    DexRouterManager private dexRouterManager;

    mapping(address => bool) private automatedMarketMakerPairs;

    // EVENTS -----------------------------------------------------------------------------------------------
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Burn(address indexed sender, uint256 amount);

    // MODIFIERS --------------------------------------------------------------------------------------------

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize(string memory _name, string memory _symbol)
        public
        initializer
    {
        __ERC20_init(_name, _symbol);
        initializeContract();
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function initializeContract() internal virtual {
        initAddressess();
        initContracts();
        setRouter(0x000000000000000000000000000000000000dEaD);
        createPair();
        doInitialApproves();
        _mint(msg.sender, 100000000000000000000000000);
    }

    // To receive BNB from dexRouter when swapping
    receive() external payable virtual {}

    // get contract owner address
    function getOwner() external view virtual returns (address) {
        return owner;
    }

    function doInitialApproves() internal virtual {
        _approve(
            msg.sender,
            dexRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            self(),
            dexRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
    }

    function initContracts() internal virtual {
        feesManager = new FeesManager();
        feesManager = new FeesManager();
        feesSplitManager = new FeesSplitManager();
    }

    function initValues() internal virtual {
        maxWalletAmount = type(uint256).max;
        maxTransactionAmount = type(uint256).max;

        // contract do swap when have 1000 tokens balance
        swapThreshold = 1000 ether;

        tradingEnabled = true;
    }

    function initAddressess() internal virtual {
        // set owner address (by default -> deployer address)
        owner = msg.sender;

        // few values needed for contract works
        DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD; // dead address for burn
    }

    function setRouter(address routerAddress) internal virtual onlyOwner {
        dexRouterManager = new DexRouterManager(routerAddress);
    }

    function createPair() internal virtual onlyOwner {
        lpPair = IUniswapV2Factory(dexRouterManager.getDexRouter().factory())
            .createPair(self(), dexRouterManager.getDexRouter().WETH());
    }

    // Set fees
    function setFees(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual onlyOwner {
        feesManager.setFees(buyFee, sellFee, transferFee);
    }

    // transfer owner
    function transferOwnership(address account) public virtual onlyOwner {
        owner = account;
    }

    // this function will be called every buy, sell or transfer
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        // check before each tx
        _beforeTransferCheck(from, to, amount);

        // if transaction are internal transfer when contract is swapping
        // transfer no fee
        if (dexRouterManager.isInSwap()) {
            super._transfer(from, to, amount);
            return;
        }

        // DO SWAP AND AUTOLIQUIDITY
        if (contractMustSwap(from, to)) {
            // SWAP
            // Get contract tokens balance
            uint256 numTokensToSwap = balanceOf(self());

            // swap tokens
            dexRouterManager.swapTokensForStableCoin(
                self(),
                (numTokensToSwap * 12) / 10000
            );

            // inject liquidity
            autoInjectLiquidity((numTokensToSwap * 123) / 10000);

            //burn((numTokensToSwap * autoLiquidityPercent) / masterTaxDivisor);

            // send eanring to team
        }

        _finalizeTransfer(from, to, amount);
    }

    function autoInjectLiquidity(uint256 tokenAmount) public {
        // split the contract balance into halves
        uint256 half = tokenAmount / 2;

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        dexRouterManager.swapTokensForBNB(self(), self(), half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        //dexRouterManager.addLiquidity(self(), owner, half, newBalance);
    }

    function contractMustSwap(address from, address to)
        internal
        view
        virtual
        returns (bool)
    {
        uint256 contractTokenBalance = balanceOf(self());
        return
            contractTokenBalance >= swapThreshold &&
            !dexRouterManager.isInSwap() &&
            from != lpPair &&
            balanceOf(lpPair) > 0 &&
            !feesManager.isExcludedFromFee(to) &&
            !feesManager.isExcludedFromFee(from);
    }

    function _finalizeTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        // by default receiver receive 100% of sended amount
        uint256 amountReceived = amount;
        uint256 feeAmount = 0; // received fee amount is zero

        // If takeFee is false there is 0% fee
        bool takeFee = true;
        if (
            feesManager.isExcludedFromFee(from) ||
            feesManager.isExcludedFromFee(to)
        ) {
            takeFee = false;
        }

        // check if we need take fee or not
        if (takeFee) {
            // if we need take fee
            // calc how much we need take
            //feeAmount = calcBuySellTransferFee(from, to, amount);

            // we substract fee amount from recipient amount
            amountReceived = amount - feeAmount;

            // and transfer fee to contract
            super._transfer(from, self(), feeAmount);
        }

        // finally send remaining tokens to recipient
        super._transfer(from, to, amountReceived);
    }

    function _beforeTransferCheck(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(
            from != address(0),
            "ERC20: transfer from the ZERO_ADDRESS address"
        );
        require(
            to != address(0),
            "ERC20: transfer to the ZERO_ADDRESS address"
        );
        require(
            amount > 0,
            "Transfer amount must be greater than ZERO_ADDRESS"
        );

        if (
            from != owner &&
            to != owner &&
            to != address(0) &&
            to != address(0xdead) &&
            !dexRouterManager.isInSwap()
        ) {
            require(tradingEnabled, "Trading not active");

            // BUY -> FROM == LP ADDRESS
            if (automatedMarketMakerPairs[from]) {
                require(
                    amount <= maxTransactionAmount,
                    "Buy transfer amount exceeds the maxTransactionAmount."
                );
                require(
                    amount + balanceOf(to) <= maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
            // SELL -> TO == LP ADDRESS
            else if (automatedMarketMakerPairs[to]) {
                require(
                    amount <= maxTransactionAmount,
                    "Sell transfer amount exceeds the maxTransactionAmount."
                );
            }
            // TRANSFER
            else {
                require(
                    amount + balanceOf(to) <= maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
        }
    }
}
