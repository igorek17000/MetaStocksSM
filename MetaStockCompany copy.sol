// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaStocksCompany is
    Initializable,
    ERC721Upgradeable,
    PausableUpgradeable,
    OwnableUpgradeable,
    IERC1155Receiver,
    ERC1155Holder
{
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIdCounter;

    address payTokenAddress;
    uint256 createCompanyPrice;
    uint256 paymentsByInterval;
    uint256 harvestInterval;
    mapping(address => uint256) private ceosCompanies;
    mapping(address => uint256) private lastClaimDateByCompany;
    mapping(address => uint256) private companiesLevels;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC721_init("MetaStocksCompany", "MSC");
        __Pausable_init();
        __Ownable_init();

        payTokenAddress = 0x1c47144bA41E1aAD84564d34A79dac5326779251;
        createCompanyPrice = 10 ether;
        paymentsByInterval = 1 ether;
        harvestInterval = 1000;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721Upgradeable) {
        super._burn(tokenId);
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) public pure override(ERC1155Holder, IERC1155Receiver) returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) public pure override(ERC1155Holder, IERC1155Receiver) returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721Upgradeable, ERC1155Receiver, IERC165)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    // UPDATE -----------------------------------------------------------------------------
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

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);

        // update company
        ceosCompanies[msg.sender] = tokenId;
        lastClaimDateByCompany[msg.sender] = block.timestamp;
        companiesLevels[msg.sender] = 0;
    }

    function upgradeCompanyLevel() public payable {
        companiesLevels[msg.sender] += 1;
    }
}
