// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../interfaces/dexRouterInterfaces/IMetaStocksMultiDexRouter.sol";

contract ChainlinkDataFeedsManager {
    AggregatorV3Interface internal priceFeed;

    constructor(address _priceFeedAddress) {
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    /**
     * Returns the latest price
     */
    function getLatestPriceFromChainlink() public view returns (int256) {
        (
            ,
            /*uint80 roundID*/
            int256 price, /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/
            ,
            ,

        ) = priceFeed.latestRoundData();
        return price;
    }

    function getTokensValueInUSD(
        address _tokenAddress,
        uint256 _amount,
        IUniswapV2Router02 dexRouter
    ) public view returns (uint256) {
        uint256 avaxPrice = uint256(getLatestPriceFromChainlink()) * 1e10;
        address[] memory path = new address[](2);
        path[0] = _tokenAddress;
        path[1] = dexRouter.WETH();
        uint256[] memory amountsOut = dexRouter.getAmountsOut(_amount, path);
        uint256 tokenAmount = amountsOut[1];
        return (avaxPrice * tokenAmount) / 1000000000000000000;
    }

    function getAvaxPriceInUsd() external view returns (uint256) {
        return uint256(getLatestPriceFromChainlink()) * 1e10;
    }

    function getAmountOutUSD(uint256 _amount, IUniswapV2Router02 dexRouter)
        public
        view
        returns (uint256)
    {
        uint256 avaxPrice = uint256(getLatestPriceFromChainlink()) * 1e10;
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = dexRouter.WETH();
        uint256[] memory amountsOut = dexRouter.getAmountsOut(_amount, path);
        uint256 tokenAmount = amountsOut[1];

        return (avaxPrice * tokenAmount) / 1000000000000000000;
    }
}
