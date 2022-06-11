// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./enums/MetaStocksFranchiseType.sol";
import "./tokens/MetaStocksERC1155Upgradable.sol";

contract MetaStocksFranchise is MetaStocksERC1155Upgradable {
    function initialize() public virtual override initializer {
        super.initialize();
    }

    function getMetaStocksFranchiseType(
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external pure returns (uint256) {
        uint256 franchiseType = 0;

        if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType1
        ) {
            franchiseType = 0;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType2
        ) {
            franchiseType = 1;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType3
        ) {
            franchiseType = 2;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType4
        ) {
            franchiseType = 3;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType5
        ) {
            franchiseType = 4;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType6
        ) {
            franchiseType = 5;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType7
        ) {
            franchiseType = 6;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType8
        ) {
            franchiseType = 7;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType9
        ) {
            franchiseType = 8;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType10
        ) {
            franchiseType = 9;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType2
        ) {
            franchiseType = 10;
        } else {
            franchiseType = 0;
        }

        return franchiseType;
    }
}
