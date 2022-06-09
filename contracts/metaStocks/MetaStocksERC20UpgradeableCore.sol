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

abstract contract MetaStocksERC20UpgradeableCore {
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

    mapping(address => bool) public automatedMarketMakerPairs;

    // EVENTS -----------------------------------------------------------------------------------------------
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    event Burn(address indexed sender, uint256 amount);

    // To receive BNB from dexRouter when swapping
    receive() external payable virtual {}

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function getOwner() public view virtual returns (address) {
        return owner;
    }

    function transferOwnership(address account) public virtual onlyOwner {
        owner = account;
    }

    function setDeadAddress() public virtual onlyOwner {
        DEAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    }

    /**
     * @dev Enable trading (swap) and set initial block
     */
    function enableTrading() public onlyOwner {
        require(!tradingEnabled, "Trading already enabled!");
        tradingEnabled = true;
    }

    function setSwapThreshold(uint256 _swapThreshold) public virtual {
        swapThreshold = _swapThreshold;
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

    function setFeesSplitManager(FeesSplitManager _feesSplitManager)
        public
        virtual
    {
        feesSplitManager = _feesSplitManager;
    }

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

    function getFeesSplitManager()
        public
        view
        virtual
        returns (FeesSplitManager)
    {
        return feesSplitManager;
    }

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
    ) external virtual onlyOwner {
        feesManager.setFees(buyFee, sellFee, transferFee);
    }

    function createPair(address tokenA, address tokenB)
        internal
        virtual
        onlyOwner
    {
        lpPair = IUniswapV2Factory(dexRouterManager.getDexRouter().factory())
            .createPair(tokenA, tokenB);
    }

    function setRouter(address routerAddress) internal virtual onlyOwner {
        dexRouterManager = new DexRouterManager(routerAddress);
    }
}
