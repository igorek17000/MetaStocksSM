// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./MetaStock1155.sol";

contract MetaStockFranchiseShare is MetaStock1155 {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }
}
