// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/AggregatorV3Interface.sol";
import "../models/TransactionFees.sol";

contract FeesManager {
    TransactionFees private txFees;
    uint256 private masterTaxDivisor;

    constructor(
        uint16 _buyFee,
        uint16 _sellFee,
        uint16 _transferFee
    ) {
        masterTaxDivisor = 10000;
        txFees = TransactionFees({
            buyFee: _buyFee,
            sellFee: _sellFee,
            transferFee: _transferFee
        });
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
    function setTaxes(
        uint16 buyFee,
        uint16 sellFee,
        uint16 transferFee
    ) external virtual {
        txFees.buyFee = buyFee;
        txFees.sellFee = sellFee;
        txFees.transferFee = transferFee;
    }
}
