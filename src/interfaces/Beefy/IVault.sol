// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


/**
    @title Registry Contract Interface
    @notice modified version of https://github.com/beefyfinance/beefy-contracts/blob/master/contracts/BIFI/interfaces/beefy/IVault.sol
            removed function related to the current strategy.
            added function description from VaultV7 implementation of IVault
*/

interface IVault is IERC20 {

    /**
     * @dev The entrypoint of funds into the system. People deposit with this function
     * into the vault. The vault is then in charge of sending funds into the strategy.
     */
    function deposit(uint256) external;

    /**
     * @dev A helper function to call deposit() with all the sender's funds.
     */
    function depositAll() external;

    /**
     * @dev Function to exit the system. The vault will withdraw the required tokens
     * from the strategy and pay up the token holder. A proportional number of IOU
     * tokens are burned in the process.
     */
    function withdraw(uint256) external;

    /**
     * @dev A helper function to call withdraw() with all the sender's funds.
     */
    function withdrawAll() external;

    /**
     * @dev Function for various UIs to display the current value of one of our yield tokens.
     * Returns an uint256 with 18 decimals of how much underlying asset one vault share represents.
     */
    function getPricePerFullShare() external view returns (uint256);

    /**
     * @dev Returns underlying token expected from that vault.
     */
    function want() external view returns (IERC20);

    /**
     * @dev Custom logic in here for how much the vault allows to be withdrawn.
     * We return 100% of tokens for now. Under certain conditions we might
     * want to keep some of the system funds at hand in the vault, instead
     * of putting them to work.
     */
    function available() external view returns (uint256);

     /**
     * @dev It calculates the total underlying value of {token} held by the system.
     * It takes into account the vault contract balance, the strategy contract balance
     *  and the balance deployed in other contracts as part of the strategy.
     */
    function balance() external view returns (uint256);

}