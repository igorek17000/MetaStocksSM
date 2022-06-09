// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./managers/feesManagers/FeesManager.sol";
import "./interfaces/dexRouterInterfaces/IAutoLiquidityInjecter.sol";
//import "./../managers/feesManagers/FeesSplitManager.sol";
import "./managers/DexRouterManager.sol";

contract MetaStocks is ERC20Upgradeable {
    // ADDRESSESS -------------------------------------------------------------------------------------------
    address private owner; // contract owner
    address private DEAD_ADDRESS; // DEAD Address for burn tokens
    address private lpPair; // Liquidity token address
    uint256 private swapThreshold; // swap tokens limit
    uint256 private maxWalletAmount; // max balance amount (Anti-whale)
    uint256 private maxTransactionAmount; // max balance amount (Anti-whale)
    bool private tradingEnabled;

    FeesManager private feesManager;
    //FeesSplitManager private feesSplitManager;
    DexRouterManager private dexRouterManager;

    mapping(address => bool) public automatedMarketMakerPairs;

    // EVENTS -----------------------------------------------------------------------------------------------
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Burn(address indexed sender, uint256 amount);

    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize() public virtual initializer {
        __ERC20_init("MetaStocks", "MST");
        initializeContract();
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function initializeContract() internal virtual {
        initAddressess();
        initContracts();
        //initRouter();
        //setRouter(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3);
        //doInitialApproves();
        _mint(msg.sender, 100000000000000000000000000);
    }

    function doInitialApproves() internal virtual {
        _approve(
            msg.sender,
            getDexRouterManager().getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            self(),
            getDexRouterManager().getDexRouterAddress(),
            type(uint256).max
        );
    }

    function initRouter() internal virtual {
        setDexRouter(0x2D99ABD9008Dc933ff5c0CD271B88309593aB921);
    }

    function initContracts() internal virtual {
        setFeesManager(new FeesManager());
        //setFeesSplitManager(new FeesSplitManager());
    }

    function initValues() internal virtual {
        setMaxWalletAmount(type(uint256).max);
        setMaxTransactionAmount(type(uint256).max);
        setSwapThreshold(1000 ether);
    }

    function initAddressess() internal virtual {
        owner = msg.sender;
        DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
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
            getFeesManager().isExcludedFromFee(from) ||
            getFeesManager().isExcludedFromFee(to)
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

    function contractMustSwap(address from, address to)
        internal
        view
        virtual
        returns (bool)
    {
        uint256 contractTokenBalance = balanceOf(self());
        return
            contractTokenBalance >= getSwapThreshold() &&
            !getDexRouterManager().isInSwap() &&
            from != getLPPair() &&
            balanceOf(getLPPair()) > 0 &&
            !getFeesManager().isExcludedFromFee(to) &&
            !getFeesManager().isExcludedFromFee(from);
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
        getDexRouterManager().swapTokensForNativeToken(self(), self(), half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        getDexRouterManager().addLiquidity(
            self(),
            getOwner(),
            half,
            newBalance
        );
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
            from != getOwner() &&
            to != getOwner() &&
            to != address(0) &&
            to != address(0xdead) &&
            !getDexRouterManager().isInSwap()
        ) {
            require(getTradingEnabled(), "Trading not active");

            /*
            // BUY -> FROM == LP ADDRESS
            if (super.automatedMarketMakerPairs[from]) {
                require(
                    amount <= super.maxTransactionAmount,
                    "Buy transfer amount exceeds the maxTransactionAmount."
                );
                require(
                    amount + balanceOf(to) <= super.maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
            // SELL -> TO == LP ADDRESS
            else if (super.automatedMarketMakerPairs[to]) {
                require(
                    amount <= super.maxTransactionAmount,
                    "Sell transfer amount exceeds the maxTransactionAmount."
                );
            }
            // TRANSFER
            else {
                require(
                    amount + balanceOf(to) <= super.maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
            */
        }
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
        if (getDexRouterManager().isInSwap()) {
            _transfer(from, to, amount);
            return;
        }

        // DO SWAP AND AUTOLIQUIDITY
        if (contractMustSwap(from, to)) {
            // SWAP
            // Get contract tokens balance
            uint256 numTokensToSwap = balanceOf(self());

            // swap tokens
            getDexRouterManager().swapTokensForStableCoin(
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

    // To receive BNB from dexRouter when swapping
    receive() external payable virtual {}

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function getOwner() public view virtual returns (address) {
        return owner;
    }

    function transferOwnership(address account) public virtual {
        owner = account;
    }

    function setDeadAddress() public virtual {
        DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    }

    /**
     * @dev Enable trading (swap) and set initial block
     */
    function enableTrading() public {
        require(!tradingEnabled, "Trading already enabled!");
        tradingEnabled = true;
    }

    function setSwapThreshold(uint256 _swapThreshold) public virtual {
        swapThreshold = _swapThreshold;
    }

    function setlpPair(address _lpPair) public virtual {
        lpPair = _lpPair;
        automatedMarketMakerPairs[_lpPair] = true;
    }

    function setMaxWalletAmount(uint256 _maxWalletAmount) public virtual {
        maxWalletAmount = _maxWalletAmount;
    }

    function setMaxTransactionAmount(uint256 _maxTransactionAmount)
        public
        virtual
    {
        maxTransactionAmount = _maxTransactionAmount;
    }

    function setFeesManager(FeesManager _feesManager) public virtual {
        feesManager = _feesManager;
    }

    /*
    function setFeesSplitManager(FeesSplitManager _feesSplitManager)
        public
        virtual
    {
        feesSplitManager = _feesSplitManager;
    }
    */

    function getSwapThreshold() public view virtual returns (uint256) {
        return swapThreshold;
    }

    function getLPPair() public view virtual returns (address) {
        return lpPair;
    }

    function getTradingEnabled() public view virtual returns (bool) {
        return tradingEnabled;
    }

    function getFeesManager() public view virtual returns (FeesManager) {
        return feesManager;
    }

    /*
    function getFeesSplitManager()
        public
        view
        virtual
        returns (FeesSplitManager)
    {
        return feesSplitManager;
    }
    */

    function getDexRouterManager()
        public
        view
        virtual
        returns (DexRouterManager)
    {
        return dexRouterManager;
    }

    // Set fees
    function setFees(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual {
        feesManager.setFees(buyFee, sellFee, transferFee);
    }

    function setPairAddress(address _pairAddress) public virtual {
        lpPair = _pairAddress;
        automatedMarketMakerPairs[_pairAddress];
    }

    function setDexRouter(address _dexRouter) public virtual {
        dexRouterManager.setDexRouter(_dexRouter);
    }
}
