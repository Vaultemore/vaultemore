pragma solidity ^0.8.13;

import {IVault} from "./interfaces/Beefy/IVault.sol";
import {AbstractProtocolAdapter} from "./AbstractProtocolAdapter.sol";

/**
    @title Protocol Adapter Contract for Beefy
*/

contract AdapterBeefy is AbstractProtocolAdapter {

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Performs the deposit
    function _deposit(address underlying, uint256 amount) override internal {
        IVault(vaultAddressFor[underlying]).deposit(amount);
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice returns true if the withdraw was successful, else false
    function _withdraw(address underlying, uint256 amount) override internal {
        IVault(vaultAddressFor[underlying]).withdraw(amount);
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Returns an uint256 with 18 decimals of how much underlying asset one vault share represents
    function getPricePerShare(address underlying) override external view returns (uint256){
        return IVault(vaultAddressFor[underlying]).getPricePerFullShare();
    }

    /// @notice overrides function from AbstractProtocolAdapter
    /// @notice Returns an uint256 with 18 decimals how much the vault allows to be withdrawn
    function availableToWithdraw(address underlying) override external view returns (uint256) {
        return IVault(vaultAddressFor[underlying]).available();
    }

}