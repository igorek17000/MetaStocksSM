// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./managers/FeesManager.sol";
import "./managers/DexRouterManager.sol";

/*
Token
	Buy 0
	Sell 2 %
	Transfer 0
	
Swap threshold -> 100$ = 100%    
treasury 40% ->  40$
dev team 1       20%
marketing team 2 20%
auto lp           5%
auto buybackburn  5%

Create 10
reward al dia 0.1
claim fee 25%
*/

contract MetaStocks is ERC20Upgradeable {
    // ADDRESSESS -------------------------------------------------------------------------------------------
    address public owner; // contract owner
    address public DEAD; // DEAD Address for burn tokens
    address public lpPair; // Liquidity token address
    address public swapTokenAddress; // tokens who contract will receive after swap
    address public marketingAddress; // fee wallet address

    // split earning addresses
    address w1Address; // nkt
    address w2Address; // drg
    address w3Address; // diamont
    address w4Address; // smiley
    address w5Address; // forever

    // VALUES -----------------------------------------------------------------------------------------------
    uint256 public swapThreshold; // swap tokens limit
    uint256 maxWalletAmount; // max balance amount (Anti-whale)
    uint256 marketingAddressPercent;
    uint256 autoLiquidityPercent;
    uint256 autoBurnPercent;
    uint256 maxTransactionAmount;

    // split earning percents
    uint256 w1Percent;
    uint256 w2Percent;
    uint256 w3Percent;
    uint256 w4Percent;
    uint256 w5Percent;

    // BOOLEANS ---------------------------------------------------------------------------------------------
    bool inSwap; // used for dont take fee on swaps
    bool tradingEnabled;

    // MAPPINGS
    mapping(address => bool) private _isExcludedFromFee; // list of users excluded from fee
    mapping(address => bool) public automatedMarketMakerPairs;

    FeesManager feesManager;
    DexRouterManager dexRouterManager;

    // EVENTS -----------------------------------------------------------------------------------------------
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Burn(address indexed sender, uint256 amount);

    // MODIFIERS --------------------------------------------------------------------------------------------
    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize() public initializer {
        __ERC20_init("MetaStocks", "MST");
        initializeContract();
    }

    function initializeContract() internal virtual {
        w1Address = 0x6644ebDE0f26c8F74AD18697cce8A5aC4e608cB4;
        w2Address = 0x6644ebDE0f26c8F74AD18697cce8A5aC4e608cB4;
        w3Address = 0x5A97e36aEF195CB7519fc8dfE77bB646AfA805b6;
        w4Address = 0x6644ebDE0f26c8F74AD18697cce8A5aC4e608cB4;
        w5Address = 0x6644ebDE0f26c8F74AD18697cce8A5aC4e608cB4;

        w1Percent = 0;
        w2Percent = 0;
        w3Percent = 0;
        w4Percent = 0;
        w5Percent = 0;

        // mint tokens to deployer
        _mint(msg.sender, 100000000000000000000000000);

        maxWalletAmount = 1000000000000000000000000;
        maxTransactionAmount = 1000000000000000000000000;

        // set owner address (by default -> deployer address)
        owner = msg.sender;

        // marketing address
        marketingAddress = 0x6644ebDE0f26c8F74AD18697cce8A5aC4e608cB4;

        // default fees
        // 3% on BUY
        // 3% on SELL
        // 0% on Transfer
        feesManager = new FeesManager(0, 0, 0);

        // swap tokens for usdt
        swapTokenAddress = 0x78867BbEeF44f2326bF8DDd1941a4439382EF2A7;

        // exclude from fees
        // owner, token and marketing address
        _isExcludedFromFee[owner] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[marketingAddress] = true;
        _isExcludedFromFee[swapTokenAddress] = true;

        // contract do swap when have 1M tokens balance
        swapThreshold = 1000000000000000000000000;

        marketingAddressPercent = 7000; //70%
        autoLiquidityPercent = 3000; //30%
        autoLiquidityPercent = 3000; //30%

        // Set Router Address (Pancake by default)
        dexRouterManager = new DexRouterManager(
            0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3,
            0x78867BbEeF44f2326bF8DDd1941a4439382EF2A7
        );

        // Create a uniswap pair for this new token
        lpPair = IUniswapV2Factory(dexRouterManager.getDexRouter().factory())
            .createPair(address(this), dexRouterManager.getDexRouter().WETH());
        automatedMarketMakerPairs[lpPair] = true;

        // do approve to router from owner and contract
        _approve(
            msg.sender,
            dexRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            address(this),
            dexRouterManager.getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            swapTokenAddress,
            dexRouterManager.getDexRouterAddress(),
            type(uint256).max
        );

        // few values needed for contract works
        DEAD = 0x000000000000000000000000000000000000dEaD; // dead address for burn
    }

    // To receive BNB from dexRouter when swapping
    receive() external payable virtual {}

    // get contract owner address
    function getOwner() external view virtual returns (address) {
        return owner;
    }

    // Set fees
    function setTaxes(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual onlyOwner {
        feesManager.setTaxes(buyFee, sellFee, transferFee);
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
        if (inSwap) {
            super._transfer(from, to, amount);
            return;
        }

        // DO SWAP AND AUTOLIQUIDITY
        if (contractMustSwap(from, to)) {
            // SWAP
            // Get contract tokens balance
            uint256 numTokensToSwap = balanceOf(address(this));

            // swap tokens
            /*
            swapTokensForUSD(
                (numTokensToSwap * marketingAddressPercent) / masterTaxDivisor
            );
         

            // inject liquidity
            autoLiquidity(
                (numTokensToSwap * autoLiquidityPercent) / masterTaxDivisor
            );
               */

            //burn((numTokensToSwap * autoLiquidityPercent) / masterTaxDivisor);

            // send eanring to team
        }

        _finalizeTransfer(from, to, amount);
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
        if (_isExcludedFromFee[from] || _isExcludedFromFee[to]) {
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
            super._transfer(from, address(this), feeAmount);
        }

        // finally send remaining tokens to recipient
        super._transfer(from, to, amountReceived);
    }

    function autoLiquidity(uint256 tokenAmount) public {
        // split the contract balance into halves
        uint256 half = tokenAmount / 2;

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        //swapTokensForBNB(half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        //addLiquidity(half, newBalance);
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
            !inSwap
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

    function contractMustSwap(address from, address to)
        internal
        view
        virtual
        returns (bool)
    {
        uint256 contractTokenBalance = balanceOf(address(this));
        return
            contractTokenBalance >= swapThreshold &&
            !inSwap &&
            from != lpPair &&
            balanceOf(lpPair) > 0 &&
            !_isExcludedFromFee[to] &&
            !_isExcludedFromFee[from];
    }

    function burn(uint256 amount) public virtual {
        require(amount >= 0, "Burn amount should be greater than ZERO_ADDRESS");

        require(
            amount <= balanceOf(msg.sender),
            "Burn amount should be less than account balance"
        );

        super._burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }

    function setMarketingAddress(address account) public virtual onlyOwner {
        marketingAddress = account;
    }

    function isExcludedFromFee(address account)
        public
        view
        virtual
        returns (bool)
    {
        return _isExcludedFromFee[account];
    }

    function excludeFromFee(address account, bool val)
        public
        virtual
        onlyOwner
    {
        _isExcludedFromFee[account] = val;
    }

    function setSwapThreshold(uint256 value) public virtual onlyOwner {
        swapThreshold = value;
    }

    function setMaxWalletAmount(uint256 value) public virtual onlyOwner {
        maxWalletAmount = value;
    }

    function setMaxTransactionAmount(uint256 value) public virtual onlyOwner {
        maxTransactionAmount = value;
    }

    function enableTrading() public virtual onlyOwner {
        require(tradingEnabled == false, "TradingEnabled already actived");
        tradingEnabled = true;
    }

    function setMarketingAddressPercent(uint256 value)
        public
        virtual
        onlyOwner
    {
        marketingAddressPercent = value;
    }

    function setAutoLiquidityPercentPercent(uint256 value)
        public
        virtual
        onlyOwner
    {
        autoLiquidityPercent = value;
    }

    function setW1(address newAddress) public virtual {
        require(w1Address == newAddress, "w1Address");
        w1Address = newAddress;
    }

    function setW2(address newAddress) public virtual {
        require(
            w1Percent >= 0,
            "Burn amount should be greater than ZERO_ADDRESS"
        );
    }

    function setW3(address newAddress) public virtual {
        require(
            w1Percent >= 0,
            "Burn amount should be greater than ZERO_ADDRESS"
        );
    }

    function setW4(address newAddress) public virtual {
        require(
            w1Percent >= 0,
            "Burn amount should be greater than ZERO_ADDRESS"
        );
    }

    function setW5(address newAddress) public virtual {
        require(
            w1Percent >= 0,
            "Burn amount should be greater than ZERO_ADDRESS"
        );
    }
}
