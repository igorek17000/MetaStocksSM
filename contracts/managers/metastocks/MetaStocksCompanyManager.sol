// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "hardhat/console.sol";
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

    function createCompany(address account) external payable {
        //require(!ceos[account], "Already Ceo");
        uint256 companyId = MetaStocksCompany.safeMint(account);
        ceosCompanies[account] = companyId;
        companiesCeos[companyId] = account;
        ceos[account] = true;
        totalCeos++;
        emit CreateCompany(account, ceosCompanies[account]);
    }

    function createFranchise(address _account) external payable {
        if (!ceos[_account]) {
            this.createCompany(_account);
        }

        metaStocksFranchiseManager.createMetaStocksFranchise(
            address(metaStocksFranchiseManager),
            this.getCompanyId(_account),
            0,
            MetaStocksFranchiseType.MetaStocksFranchiseType1
        );
    }

    function createFranchiseUsingBNB(address _account) external payable {
        if (!ceos[msg.sender]) {
            this.createCompany(_account);
        }
        metaStocksFranchiseManager.createMetaStocksFranchiseUsingBNB{value: msg.value}(
            address(metaStocksFranchiseManager),
            this.getCompanyId(msg.sender),
            0,
            MetaStocksFranchiseType.MetaStocksFranchiseType1
        );
    }

    function getMetaStocksFranchisesUnclaimedRewards()
        external
        view
        returns (uint256)
    {
        return
            metaStocksFranchiseManager.getMetaStocksFranchisesUnclaimedRewards(
                this.getCompanyId(msg.sender)
            );
    }

    function getMetaStocksFranchisesUnclaimedRewardsBNB()
        external
        view
        returns (uint256)
    {
        return
            metaStocksFranchiseManager
                .getMetaStocksFranchisesUnclaimedRewardsBNB(
                    this.getCompanyId(msg.sender)
                );
    }

    function claimFromAllFranchises() external {
        metaStocksFranchiseManager.claimFromAllFranchises(
            this.getCompanyId(msg.sender)
        );
    }

    function claimFromAllFranchisesBNB() external {
        metaStocksFranchiseManager.claimFromAllFranchisesBNB(
            this.getCompanyId(msg.sender)
        );
    }
}
