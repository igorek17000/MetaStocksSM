// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "../../interfaces/metaStocksInterfaces/IMetaStocksCompany.sol";

contract MetaStocksCompanyManager is ERC20Upgradeable {
    IMetaStocksCompany MetaStocksCompany;

    uint256 maxCompanies;
    mapping(address => uint256) public ceosCompanies;

    function initialize(address _metaStocksCompanyAddress) public initializer {
        maxCompanies = 1 ether;
        MetaStocksCompany = IMetaStocksCompany(_metaStocksCompanyAddress);
    }

    function getCompany(address _account) external view returns (uint256) {
        return ceosCompanies[_account];
    }

    function isCeo(address _account) external view returns (bool) {
        return ceosCompanies[_account] > 0;
    }

    function create() external payable {
        require(ceosCompanies[msg.sender] == 0, "Max Companies");
        ceosCompanies[msg.sender] = MetaStocksCompany.safeMint(msg.sender);
    }

    function update(uint256 managerId) external {}

    function remove(uint256 companyId) external {}
}
