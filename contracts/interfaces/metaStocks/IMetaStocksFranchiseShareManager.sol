// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "../../enums/MetaStocksFranchiseType.sol";

interface IMetaStocksFranchiseShareManager {
    function createMetaStocksFranchise(
        address to,
        uint256 companyId,
        MetaStocksFranchiseType _metaStocksFranchiseType,
        bytes memory data
    ) external;
}
