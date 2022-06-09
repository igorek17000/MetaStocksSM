// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./MetaStock1155.sol";

contract MetaStockFranchise is MetaStock1155 {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function mintMetaStockFranchise(
        address companyAddress,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(companyAddress, id, amount, data);
    }

    function mintMetaStockFranchiseBatch(
        address companyAddress,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(companyAddress, ids, amounts, data);
    }
}
