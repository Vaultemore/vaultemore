// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
    @title MintableERC20 Contract
    @notice It represents an ERC20 token that we could create with 3 params: name, symbol and amount to mint
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintableERC20 is ERC20, Ownable {
    constructor(string memory name_, string memory symbol_, uint256 amountToMint) ERC20(name_, symbol_) {
        _mint(msg.sender, amountToMint * 10 ** decimals());
    }
}