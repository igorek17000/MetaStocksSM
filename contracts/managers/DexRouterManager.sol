// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/dexRouterInterfaces/IMetaStocksMultiDexRouter.sol";

contract DexRouterManager {
    IMetaStocksMultiDexRouter private dexRouter; // router instance for do swaps
    address private stableCoin;
    bool private inSwap; // used for dont take fee on swaps
    uint256 private networkId;

    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor(address _dexRouterAddress) {
        dexRouter = IMetaStocksMultiDexRouter(_dexRouterAddress);
        networkId = 43113;
        stableCoin = address(0);
    }

    function getDexRouter() external view returns (IMetaStocksMultiDexRouter) {
        return dexRouter;
    }

    function setDexRouter(address _dexRouterAddress) external {
        dexRouter = IMetaStocksMultiDexRouter(_dexRouterAddress);
    }

    function isInSwap() external view returns (bool) {
        return inSwap;
    }

    function getNativeTokenAddress(uint256 _networkId)
        public
        view
        returns (address)
    {
        /*
        address networkTokenAddress = 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;
        if (_networkId == 97) {
            networkTokenAddress = 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;
        } else if (_networkId == 97) {
            networkTokenAddress = 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;
        } else {
            revert("unsupported network");
        }
        */
        return 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;
    }

    function getDexRouterAddress() external view returns (address) {
        return address(dexRouter);
    }

    function swapTokensForStableCoin(address to, uint256 amount) external {
        address[] memory path = new address[](3);
        path[0] = address(this);
        path[1] = getNativeTokenAddress(networkId);
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

    function swapTokensForNativeToken(
        address token,
        address to,
        uint256 amount
    ) external {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = token;
        path[1] = getNativeTokenAddress(networkId);

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
    ) external {
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
