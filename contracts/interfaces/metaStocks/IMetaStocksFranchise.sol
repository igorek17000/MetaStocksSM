// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
import "../../enums/MetaStocksFranchiseType.sol";

interface IMetaStocksFranchise {
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;

    function safeMint(address to) external returns (uint256);

    function getMetaStocksFranchiseType(
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external pure returns (uint256);

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;
}
