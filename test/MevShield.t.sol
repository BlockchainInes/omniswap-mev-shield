// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MevShield.sol";

contract MevShieldTest is Test {
    MevShield public mevShield;
    address public user = address(0x1);

    function setUp() public {
        mevShield = new MevShield();
    }

    function test_CommitAndReveal() public {
        vm.startPrank(user);
        
        uint256 amount = 1000;
        uint256 minAmountOut = 950;
        bytes32 salt = keccak256(abi.encodePacked("secret"));
        bytes32 commitment = keccak256(abi.encodePacked(user, amount, minAmountOut, salt));
        
        mevShield.commitSwap(commitment);
        
        vm.roll(block.number + 1);
        
        bool success = mevShield.verifyAndReveal(amount, minAmountOut, salt);
        assertTrue(success);
        
        vm.stopPrank();
    }

    function test_FailExpiredRevealWindow() public {
        vm.startPrank(user);
        
        uint256 amount = 1000;
        uint256 minAmountOut = 950;
        bytes32 salt = keccak256(abi.encodePacked("secret"));
        bytes32 commitment = keccak256(abi.encodePacked(user, amount, minAmountOut, salt));
        
        mevShield.commitSwap(commitment);
        
        vm.warp(block.timestamp + 301);
        
        vm.expectRevert("Reveal window expired");
        mevShield.verifyAndReveal(amount, minAmountOut, salt);
        
        vm.stopPrank();
    }
}