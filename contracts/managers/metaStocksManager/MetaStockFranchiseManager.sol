// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../models/TransactionFees.sol";
import "../../interfaces/midasInterfaces/IMidasManager.sol";

contract MetaStocksFranchiseManager is ERC20Upgradeable, IMidasManager {
    mapping(address => uint256) public lastClaimDate;

    function get(address _account) external view returns (address) {}

    function create() external payable {}

    function update(uint256 managerId) external {}

    function remove(uint256 managerId) external {}
}
