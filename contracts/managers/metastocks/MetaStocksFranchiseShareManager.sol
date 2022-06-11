// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import "../../managers/chainlink/ChainlinkDataFeedsManager.sol";
import "../../interfaces/metaStocks/IMetaStocksCompany.sol";
import "../../models/TransactionFees.sol";

//import "../../interfaces/midasInterfaces/IMidasManager.sol";

contract MetaStocksFranchiseShareManager is
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksCompany MetaStocksCompany;
    ChainlinkDataFeedsManager chainlinkDataFeedsManager;

    uint256 private createFranchisePrice;
    uint256 private maintainceFranchiseExpenses;
    uint256 private franchiseDailyEarnings;
    address private paymentTokenAddress;

    function initialize(address _metaStocksCompanyAddress) public initializer {
        createFranchisePrice = 10 ether;
        maintainceFranchiseExpenses = 1000000000000000000;
        franchiseDailyEarnings = 100000000000000000;
        paymentTokenAddress = address(0);
        chainlinkDataFeedsManager = new ChainlinkDataFeedsManager(
            0x0A77230d17318075983913bC2145DB16C7366156
        );
    }

    function create() external payable {}

    function update(uint256 managerId) external {}

    function remove(uint256 companyId) external {}

    function getCreateFranchisePrice() external view returns (uint256) {
        return createFranchisePrice;
    }

    function getMaintainceFranchiseExpenses() external view returns (uint256) {
        return maintainceFranchiseExpenses;
    }

    function getFranchiseDailyEarnings() external view returns (uint256) {
        return franchiseDailyEarnings;
    }

    function getPaymentTokenAddress() external view returns (address) {
        return paymentTokenAddress;
    }

    function setCreateFranchisePrice(uint16 _createFranchisePrice)
        external
        virtual
    {
        createFranchisePrice = _createFranchisePrice;
    }

    function setMaintainceFranchiseExpenses(uint16 _maintainceFranchiseExpenses)
        external
        virtual
    {
        maintainceFranchiseExpenses = _maintainceFranchiseExpenses;
    }

    function setFranchiseDailyEarnings(uint16 _franchiseDailyEarnings)
        external
        virtual
    {
        franchiseDailyEarnings = _franchiseDailyEarnings;
    }

    function setPaymentTokenAddress(address _paymentTokenAddress)
        external
        virtual
    {
        paymentTokenAddress = _paymentTokenAddress;
    }

    function createMetaStocksFranchise(
        address companyAddress,
        uint256 id,
        bytes memory data
    ) public onlyOwner {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            10 ether
        );
    }

    function getUnclaimedRewards() external view returns (uint256) {
        return franchiseDailyEarnings;
    }

    /*
    function claimMetaStocksFranchiseRewards(
        address companyAddress,
        uint256 id,
        bytes memory data
    ) public onlyOwner {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            (amount * rewardsPoolFee) / 10000
        );

        _mint(companyAddress, id, 1, data);
    }
    */

    function getFranchiseValue() external view returns (uint256) {
        /*
        chainlinkDataFeedsManager.getTokensValueInUSD(
            _tokenAddress,
            _amount,
            _network,
            midasMultiNetworkRouter
        );
        */
        return franchiseDailyEarnings;
    }

    function setPaymentTokenAddress222(address _paymentTokenAddress)
        external
        virtual
    {
        paymentTokenAddress = _paymentTokenAddress;
    }
}
