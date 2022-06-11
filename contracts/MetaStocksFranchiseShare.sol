// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./enums/MetaStocksFranchiseType.sol";
import "./tokens/MetaStocksERC1155Upgradable.sol";

contract MetaStocksFranchiseShare is MetaStocksERC1155Upgradable {
    function initialize() public virtual override initializer {
        super.initialize();
    }

    function burnMetaStocksFranchiseShare(
        address to,
        uint256 tokenId,
        uint256 amount
    ) external {
        super.burn(to, tokenId, amount);
    }
}
