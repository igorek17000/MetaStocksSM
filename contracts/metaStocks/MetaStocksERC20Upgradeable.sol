// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./../managers/feesManagers/FeesManager.sol";
import "./../interfaces/dexRouterInterfaces/IAutoLiquidityInjecter.sol";
//import "./../managers/feesManagers/FeesSplitManager.sol";
import "./../managers/DexRouterManager.sol";
import "./MetaStocksERC20UpgradeableCore.sol";

contract MetaStocksERC20Upgradeable is
    ERC20Upgradeable,
    MetaStocksERC20UpgradeableCore
{
    // CONSTRUCTOR ------------------------------------------------------------------------------------------
    function initialize(string memory _name, string memory _symbol)
        public
        initializer
    {
        __ERC20_init(_name, _symbol);
        initializeContract();
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

    function initializeContract() internal virtual {
        initAddressess();
        initContracts();
        setRouter(0x000000000000000000000000000000000000dEaD);
        createPair(
            self(),
            super.getDexRouterManager().getNativeTokenAddress(97)
        );
        doInitialApproves();
        _mint(msg.sender, 100000000000000000000000000);
    }

    function doInitialApproves() internal virtual {
        _approve(
            msg.sender,
            super.getDexRouterManager().getDexRouterAddress(),
            type(uint256).max
        );
        _approve(
            self(),
            super.getDexRouterManager().getDexRouterAddress(),
            type(uint256).max
        );
    }

    function initContracts() internal virtual {
        super.setFeesManager(new FeesManager());
        //super.setFeesSplitManager(new FeesSplitManager());
    }

    function initValues() internal virtual {
        super.setMaxWalletAmount(type(uint256).max);
        super.setMaxTransactionAmount(type(uint256).max);
        super.setSwapThreshold(1000 ether);
    }

    function initAddressess() internal virtual {
        super.transferOwnership(msg.sender);

        // few values needed for contract works
        super.setDeadAddress();
    }

    function _finalizeTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        // by default receiver receive 100% of sended amount
        uint256 amountReceived = amount;
        uint256 feeAmount = 0; // received fee amount is zero

        // If takeFee is false there is 0% fee
        bool takeFee = true;
        if (
            super.getFeesManager().isExcludedFromFee(from) ||
            super.getFeesManager().isExcludedFromFee(to)
        ) {
            takeFee = false;
        }

        // check if we need take fee or not
        if (takeFee) {
            // if we need take fee
            // calc how much we need take
            //feeAmount = calcBuySellTransferFee(from, to, amount);

            // we substract fee amount from recipient amount
            amountReceived = amount - feeAmount;

            // and transfer fee to contract
            super._transfer(from, self(), feeAmount);
        }

        // finally send remaining tokens to recipient
        super._transfer(from, to, amountReceived);
    }

    function contractMustSwap(address from, address to)
        internal
        view
        virtual
        returns (bool)
    {
        uint256 contractTokenBalance = balanceOf(self());
        return
            contractTokenBalance >= super.getSwapThreshold() &&
            !super.getDexRouterManager().isInSwap() &&
            from != super.getLPPair() &&
            balanceOf(super.getLPPair()) > 0 &&
            !super.getFeesManager().isExcludedFromFee(to) &&
            !super.getFeesManager().isExcludedFromFee(from);
    }

    function autoInjectLiquidity(uint256 tokenAmount) public {
        // split the contract balance into halves
        uint256 half = tokenAmount / 2;

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        super.getDexRouterManager().swapTokensForNativeToken(
            self(),
            self(),
            half
        ); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        super.getDexRouterManager().addLiquidity(
            self(),
            getOwner(),
            half,
            newBalance
        );
    }

    function _beforeTransferCheck(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(
            from != address(0),
            "ERC20: transfer from the ZERO_ADDRESS address"
        );
        require(
            to != address(0),
            "ERC20: transfer to the ZERO_ADDRESS address"
        );
        require(
            amount > 0,
            "Transfer amount must be greater than ZERO_ADDRESS"
        );

        if (
            from != super.getOwner() &&
            to != super.getOwner() &&
            to != address(0) &&
            to != address(0xdead) &&
            !super.getDexRouterManager().isInSwap()
        ) {
            require(super.getTradingEnabled(), "Trading not active");

            /*
            // BUY -> FROM == LP ADDRESS
            if (super.automatedMarketMakerPairs[from]) {
                require(
                    amount <= super.maxTransactionAmount,
                    "Buy transfer amount exceeds the maxTransactionAmount."
                );
                require(
                    amount + balanceOf(to) <= super.maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
            // SELL -> TO == LP ADDRESS
            else if (super.automatedMarketMakerPairs[to]) {
                require(
                    amount <= super.maxTransactionAmount,
                    "Sell transfer amount exceeds the maxTransactionAmount."
                );
            }
            // TRANSFER
            else {
                require(
                    amount + balanceOf(to) <= super.maxWalletAmount,
                    "Max wallet exceeded"
                );
            }
            */
        }
    }

    // this function will be called every buy, sell or transfer
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        // check before each tx
        _beforeTransferCheck(from, to, amount);

        // if transaction are internal transfer when contract is swapping
        // transfer no fee
        if (super.getDexRouterManager().isInSwap()) {
            super._transfer(from, to, amount);
            return;
        }

        // DO SWAP AND AUTOLIQUIDITY
        if (contractMustSwap(from, to)) {
            // SWAP
            // Get contract tokens balance
            uint256 numTokensToSwap = balanceOf(self());

            // swap tokens
            super.getDexRouterManager().swapTokensForStableCoin(
                self(),
                (numTokensToSwap * 12) / 10000
            );

            // inject liquidity
            autoInjectLiquidity((numTokensToSwap * 123) / 10000);

            //burn((numTokensToSwap * autoLiquidityPercent) / masterTaxDivisor);

            // send eanring to team
        }

        _finalizeTransfer(from, to, amount);
    }
}
