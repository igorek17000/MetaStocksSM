// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IMetaStocksManager {
    function getManager() external view returns (address);

    function createManager() external payable;

    function updateManager() external;

    function deleteManager() external;
}
