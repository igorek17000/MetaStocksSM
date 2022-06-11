// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../interfaces/metaStocks/IMetaStocksCompany.sol";
import "./../../tokens/MetaStocksIERC1155ReceiverHolder.sol";

contract MetaStocksCompanyManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksCompany MetaStocksCompany;

    mapping(address => uint256) public ceosCompanies;
    mapping(uint256 => address) public companiesCeos;
    mapping(address => bool) public ceos;

    event CreateCompany(address indexed account, uint256 comanyId);

    function initialize(address _metaStocksCompanyAddress) public initializer {
        MetaStocksCompany = IMetaStocksCompany(_metaStocksCompanyAddress);
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

    function create() external payable {
        require(!ceos[msg.sender], "Already Ceo");
        ceosCompanies[msg.sender] = MetaStocksCompany.safeMint(msg.sender);
        companiesCeos[ceosCompanies[msg.sender]] = msg.sender;
        ceos[msg.sender] = true;
        emit CreateCompany(msg.sender, ceosCompanies[msg.sender]);
    }

    function update(uint256 managerId) external {}

    function remove(uint256 companyId) external {} /*
    function claimMetaStocksFranchiseRewards(
        address companyAddress,
        uint256 id,
        bytes memory data
    ) public onlyOwner {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            (amount * rewardsPoolFee) / 10000
        );

        _mint(companyAddress, id, 1, data);
    }
    */
}