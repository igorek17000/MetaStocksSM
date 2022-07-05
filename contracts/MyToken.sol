// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    uint256 tokenPrice = 500000000000000000;

    constructor() ERC20("MyToken", "MTK") {
      _mint(msg.sender, 1000000 * 10 ** decimals());
      _approve(address(this), address(this), type(uint256).max);
    }

    function buyPresale(uint256 amount) external {
        IERC20(address(this)).transfer(
            msg.sender,
            amount / tokenPrice
        );
    }
}
