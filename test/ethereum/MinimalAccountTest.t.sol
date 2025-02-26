// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import {MinimalAccount} from "../../src/ethereum/MinimalAccount.sol";
import {DeployMinimal} from "../../script/DeployMinimal.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MinimalAccountTest is Test {
    DeployMinimal deployMinimal;
    HelperConfig helperConfig;
    MinimalAccount minimalAccount;
    ERC20Mock usdc;

    address randomUser = makeAddr("randomUser");

    uint256 constant AMOUNT = 1e18;

    function setUp() public {
        console.log("Initializing DeployMinimal...");
        deployMinimal = new DeployMinimal();

        console.log("Calling deployMinimalAccount...");
        (helperConfig, minimalAccount) = deployMinimal.deployMinimalAccount();

        console.log("MinimalAccount deployed at:", address(minimalAccount));

        usdc = new ERC20Mock();
    }

    // USDC Approval
    // msg.sender -> Minimal Account
    // approve some amount
    // usdc contract
    // should come from entryPoint
    function testOwnerCanExecuteCommands() public {
        // Arrange
        assertEq(usdc.balanceOf(address(minimalAccount)), 0);
        address dest = address(usdc);
        uint256 value = 0;
        bytes memory functionData = abi.encodeWithSelector(ERC20Mock.mint.selector, address(minimalAccount), AMOUNT);

        // Act
        vm.prank(minimalAccount.owner());
        minimalAccount.execute(dest, value, functionData);

        // Assert
        assertEq(usdc.balanceOf(address(minimalAccount)), AMOUNT);
    }

    function testNonOwnerCannotExecuteCommands() public {
        // Arrange
        assertEq(usdc.balanceOf(address(minimalAccount)), 0);
        address dest = address(usdc);
        uint256 value = 0;
        bytes memory functionData = abi.encodeWithSelector(ERC20Mock.mint.selector, address(minimalAccount), AMOUNT);

        // Act
        vm.prank(randomUser);
        vm.expectRevert(MinimalAccount.MinimalAccount_NotFromEntryPointOrOwner.selector);
        minimalAccount.execute(dest, value, functionData);
    }
}
