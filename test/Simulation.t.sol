// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {VaVault} from "../src/VaVault.sol";
import {Registry} from "../src/Registry.sol";
import {MintableERC20} from "../src/MintableERC20.sol";

contract CounterTest is Test {
    MintableERC20 public mockDAI;
    VaVault public vaDAI;
    Registry public registry;

    function setUp() public {
       //create mock DAI
       mockDAI = new MintableERC20('mock of DAI', 'DAI', 10000);
       
       //create vaDAI
       vaDAI = new VaVault(mockDAI,'DAI vaultemore vault','vaDAI');

       //create registry
       registry = new Registry();

       //Add vaVault to registry
       registry.addVaVault(address(mockDAI),address(vaDAI));
    }

    function testCorrectSetUp() public {
        assertEq(mockDAI.totalSupply(), 10000 * 10 ** 18);
        assertEq(vaDAI.symbol(), 'vaDAI');
        assertEq(MintableERC20(vaDAI.asset()).symbol(), 'DAI');
        assertEq(registry.getAllVaVaults().length, 1);
    }

}
