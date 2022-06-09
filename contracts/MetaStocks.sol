// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./metaStocks/MetaStocksERC20Upgradeable.sol";
import "./interfaces/metaStockInterfaces/IMetaStocksCompanyManager.sol";

contract MetaStocks is MetaStocksERC20Upgradeable {
    IMetaStocksCompanyManager metaStocksCompanyManager;

    function initialize() public initializer {
        super.initialize("MetaStocks", "MST");
        metaStocksCompanyManager = IMetaStocksCompanyManager(
            0x000000000000000000000000000000000000dEaD
        );
    }
}
