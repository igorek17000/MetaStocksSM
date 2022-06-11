// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

import "../../managers/chainlink/ChainlinkDataFeedsManager.sol";
import "../../interfaces/metaStocks/IMetaStocksFranchiseShare.sol";
import "../../models/TransactionFees.sol";
import "../../enums/MetaStocksFranchiseType.sol";
import "../../tokens/MetaStocksIERC1155ReceiverHolder.sol";

contract MetaStocksFranchiseShareManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksFranchiseShare metaStocksFranchiseShare;
    ChainlinkDataFeedsManager chainlinkDataFeedsManager;

    uint256 private createFranchisePrice;
    uint256 SHARES_NUMBER;
    uint256[] ids;
    uint256[] amounts;

    function initialize(address _metaStocksFranchiseAddress)
        public
        initializer
    {
        SHARES_NUMBER = 100;
        ids = new uint256[](SHARES_NUMBER);
        amounts = new uint256[](SHARES_NUMBER);
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function createMetaStocksFranchiseShare(
        address to,
        uint256 companyId,
        MetaStocksFranchiseType _metaStocksFranchiseType,
        bytes memory data
    ) external {
        for (uint256 index = 0; index < SHARES_NUMBER; index++) {
            ids.push(1);
            amounts.push(1);
        }

        metaStocksFranchiseShare.mintBatch(to, ids, amounts, data);
    }
}
