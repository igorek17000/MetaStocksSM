// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IAutoLiquidityInjecter {
    function autoInjectLiquidity(uint256 tokenAmount) external;
}
