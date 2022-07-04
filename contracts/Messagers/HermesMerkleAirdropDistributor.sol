/*

Egyptian god of infinite generosity

*/

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract HermesMerkleAirdropDistributor {
    using SafeERC20 for IERC20;

    address public immutable token;
    bytes32 public immutable merkleRoot;

    mapping(address => bool) public claimed;

    event Claim(address indexed claimer);

    constructor(address _token, bytes32 _merkleRoot) {
        token = _token;
        merkleRoot = _merkleRoot;
    }

    // claim tokens
    function claimGodsOfferings(bytes32[] calldata merkleProof) external {
        require(
            isBlessed(msg.sender, merkleProof),
            "MerkleAirdrop: Address is not a candidate for claim"
        );

        claimed[msg.sender] = true;

        IERC20(token).safeTransfer(msg.sender, 1 ether);

        emit Claim(msg.sender);
    }

    // can claim
    function isBlessed(address claimer, bytes32[] calldata merkleProof)
        public
        view
        returns (bool)
    {
        return
            !claimed[claimer] &&
            MerkleProof.verify(
                merkleProof,
                merkleRoot,
                keccak256(abi.encodePacked(claimer))
            );
    }
}
