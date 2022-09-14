// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import {ERC4626} from "./CustomERC4626.sol";

/**
    @title Registry Contract
    @notice It represents a vault for a given underlying token. (VaVault means vaultemore vault)
        - Shares of that vault measured following the ERC4626 standard
        - users can deposit underlying, obtain shares
        - they can also withdraw their underlying by giving back their shares  
*/

contract VaVault is ERC4626 {
    
    constructor(IERC20 asset_, string memory name_, string memory symbol_) ERC4626(asset_, name_, symbol_) {
    }

}
