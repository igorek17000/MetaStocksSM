// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/chainlinkInterfaces/AggregatorV3Interface.sol";
import "../../models/TransactionFees.sol";

contract MetaStocksBaseManager is ERC20Upgradeable {
    mapping(address => uint256) public lastClaimDate;

    function createMetaStockCompany(address to) external returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }

    function claimMetaStockFranchiseRewards(
        address companyAddress,
        uint256 id,
        bytes memory data
    ) public {
        IERC20(paymentTokenAddress).transferFrom(
            address(msg.sender),
            address(paymentTokenAddress),
            (amount * rewardsPoolFee) / 10000
        );

        _mint(companyAddress, id, 1, data);
    }
}
