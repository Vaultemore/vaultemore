pragma solidity ^0.8.13;

/**
    @title Registry Contract Interface
    @notice modified version of https://github.com/sentimentxyz/protocol/blob/main/src/interface/core/IRegistry.sol
*/

interface IRegistry {
    event vaVaultCreated(address indexed underlying, address indexed vaVault);

    function getAllVaVaults() external view returns(address[] memory);
    function vaVaultFor(address underlying) external view returns (address);
    function addVaVault(address underlying, address vaVault) external;

}