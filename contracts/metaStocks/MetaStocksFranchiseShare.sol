// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./../token/MidasCoreERC1155Upgradeable.sol";

contract MetaStocksFranchiseShare is MidasCoreERC1155Upgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function mintMetaStocksFranchiseShare(
        address MetaStocksFranchise,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(MetaStocksFranchise, id, amount, data);
    }

    function mintMetaStocksFranchiseShareBatch(
        address MetaStocksFranchise,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(MetaStocksFranchise, ids, amounts, data);
    }
}
