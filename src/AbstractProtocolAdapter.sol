pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
    @title Abstract Protocol Adapter Contract
    @notice Abstract, because it should work for all protocols we interact with
*/

abstract contract AbstractProtocolAdapter is Ownable {

    /// @notice Token to vaVault mapping (token => vaultAddressFor)
    mapping(address => address) public vaultAddressFor;

    /* -------------------------------------------------------------------------- */
    /*                             EXTERNAL FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    /// @notice associates a given vault from a supported protocol to a given token
    function addVault(address underlying, address vault) external onlyOwner {
        require(vault != address(0),'vault=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] == address(0),'vault already exists, vault upgrade not supported yet');
        vaultAddressFor[underlying] = vault;
    }

    /// @notice Deposit underlying to associated vault, if associated vault exists
    function deposit(address underlying, uint256 amount) external { //TODO Only Registry's strategies with same underlying can call that deposit function, make transfer from registry vaVault with same underlying to the Vault
        require(amount > 0,'amount=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] != address(0),'no vault');

        //Call deposit from the specific adapter, and revert if we don't receive shares from the vault
        IERC20 sharesToken = IERC20(vaultAddressFor[underlying]);
        uint256 balanceSharesBefore = sharesToken.balanceOf(address(this));
        _deposit(underlying,amount);
        require(balanceSharesBefore < sharesToken.balanceOf(address(this)),'deposit failed');
    }
    
    /// @notice Withdraw underlying from associated vault, if associated vault exists
    function withdraw(address underlying, uint256 amount) external { //TODO Only Registry's strategies with same underlying can call that withdraw function, make transfer from registry vaVault with same underlying to the Vault
        require(amount > 0,'amount=0');
        require(underlying != address(0),'underlying=0');
        require(vaultAddressFor[underlying] != address(0),'no vault');

        //Call withdraw from the specific adapter, and revert if we don't receive underlying from the vault
        IERC20 underlyingToken = IERC20(underlying);
        uint256 balanceUnderlyingBefore = underlyingToken.balanceOf(address(this));
        _withdraw(underlying,amount);
        require(balanceUnderlyingBefore < underlyingToken.balanceOf(address(this)),'withdraw failed');
    }

    /* -------------------------------------------------------------------------- */
    /*                             ABSTRACT FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    /// @notice abstract function, to implement by each protocolAdapter
    function _deposit(address underlying, uint256 amount) virtual internal;

    /// @notice abstract function, to implement by each protocolAdapter
    function _withdraw(address underlying, uint256 amount) virtual internal;

    /// @notice abstract function, to implement by each protocolAdapter
    /// @notice Returns an uint256 with 18 decimals of how much underlying asset one vault share represents
    function getPricePerShare(address underlying) virtual external view returns (uint256);

    /// @notice abstract function, to implement by each protocolAdapter
    /// @notice Returns an uint256 with 18 decimals how much the vault allows to be withdrawn

    function availableToWithdraw(address underlying) virtual external view returns (uint256);


}