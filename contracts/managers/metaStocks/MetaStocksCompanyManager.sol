// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../interfaces/metaStocks/IMetaStocksCompany.sol";

contract MetaStocksCompanyManager is
    ERC20Upgradeable,
    OwnableUpgradeable,
    IERC1155Receiver,
    ERC1155Holder
{
    IMetaStocksCompany MetaStocksCompany;

    mapping(address => uint256) public ceosCompanies;
    mapping(uint256 => address) public companiesCeos;
    mapping(address => bool) public ceos;

    event CreateCompany(address indexed account, uint256 comanyId);

    function initialize(address _metaStocksCompanyAddress) public initializer {
        MetaStocksCompany = IMetaStocksCompany(_metaStocksCompanyAddress);
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    )
        public
        virtual
        override(ERC1155Holder, IERC1155Receiver)
        returns (bytes4)
    {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    )
        public
        virtual
        override(ERC1155Holder, IERC1155Receiver)
        returns (bytes4)
    {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Receiver, IERC165)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
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
}
