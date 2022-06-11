// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract ChainlinkVRFManager {
    VRFCoordinatorV2Interface private COORDINATOR;
    uint64 private subscriptionId;
    bytes32 private keyHash;
    uint256 private requestId;

    constructor(
        address _VRFCoordinatorAddress,
        uint64 _subscriptionId,
        bytes32 _keyHash
    ) {
        COORDINATOR = VRFCoordinatorV2Interface(_VRFCoordinatorAddress);
        subscriptionId = _subscriptionId;
        keyHash = _keyHash;
    }

    function rawFulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) external {
        if (msg.sender == address(COORDINATOR)) {
            fulfillRandomWords(_requestId, _randomWords);
        }
    }

    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal {
        //randomWords[0];
    }

    function requestRandomWords() internal {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subscriptionId,
            5,
            100000,
            1
        );
    }
}
