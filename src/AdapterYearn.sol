pragma solidity ^0.8.13;

import {VaultAPI} from "./interfaces/Yearn/VaultAPI.sol";
import {AbstractProtocolAdapter} from "./AbstractProtocolAdapter.sol";

/**
    @title Protocol Adapter Contract for Yearn
*/

contract AdapterYearn is AbstractProtocolAdapter {

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Performs the deposit
    function _deposit(address underlying, uint256 amount) override internal {
        VaultAPI(vaultAddressFor[underlying]).deposit(amount);
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice returns true if the withdraw was successful, else false
    function _withdraw(address underlying, uint256 amount) override internal {
        VaultAPI(vaultAddressFor[underlying]).withdraw(amount);
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Returns an uint256 with 18 decimals of how much underlying asset one vault share represents
    function getPricePerShare(address underlying) override external view returns (uint256){
        return VaultAPI(vaultAddressFor[underlying]).pricePerShare();
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Returns an uint256 with 18 decimals how much max the vault allows to be withdrawn, in number of shares
    function availableToWithdraw(address underlying) override external view returns (uint256) {
        return VaultAPI(vaultAddressFor[underlying]).maxAvailableShares();
    }

}