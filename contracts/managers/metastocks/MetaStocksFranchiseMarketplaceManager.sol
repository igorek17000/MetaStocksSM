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

contract MetaStocksFranchiseMarketplaceManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    uint256 ordersIds;

    event CreateOrder(
        address indexed account,
        uint256 companyId,
        address indexed orderId,
        uint256 amount
    );
    event UpdateOrder(
        address indexed account,
        uint256 companyId,
        address indexed orderId
    );
    event DeleteOrder(
        address indexed account,
        uint256 companyId,
        address indexed orderId
    );

    function initialize() public initializer {
        ordersIds = 0;
    }

    function createOrder(
        uint256 companyId,
        address orderId,
        uint256 amount
    ) external {
        ordersIds++;
        emit CreateOrder(msg.sender, companyId, orderId, amount);
    }

    function getOrder(uint256 companyId, address orderId)
        external
        view
        returns (uint256)
    {
        return 0;
    }

    function updateOrder(uint256 companyId, address orderId) external {
        emit UpdateOrder(msg.sender, companyId, orderId);
    }

    function deleteOrder(uint256 companyId, address orderId) external {
        emit DeleteOrder(msg.sender, companyId, orderId);
    }
}
