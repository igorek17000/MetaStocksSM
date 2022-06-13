// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./managers/transactionFees/TransactionFeesManager.sol";
import "./interfaces/dexRouter/IAutoLiquidityInjecter.sol";
import "./managers/midas/MidasMultinetworkRouterManager.sol";
import "./tokens/MetaStocksERC20Upgradable.sol";

/*
Token
	Buy 0
	Sell 2 %
	Transfer 0
	
Swap threshold -> 100$ = 100%    
treasury 40% ->  40$
dev team 1       20%
marketing team 2 20%
auto lp           5%
auto buybackburn  5%

Create 10
reward al dia 0.1
claim fee 25%
*/

contract MetaStocksToken is MetaStocksERC20Upgradable {
    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize(
        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _totalSupply
    ) public virtual override initializer {
        super.initialize(_tokenName, _tokenSymbol, _totalSupply);
    }

    /*

    function autoInjectLiquidity(uint256 tokenAmount) public {
        // split the contract balance into halves
        uint256 half = tokenAmount / 2;

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        midasMultinetworkRouterManager.swapTokensForNativeToken(
            self(),
            self(),
            half
        ); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        midasMultinetworkRouterManager.addLiquidity(
            self(),
            getOwner(),
            half,
            newBalance
        );
    }
*/
}
