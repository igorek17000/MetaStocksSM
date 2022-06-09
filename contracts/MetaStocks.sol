// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./metaStocks/MetaStocksERC20Upgradeable.sol";

contract MetaStocks is MetaStocksERC20Upgradeable {
    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize() public initializer {
        __ERC20_init("MetaStocks", "MST");
    }
}
