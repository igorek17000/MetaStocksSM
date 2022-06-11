// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IMetaStocksCompany {
    function getCompany(address _account) external view returns (uint256);

    function isCeo(address _account) external view returns (bool);

    function create() external payable;

    function update(uint256 managerId) external;

    function remove(uint256 companyId) external;

    function safeMint(address to) external returns (uint256);
}
