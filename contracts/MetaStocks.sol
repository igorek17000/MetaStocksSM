// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./metaStocks/MetaStocksCoreToken.sol";

contract MetaStocks is MetaStocksCoreToken {
    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize() public initializer {
        __ERC20_init("MetaStocks", "MST");
    }
}
