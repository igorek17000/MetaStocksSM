// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../interfaces/metaStockInterfaces/IMetaStocksCompanyManager.sol";
import "../../models/TransactionFees.sol";

contract MetaStocksCompanyManager is IMetaStocksCompanyManager {
    constructor() {}

    function createCompany() external payable {}
}
