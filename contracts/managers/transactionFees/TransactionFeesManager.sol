// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "./../../models/TransactionFees.sol";

contract TransactionFeesManager {
    TransactionFees private txFees;
    uint256 private masterTaxDivisor;
    mapping(address => bool) private _isExcludedFromFee; // list of users excluded from fee

    // default fees
    // 0% on BUY
    // 0% on SELL
    // 0% on Transfer
    constructor() {
        masterTaxDivisor = 10000;
        txFees = TransactionFees({buyFee: 0, sellFee: 0, transferFee: 0});
    }

    // Set fees
    function setExcludedFromFee(address account, bool val) external virtual {
        _isExcludedFromFee[account] = val;
    }

    function isExcludedFromFee(address account)
        public
        view
        virtual
        returns (bool)
    {
        return _isExcludedFromFee[account];
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

    function calcBuySellTransferFee(
        address lpPairAddress,
        address from,
        address to,
        uint256 amount
    ) external view virtual returns (uint256) {
        // by default we take zero fee
        uint256 totalFeePercent = 0;
        uint256 feeAmount = 0;

        if (isExcludedFromFee(from) || isExcludedFromFee(to)) {
            return 0;
        }

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
}
