// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./MetaStock1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MetaStockFranchise is MetaStock1155 {
    uint256 private createFranchisePrice;
    uint256 private maintainceFranchiseExpenses;
    uint256 private franchiseDailyEarnings;
    uint256 private paymentTokenAddress;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        createFranchisePrice = 10 ether;
        maintainceFranchiseExpenses = 1000000000000000000;
        franchiseDailyEarnings = 100000000000000000;
        paymentTokenAddress = address(0);
    }

    function mintMetaStockFranchise(
        address companyAddress,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(companyAddress, id, amount, data);
    }

    function mintMetaStockFranchiseBatch(
        address companyAddress,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(companyAddress, ids, amounts, data);
    }

    function getCreateFranchisePrice(uint16 _createFranchisePrice)
        external
        virtual
    {
        return createFranchisePrice;
    }

    function getMaintainceFranchiseExpenses(uint16 _maintainceFranchiseExpenses)
        external
        virtual
    {
        return maintainceFranchiseExpenses;
    }

    function getFranchiseDailyEarnings(uint16 _franchiseDailyEarnings)
        external
        virtual
    {
        franchiseDailyEarnings = _franchiseDailyEarnings;
    }

    function getPaymentTokenAddress(uint16 _paymentTokenAddress)
        external
        virtual
    {
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

    function setPaymentTokenAddress(uint16 _paymentTokenAddress)
        external
        virtual
    {
        paymentTokenAddress = _paymentTokenAddress;
    }

    function createMetaStockFranchise(
        address companyAddress,
        uint256 id,
        bytes memory data
    ) public onlyOwner {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            10 ether
        );

        _mint(companyAddress, id, 1, data);
    }

    function claimMetaStockFranchiseRewards(
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
}
