// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../models/TransactionFees.sol";

contract FeesSplitPaymentManager {
    address private sendFeeTokenAddress;
    address[] private feesReceiversAddressess;
    uint256[] private feesReceiversPercentages;
    uint256 masterTaxDivisor;

    constructor() {
        feesReceiversAddressess = new address[](10);
        feesReceiversPercentages = new uint256[](10);
        masterTaxDivisor = 10000;
    }

    function feesReceiver(
        address _feesReceiverAddress,
        uint256 _feesReceiverPercentage
    ) internal virtual {
        feesReceiversAddressess.push(_feesReceiverAddress);
        feesReceiversPercentages.push(_feesReceiverPercentage);
    }

    function sendFees(address from, address _sendFeeTokenAddress)
        internal
        virtual
    {
        for (
            uint256 index = 0;
            index < feesReceiversAddressess.length;
            index++
        ) {
            IERC20(_sendFeeTokenAddress).transferFrom(
                from,
                feesReceiversAddressess[index],
                feesReceiversPercentages[index]
            );
        }
    }
}
