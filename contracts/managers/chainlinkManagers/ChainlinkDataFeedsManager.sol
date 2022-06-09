// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";

contract ChainlinkDataFeedsManager {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        priceFeed = AggregatorV3Interface(
            0x0A77230d17318075983913bC2145DB16C7366156
        ); // AVAX / USDT
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

    function getTokensValueInUSD(uint256 _amount, IUniswapV2Router02 dexRouter)
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
