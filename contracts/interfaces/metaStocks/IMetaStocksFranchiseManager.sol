// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "../../enums/MetaStocksFranchiseType.sol";

interface IMetaStocksFranchiseManager {
    function createMetaStocksFranchise(
        address to,
        uint256 companyId,
        uint256 _continentId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external;

    function createMetaStocksFranchiseUsingBNB(
        address to,
        uint256 companyId,
        uint256 _continentId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external payable;
}
