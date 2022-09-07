pragma solidity ^0.8.13;

interface IRegistry {
    event vaVaultCreated(address indexed underlying, address indexed vaVault);

    function getAllVaVaults() external view returns(address[] memory);
    function vaVaultFor(address underlying) external view returns (address);
    function addVaVault(address underlying, address vaVault) external;

}