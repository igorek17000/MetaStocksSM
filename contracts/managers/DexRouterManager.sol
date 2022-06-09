// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DexRouterManager {
    IUniswapV2Router02 private dexRouter; // router instance for do swaps
    address stableCoin;

    constructor(address _dexRouterAddress, address _stableCoin) {
        dexRouter = IUniswapV2Router02(_dexRouterAddress);
        stableCoin = _stableCoin;
    }

    function getDexRouter() public view returns (IUniswapV2Router02) {
        return dexRouter;
    }

    function getDexRouterAddress() public view returns (address) {
        return address(dexRouter);
    }

    function swapTokensForStableCoin(address to, uint256 amount) public {
        address[] memory path = new address[](3);
        path[0] = address(this);
        path[1] = dexRouter.WETH();
        path[2] = stableCoin;

        // Do approve for router spend swap token amount
        IERC20(stableCoin).approve(address(dexRouter), type(uint256).max);

        // swap and transfer to contract
        dexRouter.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount,
            0,
            path,
            to,
            block.timestamp + 1000
        );
    }

    function swapTokensForBNB(
        address token,
        address to,
        uint256 amount
    ) public {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = token;
        path[1] = dexRouter.WETH();

        IERC20(token).approve(address(dexRouter), type(uint256).max);

        // make the swap
        dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount,
            0, // accept any amount of ETH
            path,
            to,
            block.timestamp
        );
    }

    /// @notice return the route given the busd addresses and the token
    function getPathForTokensToTokens(
        address tokenAddressA,
        address tokenAddressB
    ) private pure returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = tokenAddressA;
        path[1] = tokenAddressB;
        return path;
    }

    function addLiquidity(
        address token,
        address to,
        uint256 tokenAmount,
        uint256 ethAmount
    ) private {
        // approve token transfer to cover all possible scenarios
        IERC20(token).approve(address(dexRouter), type(uint256).max);

        // add the liquidity
        dexRouter.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            to, // send lp tokens to owner
            block.timestamp + 10000
        );
    }
}