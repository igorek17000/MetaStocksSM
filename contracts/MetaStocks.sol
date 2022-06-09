// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./metaStocks/MetaStocksERC20Upgradeable.sol";

contract MetaStocks is MetaStocksERC20Upgradeable {
    function initialize() public initializer {
        super.initialize("MetaStocks", "MST");
    }
}
