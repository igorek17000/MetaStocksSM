// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../models/TransactionFees.sol";

contract FeesManager {
    TransactionFees private txFees;
    uint256 private masterTaxDivisor;
    //address[] private feesReceivers;
    //uint256[] private feesReceiversPercentages;
    mapping(address => bool) private _isExcludedFromFee; // list of users excluded from fee

    constructor() {
        //feesReceivers = new address[](10);
        //feesReceiversPercentages = new uint256[](10);
        masterTaxDivisor = 10000;
        txFees = TransactionFees({buyFee: 0, sellFee: 0, transferFee: 0});
    }

    /*
    function addFeesReceiverWithPercentage(
        address feesReceiverAddress,
        uint256 feesReceiverPercentage
    ) external virtual {
        feesReceivers.push(feesReceiverAddress);
        feesReceiversPercentages.push(feesReceiverPercentage);
    }
    */

    function isExcludedFromFee(address account)
        external
        view
        virtual
        returns (bool)
    {
        _isExcludedFromFee[account];
    }

    function calcBuySellTransferFee(
        address lpPairAddress,
        address from,
        address to,
        uint256 amount
    ) internal view virtual returns (uint256) {
        // by default we take zero fee
        uint256 totalFeePercent = 0;
        uint256 feeAmount = 0;

        // BUY -> FROM == LP ADDRESS
        if (from == lpPairAddress) {
            totalFeePercent += txFees.buyFee;
        }
        // SELL -> TO == LP ADDRESS
        else if (to == lpPairAddress) {
            totalFeePercent += txFees.sellFee;
        }
        // TRANSFER
        else {
            totalFeePercent += txFees.transferFee;
        }

        // CALC FEES AMOUT
        if (totalFeePercent > 0) {
            feeAmount = (amount * totalFeePercent) / masterTaxDivisor;
        }

        return feeAmount;
    }

    // Set fees
    function setFees(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual {
        txFees.buyFee = buyFee;
        txFees.sellFee = sellFee;
        txFees.transferFee = transferFee;
    }
}
