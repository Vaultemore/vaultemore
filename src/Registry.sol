// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IRegistry} from "./IRegistry.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
    @title Registry Contract
    @notice This contract is the global storage for the Vaultecore ecosystem, it stores:
        1. Active VaVault addresses
        2. A mapping of underlying tokens to the associated VaVault
        3. A mapping of all protocol adapters
        @notice modified version of https://github.com/sentimentxyz/protocol/blob/main/src/core/Registry.sol
*/
contract Registry is Ownable, IRegistry {
    /* -------------------------------------------------------------------------- */
    /*                              STATE VARIABLES                             */
    /* -------------------------------------------------------------------------- */
    /// @notice List of active VaVault
    address[] public vaVaults;
    
    /// @notice PROTOCOL_NAME to protocol adapter mapping (token => vaultAddressFor)
    mapping(string => address) public protocolToAdapter;

    /// @notice Token to vaVault mapping (token => VaVault)
    mapping(address => address) public vaVaultFor;
    

    /* -------------------------------------------------------------------------- */
    /*                             EXTERNAL FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    /**
        @notice Adds VaVault address for a specified token
        @dev reverts if a vault already exists for token
        @param underlying Address of token
        @param vaVault Address of VaVault
    */
    function addVaVault(address underlying, address vaVault) external onlyOwner {
        require(vaVaultFor[underlying] == address(0), 'vault already exists, replacing vault not supported');
        
        vaVaults.push(vaVault);
        vaVaultFor[underlying] = vaVault;

        emit vaVaultCreated(underlying, vaVault);
    }

    /**
        @notice Adds protocol adapter for a given protocol name
        @dev reverts if an adapter already exists for a protocol name
        @param protocol_name name of the protocol, should be formatted like PROTOCOL_NAME
        @param adapter Address of adapter
    */
    function addProtocolAdapter(string calldata protocol_name, address adapter) external onlyOwner {
        require(protocolToAdapter[protocol_name] == address(0), 'Protocol name already assigned to an adapter, replacing adapter not supported');
        
        protocolToAdapter[protocol_name] = adapter;

        emit protocolAdapterAdded(protocol_name, adapter);
    }

    /* -------------------------------------------------------------------------- */
    /*                               VIEW FUNCTIONS                               */
    /* -------------------------------------------------------------------------- */
    /**
        @notice Returns all active VaVault in registry
        @return vaVaults List of VaVault
    */
    function getAllVaVaults() external view returns(address[] memory) {
        return vaVaults;
    }

    /* -------------------------------------------------------------------------- */
    /*                              HELPER FUNCTIONS                              */
    /* -------------------------------------------------------------------------- */

    // none

}

