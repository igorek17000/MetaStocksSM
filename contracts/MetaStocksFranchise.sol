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
            MetaStocksFranchiseType.MetaStocksFranchiseType11
        ) {
            franchiseType = 10;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType12
        ) {
            franchiseType = 11;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType13
        ) {
            franchiseType = 12;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType14
        ) {
            franchiseType = 13;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType15
        ) {
            franchiseType = 14;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType16
        ) {
            franchiseType = 15;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType17
        ) {
            franchiseType = 16;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType18
        ) {
            franchiseType = 17;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType19
        ) {
            franchiseType = 18;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType20
        ) {
            franchiseType = 19;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType21
        ) {
            franchiseType = 20;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType22
        ) {
            franchiseType = 21;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType23
        ) {
            franchiseType = 22;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType24
        ) {
            franchiseType = 23;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType25
        ) {
            franchiseType = 24;
        } else if (
            _metaStocksFranchiseType ==
            MetaStocksFranchiseType.MetaStocksFranchiseType26
        ) {
            franchiseType = 25;
        } else {
            franchiseType = 0;
        }

        return franchiseType;
    }
}
