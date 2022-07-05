// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "../../enums/MetaStocksFranchiseType.sol";

interface IMetaStocksFranchiseManager {
    function createMetaStocksFranchise(
        address to,
        uint256 companyId,
        uint256 _continentId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external;

    function createMetaStocksFranchiseUsingBNB(
        address to,
        uint256 companyId,
        uint256 _continentId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external payable;

    function getMetaStocksFranchisesUnclaimedRewards(uint256 companyId)
        external
        view
        returns (uint256);

    function claimFromAllFranchises(uint256 _companyId) external;

    function hireWorkerUsingBNB(
        uint256 companyId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external payable;

    function claimFromAllFranchisesBNB(uint256 _companyId) external;

    function getMetaStocksFranchisesUnclaimedRewardsBNB(uint256 companyId)
        external
        view
        returns (uint256);
}
