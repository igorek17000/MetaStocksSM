// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../interfaces/metaStockInterfaces/IMetaStocksCompanyManager.sol";
import "../../interfaces/metaStockInterfaces/IMetaStockCompany.sol";
import "../../models/TransactionFees.sol";

contract MetaStocksCompanyManager is IMetaStocksCompanyManager {
    mapping(address => uint256) public ceosCompanies;
    IMetaStockCompany metaStockCompany;

    constructor() {}

    function createCompany() external payable {
        uint256 companyId = metaStockCompany.createMetaStockCompany(msg.sender);
        ceosCompanies[msg.sender] = companyId;
    }

    function isCeo(address account) public view virtual returns (bool) {
        return ceosCompanies[account] > 0;
    }

    function getCompanyId(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return ceosCompanies[account];
    }
}
