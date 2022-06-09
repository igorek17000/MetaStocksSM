// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../models/TransactionFees.sol";
import "../models/FeeReceiver.sol";

contract FeesSplitManager {
    address private sendFeeTokenAddress;
    FeeReceiver[] private feesReceiversList;
    mapping(address => bool) private feeReceiversMapping;
    uint256 private masterTaxDivisor;

    constructor() {
        feesReceiversList = new FeeReceiver[](10);
        masterTaxDivisor = 10000;
    }

    function getFeesReceiver(address _feesReceiverAddress)
        internal
        virtual
        returns (address)
    {
        for (uint256 index = 0; index < feesReceiversList.length; index++) {
            if (feesReceiversList.receiver == _feesReceiverAddress) {
                return _feesReceiverAddress;
            }
        }
        return address(0);
    }

    function addFeesReceiver(FeeReceiver memory _feeReceiver) internal virtual {
        feesReceiversList.push(_feeReceiver);
    }

    function updateFeesReceiver(FeeReceiver memory _feeReceiver)
        internal
        virtual
    {
        feesReceiversList.push(_feeReceiver);
    }

    function removeFeesReceiver(FeeReceiver memory _feeReceiver)
        internal
        virtual
    {
        feesReceiversList.push(_feeReceiver);
    }

    function sendFees(address from, address _sendFeeTokenAddress)
        internal
        virtual
    {
        for (uint256 index = 0; index < feesReceiversList.length; index++) {
            IERC20(_sendFeeTokenAddress).transferFrom(
                from,
                feesReceiversList[index].receiver,
                feesReceiversList[index].percentage
            );
        }
    }
}
