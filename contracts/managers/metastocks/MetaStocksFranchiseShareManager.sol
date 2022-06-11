// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../managers/chainlink/ChainlinkDataFeedsManager.sol";
import "../../interfaces/metaStocks/IMetaStocksFranchiseShare.sol";
import "../../enums/MetaStocksFranchiseType.sol";
import "../../tokens/MetaStocksIERC1155ReceiverHolder.sol";

contract MetaStocksFranchiseShareManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksFranchiseShare metaStocksFranchiseShare;
    ChainlinkDataFeedsManager chainlinkDataFeedsManager;

    uint256 SHARES_NUMBER;
    uint256[] ids;
    uint256[] amounts;
    mapping(uint256 => mapping(uint256 => uint256)) public franchisesShares;

    function initialize(address _metaStocksFranchiseAddress)
        public
        initializer
    {
        SHARES_NUMBER = 100;
        ids = new uint256[](SHARES_NUMBER);
        amounts = new uint256[](SHARES_NUMBER);

        for (uint256 index = 0; index < SHARES_NUMBER; index++) {
            ids.push(0);
            amounts.push(1);
        }

        metaStocksFranchiseShare = IMetaStocksFranchiseShare(
            _metaStocksFranchiseAddress
        );
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function createMetaStocksFranchiseShares(
        address to,
        uint256 companyId,
        uint256 franchiseId
    ) external {
        metaStocksFranchiseShare.mintBatch(to, ids, amounts, "0x0");
        franchisesShares[companyId][franchiseId] += SHARES_NUMBER;
    }

    function getNumberOfMetaStocksFranchiseShares(
        uint256 companyId,
        uint256 franchiseId
    ) external view returns (uint256) {
        return franchisesShares[companyId][franchiseId];
    }

    function burnMetaStocksFranchiseShares(
        uint256 companyId,
        uint256 franchiseId,
        uint256 amount
    ) external {
        require(
            amount <= franchisesShares[companyId][franchiseId],
            "Burn exceded share allowance"
        );

        require(
            franchisesShares[companyId][franchiseId] - amount >= 0,
            "Balance after burn cant be lower than zero"
        );

        franchisesShares[companyId][franchiseId] -= amount;
        metaStocksFranchiseShare.burnMetaStocksFranchiseShare(
            msg.sender,
            franchiseId,
            amount
        );
    }

    function sellMetaStocksFranchiseShares(
        uint256 companyId,
        uint256 franchiseId,
        uint256 amount
    ) external {
        require(
            amount <= franchisesShares[companyId][franchiseId],
            "Burn exceded share allowance"
        );

        require(
            franchisesShares[companyId][franchiseId] - amount >= 0,
            "Balance after burn cant be lower than zero"
        );

        franchisesShares[companyId][franchiseId] -= amount;

        metaStocksFranchiseShare.safeTransferFrom(
            address(this),
            msg.sender,
            1,
            amount,
            "0x0"
        );
    }
}
