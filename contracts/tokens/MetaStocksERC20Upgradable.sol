// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./../managers/transactionFees/TransactionFeesManager.sol";
import "./../managers/midas/MidasMultinetworkRouterManager.sol";

contract MetaStocksERC20Upgradable is ERC20Upgradeable, OwnableUpgradeable {
    // ADDRESSESS -------------------------------------------------------------------------------------------
    address private DEAD_ADDRESS; // DEAD Address for burn tokens
    address private lpPair; // Liquidity token address
    uint256 private swapThreshold; // swap tokens limit
    uint256 private maxWalletAmount; // max balance amount (Anti-whale)
    uint256 private maxTransactionAmount; // max balance amount (Anti-whale)
    bool private tradingEnabled;
    bool private swapEnabled;

    TransactionFeesManager private transactionFeesManager;
    //FeesSplitManager private feesSplitManager;
    MidasMultinetworkRouterManager private midasMultinetworkRouterManager;

    mapping(address => bool) public automatedMarketMakerPairs;

    // EVENTS -----------------------------------------------------------------------------------------------
    event Burn(address indexed sender, uint256 amount);

    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize(
        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _totalSupply
    ) public virtual initializer {
        __ERC20_init(_tokenName, _tokenSymbol);
        initializeContract();
        _mint(msg.sender, _totalSupply);
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function initializeContract() internal virtual {
        maxWalletAmount = type(uint256).max;
        maxTransactionAmount = type(uint256).max;
        swapThreshold = 1000 ether;
        DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
        lpPair = 0x0000000000000000000000000000000000000000;
        swapEnabled = false;
        transactionFeesManager = new TransactionFeesManager();
        transactionFeesManager.setExcludedFromFee(owner(), true);
        //setFeesSplitManager(new FeesSplitManager());
    }

    function doInitialApproves() internal virtual {
        _approve(
            msg.sender,
            midasMultinetworkRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            self(),
            midasMultinetworkRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
    }

    function _finalizeTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        // by default receiver receive 100% of sended amount
        uint256 feeAmount = 0; // received fee amount is zero

        // if we need take fee
        // calc how much we need take
        feeAmount = transactionFeesManager.calcBuySellTransferFee(
            lpPair,
            from,
            to,
            amount
        );

        if (feeAmount > 0) {
            super._transfer(from, self(), feeAmount);
        }

        // finally send remaining tokens to recipient
        super._transfer(from, to, amount - feeAmount);
    }

    function setRouterAddress(
        address _routerAddress,
        address _chainlinkDataFeedAddress
    ) public {
        midasMultinetworkRouterManager = new MidasMultinetworkRouterManager(
            _routerAddress,
            _chainlinkDataFeedAddress
        );
        _approve(self(), _routerAddress, type(uint256).max);

        doInitialApproves();
    }

    function contractMustSwap(address from, address to)
        internal
        view
        virtual
        returns (bool)
    {
        uint256 contractTokenBalance = balanceOf(self());
        return
            swapEnabled &&
            contractTokenBalance >= getSwapThreshold() &&
            !midasMultinetworkRouterManager.isInSwap() &&
            from != getLPPair() &&
            balanceOf(getLPPair()) > 0 &&
            !transactionFeesManager.isExcludedFromFee(to) &&
            !transactionFeesManager.isExcludedFromFee(from);
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
            from != super.owner() &&
            to != super.owner() &&
            to != address(0) &&
            to != address(0xdead) &&
            !midasMultinetworkRouterManager.isInSwap()
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
        //_beforeTransferCheck(from, to, amount);

        // if transaction are internal transfer when contract is swapping
        // transfer no fee
        if (midasMultinetworkRouterManager.isInSwap()) {
            super._transfer(from, to, amount);
            return;
        }

        // DO SWAP AND AUTOLIQUIDITY
        if (contractMustSwap(from, to)) {
            // SWAP
            // Get contract tokens balance
            uint256 numTokensToSwap = balanceOf(self());

            // swap tokens
            midasMultinetworkRouterManager.swapTokensForStableCoin(
                self(),
                owner(),
                numTokensToSwap
            );

            // inject liquidity
            //autoInjectLiquidity((numTokensToSwap * 123) / 10000);

            //burn((numTokensToSwap * autoLiquidityPercent) / masterTaxDivisor);

            // send eanring to team
        }

        _finalizeTransfer(from, to, amount);
    }

    // To receive BNB from dexRouter when swapping
    receive() external payable virtual {}

    /**
     * @dev Enable trading (swap) and set initial block
     */
    function enableTrading() public {
        require(!tradingEnabled, "Trading already enabled!");
        tradingEnabled = true;
    }

    function enableSwapEnabled(bool val) public {
        swapEnabled = val;
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

    function setTransactionFeesManager(
        TransactionFeesManager _transactionFeesManager
    ) public virtual {
        transactionFeesManager = _transactionFeesManager;
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

    function getTransactionFeesManager()
        public
        view
        virtual
        returns (TransactionFeesManager)
    {
        return transactionFeesManager;
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

    function getMidasMultinetworkRouterManager()
        public
        view
        virtual
        returns (MidasMultinetworkRouterManager)
    {
        return midasMultinetworkRouterManager;
    }

    // Set fees
    function setFees(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual {
        transactionFeesManager.setFees(buyFee, sellFee, transferFee);
    }

    function setPairAddress(address _pairAddress) public virtual {
        lpPair = _pairAddress;
        automatedMarketMakerPairs[_pairAddress];
    }
}
