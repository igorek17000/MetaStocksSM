// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./MetaStock1155.sol";

contract MetaStockFranchiseShare is MetaStock1155 {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function mintMetaStockFranchiseShare(
        address metaStockFranchise,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(metaStockFranchise, id, amount, data);
    }

    function mintMetaStockFranchiseShareBatch(
        address metaStockFranchise,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(metaStockFranchise, ids, amounts, data);
    }
}
