// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MetaStocksAchievementsManager is ERC20Upgradeable, OwnableUpgradeable {
    function initialize(address _metaStocksCompanyAddress) public initializer {}

    function getCompanyId(address _account) external view returns (uint256) {}
}
