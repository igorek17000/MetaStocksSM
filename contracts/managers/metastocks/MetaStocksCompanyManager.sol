// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../interfaces/metaStocks/IMetaStocksCompany.sol";
import "../../interfaces/metaStocks/IMetaStocksFranchiseManager.sol";
import "./../../tokens/MetaStocksIERC1155ReceiverHolder.sol";

contract MetaStocksCompanyManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksCompany MetaStocksCompany;
    IMetaStocksFranchiseManager metaStocksFranchiseManager;

    mapping(address => uint256) public ceosCompanies;
    mapping(uint256 => address) public companiesCeos;
    mapping(address => bool) public ceos;
    uint256 totalCeos;

    event CreateCompany(address indexed account, uint256 companyId);

    function initialize(
        address _metaStocksCompanyAddress,
        address _metaStocksFranchiseManagerAddress
    ) public initializer {
        MetaStocksCompany = IMetaStocksCompany(_metaStocksCompanyAddress);
        metaStocksFranchiseManager = IMetaStocksFranchiseManager(
            _metaStocksFranchiseManagerAddress
        );
        totalCeos = 0;
    }

    function getCompanyId(address _account) external view returns (uint256) {
        return ceosCompanies[_account];
    }

    function getCompanyCEOAddress(uint256 companyId)
        external
        view
        returns (address)
    {
        return companiesCeos[companyId];
    }

    function isCeo(address _account) external view returns (bool) {
        return ceos[_account];
    }

    function createCompany() external payable {
        //require(!ceos[msg.sender], "Already Ceo");
        uint256 companyId = MetaStocksCompany.safeMint(msg.sender);
        ceosCompanies[msg.sender] = companyId;
        companiesCeos[companyId] = msg.sender;
        ceos[msg.sender] = true;
        totalCeos++;
        emit CreateCompany(msg.sender, ceosCompanies[msg.sender]);
    }

    function createFranchise() external payable {
        if (!ceos[msg.sender]) {
            this.createCompany();
        }

        metaStocksFranchiseManager.createMetaStocksFranchise(
            address(metaStocksFranchiseManager),
            this.getCompanyId(msg.sender),
            0,
            MetaStocksFranchiseType.MetaStocksFranchiseType1
        );
    }

    function createFranchiseUsingBNB() external payable {
        if (!ceos[msg.sender]) {
            this.createCompany();
        }

        metaStocksFranchiseManager.createMetaStocksFranchiseUsingBNB(
            address(metaStocksFranchiseManager),
            this.getCompanyId(msg.sender),
            0,
            MetaStocksFranchiseType.MetaStocksFranchiseType1
        );
    }
}
