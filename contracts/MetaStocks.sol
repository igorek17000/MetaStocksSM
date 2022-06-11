// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./token/MidasCoreERC20Upgradeable.sol";

contract MetaStocks is MidasCoreERC20Upgradeable {
    function initialize() public virtual initializer {
        super.initialize(
            "MetaStocks",
            "MST",
            1000000 ether,
            0x2D99ABD9008Dc933ff5c0CD271B88309593aB921
        );
    }
}
