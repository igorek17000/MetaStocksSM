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

//import "../../interfaces/midasInterfaces/IMidasManager.sol";

contract MetaStocksFranchiseManager is
    ERC20Upgradeable,
    OwnableUpgradeable,
    IERC1155Receiver,
    ERC1155Holder
{
    IMetaStocksFranchise metaStocksFranchise;
    ChainlinkDataFeedsManager chainlinkDataFeedsManager;

    uint256 private createFranchisePrice;
    uint256 private maintainceFranchiseExpenses;
    uint256 private franchiseDailyEarnings;
    address private paymentTokenAddress;

    mapping(uint256 => uint256) public lastFranchiseClaimDate;

    mapping(uint256 => mapping(uint256 => uint256)) public companyFranchises;

    function initialize(address _metaStocksFranchiseAddress)
        public
        initializer
    {
        createFranchisePrice = 10 ether;
        maintainceFranchiseExpenses = 1000000000000000000;
        franchiseDailyEarnings = 100000000000000000;
        paymentTokenAddress = address(0);
        /*
        chainlinkDataFeedsManager = new ChainlinkDataFeedsManager(
            0x0A77230d17318075983913bC2145DB16C7366156
        );
        */
        metaStocksFranchise = IMetaStocksFranchise(_metaStocksFranchiseAddress);
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    )
        public
        virtual
        override(ERC1155Holder, IERC1155Receiver)
        returns (bytes4)
    {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    )
        public
        virtual
        override(ERC1155Holder, IERC1155Receiver)
        returns (bytes4)
    {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Receiver, IERC165)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
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
        address to,
        uint256 companyId,
        MetaStocksFranchiseType _metaStocksFranchiseType,
        bytes memory data
    ) external {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            10 ether
        );

        uint256 franchiseType = metaStocksFranchise.getMetaStocksFranchiseType(
            _metaStocksFranchiseType
        );

        metaStocksFranchise.mint(to, franchiseType, 1, data);

        companyFranchises[companyId][franchiseType] += 1;

        //lastFranchiseClaimDate[companyId] = block.timestamp;

        //companyFranchises[]

        //lastFranchiseClaimDate[] = block.timestamp;
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

    function getMetaStocksFranchises(uint256 companyId)
        external
        view
        returns (uint256)
    {
        for (uint256 typeIndex = 0; typeIndex < 10; typeIndex++) {
            uint256 typeNumber = companyFranchises[companyId][typeIndex];

            for (uint256 index = 0; index < typeNumber; index++) {
                uint256 c = companyFranchises[companyId][index];
            }
        }

        return franchiseDailyEarnings;
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
