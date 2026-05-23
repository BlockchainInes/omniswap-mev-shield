// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MevShield.sol";

contract DeployMevShield is Script {
    function run() external {
        // Holt den Private Key aus den Umgebungsvariablen
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        
        // Startet die Transaktion auf der Blockchain
        vm.startBroadcast(deployerPrivateKey);

        // Hier wird der Vertrag deployed!
        MevShield mevShield = new MevShield();

        vm.stopBroadcast();
    }
}