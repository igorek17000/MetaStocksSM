// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "../../interfaces/midas/IMidasMultiNetworkRouter.sol";

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
        uint256 _network,
        IMidasMultiNetworkRouter midasMultiNetworkRouter
    ) public view returns (uint256) {
        uint256 nativeNetworkCurrencyPrice = uint256(
            getLatestPriceFromChainlink()
        ) * 1e10;
        address[] memory path = new address[](2);
        path[0] = _tokenAddress;
        path[1] = midasMultiNetworkRouter.getNativeNetworkCurrencyAddress(
            _network
        );
        uint256[] memory amountsOut = midasMultiNetworkRouter.getAmountsOut(
            _amount,
            path
        );
        uint256 tokenAmount = amountsOut[1];
        return (nativeNetworkCurrencyPrice * tokenAmount) / 1000000000000000000;
    }

    function getNativeNetworkCurrencyInUsd() external view returns (uint256) {
        return uint256(getLatestPriceFromChainlink()) * 1e10;
    }

    function getAmountOutUSD(
        uint256 _amount,
        IMidasMultiNetworkRouter dexRouter
    ) public view returns (uint256) {
        uint256 nativeNetworkCurrencyPrice = uint256(
            getLatestPriceFromChainlink()
        ) * 1e10;
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = dexRouter.WETH();
        uint256[] memory amountsOut = dexRouter.getAmountsOut(_amount, path);
        uint256 tokenAmount = amountsOut[1];

        return (nativeNetworkCurrencyPrice * tokenAmount) / 1000000000000000000;
    }
}
