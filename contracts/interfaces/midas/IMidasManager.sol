// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IMidasManager {
    function get(address _account) external view returns (address);

    function create() external payable;

    function update(uint256 managerId) external;

    function remove(uint256 managerId) external;
}
