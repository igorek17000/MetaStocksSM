// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "../../interfaces/metaStocks/IMetaStocksCompany.sol";

contract MetaStocksCompanyManager is ERC20Upgradeable {
    IMetaStocksCompany MetaStocksCompany;

    uint256 maxCompanies;
    mapping(address => uint256) public ceosCompanies;
    mapping(uint256 => address) public companiesCeos;
    mapping(address => bool) public ceos;

    event CreateCompany(address indexed account, uint256 comanyId);

    function initialize(address _metaStocksCompanyAddress) public initializer {
        maxCompanies = 1 ether;
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

    function remove(uint256 companyId) external {}

    function getCompanyFranchises(uint256 companyId)
        external
        view
        returns (uint256)
    {
        return 0;
    }
}
