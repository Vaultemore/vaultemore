pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
    @title Abstract Protocol Adapter Contract
    @notice Abstract, because it should work for all protocols we interact with
*/

abstract contract AbstractProtocolAdapter is Ownable {

    /// @notice Token to vaVault mapping (token => vaultAddressFor)
    mapping(address => address) public vaultAddressFor;

    /// @notice associates a given vault from a supported protocol to a given token
    function addVault(address underlying, address vault) external onlyOwner {
        require(vault != address(0),'vault=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] == address(0),'vault already exists, vault upgrade not supported yet');
        vaultAddressFor[underlying] = vault;
    }

    /// @notice Deposit underlying to associated vault, if associated vault exists
    function deposit(address underlying, uint256 amount) external {
        require(amount > 0,'amount=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] != address(0),'no vault');
        require(_deposit(underlying,amount),'deposit failed');
    }

    /// @notice abstract function, to implement by each protocolAdapter
    /// @notice returns true if the deposit was successful, else false
    function _deposit(address underlying, uint256 amount) virtual internal returns (bool);
    
    /// @notice Withdraw underlying from associated vault, if associated vault exists
    function withdraw(address underlying, uint256 amount) external {
        require(amount > 0,'amount=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] != address(0),'no vault');
        require(_withdraw(underlying,amount),'withdraw failed');
    }

    /// @notice abstract function, to implement by each protocolAdapter
    /// @notice returns true if the withdraw was successful, else false
    function _withdraw(address underlying, uint256 amount) virtual internal returns (bool);

}