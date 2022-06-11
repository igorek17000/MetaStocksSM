// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

import "../../managers/chainlink/ChainlinkDataFeedsManager.sol";
import "../../interfaces/metaStocks/IMetaStocksFranchise.sol";
import "../../models/TransactionFees.sol";
import "../../enums/MetaStocksFranchiseType.sol";
import "../../tokens/MetaStocksIERC1155ReceiverHolder.sol";

contract MetaStocksFranchiseManager is
    MetaStocksIERC1155ReceiverHolder,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    IMetaStocksFranchise metaStocksFranchise;
    ChainlinkDataFeedsManager chainlinkDataFeedsManager;

    uint256 private createFranchisePrice;
    uint256 private maintainceFranchiseExpenses;
    uint256 private franchiseDailyEarnings;
    uint256 private franchiseDailyInterval;
    address private paymentTokenAddress;

    mapping(uint256 => uint256) public lastFranchiseClaimDate;

    mapping(uint256 => mapping(uint256 => uint256)) public companyFranchises;
    mapping(uint256 => mapping(uint256 => uint256))
        public franchisesLastClaimDates;

    function initialize(address _metaStocksFranchiseAddress)
        public
        initializer
    {
        createFranchisePrice = 100 ether;
        franchiseDailyEarnings = 10 ether;
        maintainceFranchiseExpenses = 1 ether;
        franchiseDailyInterval = 10;

        paymentTokenAddress = address(0);
        /*
        chainlinkDataFeedsManager = new ChainlinkDataFeedsManager(
            0x0A77230d17318075983913bC2145DB16C7366156
        );
        */
        metaStocksFranchise = IMetaStocksFranchise(_metaStocksFranchiseAddress);
    }

    function self() public view virtual returns (address) {
        return address(this);
    }

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
        IERC20(paymentTokenAddress).approve(self(), type(uint256).max);
    }

    function createMetaStocksFranchise(
        address to,
        uint256 companyId,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(self()),
            createFranchisePrice
        );

        uint256 franchiseType = metaStocksFranchise.getMetaStocksFranchiseType(
            _metaStocksFranchiseType
        );

        metaStocksFranchise.mint(to, franchiseType, 1, "0x0");

        companyFranchises[companyId][franchiseType] += 1;
        franchisesLastClaimDates[companyId][franchiseType] = block.timestamp;
    }

    function getNumberOfMetaStocksFranchises(uint256 companyId)
        external
        view
        returns (uint256)
    {
        uint256 totalFranchises = 0;

        // loop all types
        for (uint256 typeIndex = 0; typeIndex < 10; typeIndex++) {
            totalFranchises += companyFranchises[companyId][typeIndex];
        }

        return totalFranchises;
    }

    function getMetaStocksFranchisesUnclaimedRewards(uint256 companyId)
        public
        view
        returns (uint256)
    {
        uint256 totalUnclaimed = 0;

        for (uint256 typeIndex = 0; typeIndex < 10; typeIndex++) {
            uint256 typeNumber = companyFranchises[companyId][typeIndex];

            for (uint256 index = 0; index < typeNumber; index++) {
                //totalUnclaimed += franchiseDailyEarnings;
                totalUnclaimed +=
                    (uint256(
                        block.timestamp -
                            franchisesLastClaimDates[companyId][typeNumber]
                    ) * franchiseDailyEarnings) /
                    franchiseDailyInterval;
            }
        }

        return totalUnclaimed;
    }

    function claimFromAllFranchises(uint256 _companyId) external {
        uint256 totalUnclaimed = getMetaStocksFranchisesUnclaimedRewards(
            _companyId
        );

        IERC20(paymentTokenAddress).transferFrom(
            address(self()),
            address(msg.sender),
            totalUnclaimed
        );

        for (uint256 typeIndex = 0; typeIndex < 10; typeIndex++) {
            franchisesLastClaimDates[_companyId][typeIndex] = block.timestamp;
        }
    }

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

    function burnMetaStocksFranchise(
        address to,
        uint256 companyId,
        uint256 amount,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external {
        uint256 franchiseType = metaStocksFranchise.getMetaStocksFranchiseType(
            _metaStocksFranchiseType
        );
    }

    function sellMetaStocksFranchise(
        address to,
        uint256 companyId,
        uint256 amount,
        MetaStocksFranchiseType _metaStocksFranchiseType
    ) external {
        uint256 franchiseType = metaStocksFranchise.getMetaStocksFranchiseType(
            _metaStocksFranchiseType
        );
    }
}
