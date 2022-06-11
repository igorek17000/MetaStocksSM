// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./tokens/MetaStocksERC1155Upgradable.sol";

contract MetaStocksFranchiseShare is MetaStocksERC1155Upgradable {
    function initialize() public virtual override initializer {
        super.initialize();
    }

    function getTest() external pure returns (uint256) {
        return 0;
    }
}
