// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IMetaStockCompany {
    function createFranchise() external payable;

    function safeMint(address to) external;

    function createMetaStockCompany(address to) external returns (uint256);
}
