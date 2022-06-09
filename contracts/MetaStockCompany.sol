// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IMetaStockFranchise.sol";

contract MetaStockCompany is ERC20Upgradeable {
    address payTokenAddress;
    address _owner;
    IMetaStockFranchise metaStockFranchise;
    uint256 createCompanyPrice;
    uint256 paymentsByInterval;
    uint256 harvestInterval;

    mapping(address => uint256) private ceosCompanies;
    mapping(address => uint256) private lastClaimDateByCompany;
    mapping(address => uint256) private companiesLevels;

    modifier onlyOwner() {
        require(_owner == msg.sender, "Only owner");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {}

    function initialize() public initializer {
        _owner == msg.sender;
        payTokenAddress = 0x1c47144bA41E1aAD84564d34A79dac5326779251;
        createCompanyPrice = 10 ether;
        paymentsByInterval = 1 ether;
        harvestInterval = 1000;
        metaStockFranchise = IMetaStockFranchise(
            0x1c47144bA41E1aAD84564d34A79dac5326779251
        );
    }

    // UPDATE -----------------------------------------------------------------------------
    function updateMetaStockFranchise(address _metaStockFranchise)
        public
        onlyOwner
    {
        metaStockFranchise = IMetaStockFranchise(_metaStockFranchise);
    }

    function updatepPyTokenAddress(address _payTokenAddress) public onlyOwner {
        payTokenAddress = _payTokenAddress;
    }

    function updateCreateCompanyPrice(uint256 _createCompanyPrice)
        public
        onlyOwner
    {
        createCompanyPrice = _createCompanyPrice;
    }

    function updateHarvestInterval(uint256 _harvestInterval) public onlyOwner {
        harvestInterval = _harvestInterval;
    }

    function updatePaymentsByInterval(uint256 _paymentsByInterval)
        public
        onlyOwner
    {
        paymentsByInterval = _paymentsByInterval;
    }

    // -------------------------------------------------------------------------------------

    // VIEW --------------------------------------------------------------------------------
    function isCeo(address account) public view virtual returns (bool) {
        return ceosCompanies[account] > 0;
    }

    function geCompanyFranchisesNumber(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return ceosCompanies[account];
    }

    function getCompanyId(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return ceosCompanies[account];
    }

    function getRewardsByCompany(address account)
        public
        view
        virtual
        returns (uint256)
    {
        uint256 companyId;

        return 1;
    }

    // -------------------------------------------------------------------------------------

    // WRITE --------------------------------------------------------------------------------
    function createCompany() public payable {
        require(ceosCompanies[msg.sender] == 0, "Max 1 Company");

        IERC20(payTokenAddress).transferFrom(
            address(msg.sender),
            address(payTokenAddress),
            createCompanyPrice
        );

        // update company
        lastClaimDateByCompany[msg.sender] = block.timestamp;
        companiesLevels[msg.sender] = 0;
    }

    function createMetaStockFranchise() public payable {
        require(isCeo(msg.sender), "account not is ceo");
        uint256 companyId = getCompanyId(msg.sender);
        uint256 companyFranchisesNumber = getCompanyId(msg.sender);

        // pay create franchise service
        IERC20(payTokenAddress).transferFrom(
            address(msg.sender),
            address(payTokenAddress),
            createCompanyPrice
        );
    }

    function upgradeCompanyLevel() public payable {
        companiesLevels[msg.sender] += 1;
    }
}
