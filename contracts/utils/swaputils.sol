// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

function calcBuySellTransferFee(
    mapping(address => bool) automatedMarketMakerPairs,
    address from,
    address to,
    uint256 amount
) internal view virtual returns (uint256) {
    // by default we take zero fee
    uint256 totalFeePercent = 0;
    uint256 feeAmount = 0;

    // BUY -> FROM == LP ADDRESS
    if (automatedMarketMakerPairs[from]) {
        totalFeePercent += _feesRates.buyFee;
    }
    // SELL -> TO == LP ADDRESS
    else if (automatedMarketMakerPairs[to]) {
        totalFeePercent += _feesRates.sellFee;
    }
    // TRANSFER
    else {
        totalFeePercent += _feesRates.transferFee;
    }

    // CALC FEES AMOUT
    if (totalFeePercent > 0) {
        feeAmount = (amount * totalFeePercent) / masterTaxDivisor;
    }

    return feeAmount;
}
