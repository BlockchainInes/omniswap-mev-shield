# OmniSwap-MEV-Shield 🛡️

An institutional-grade, highly optimized security infrastructure framework engineered for decentralized exchanges (DEXs). This system leverages a cryptographic **Commit-Reveal Scheme** to achieve absolute protection against front-running, sandwich attacks, and generalized mempool front-runners, ensuring zero toxic value extraction from user payloads.

## Key Architecture Benefits

* **Optimal Scalability:** Built and compiled using the high-performance **Foundry** native testing framework, bypassing bloated runtime dependencies and reducing test execution costs.
* **Mempool Front-Running Immunity:** Obfuscates raw trade payloads entirely during the pending state phase, leaving zero vector details for arbitrage bots to analyze or exploit.
* **Strict Expiration Guardrails:** Restricts the execution horizon using automated block-based boundaries, protecting stale trades from changing market volatility.

## Technical Blueprint

The architecture isolates the hidden transaction intent from deterministic state validation using two phases:

1. **Commit Phase:** The user anchors a cryptographic hash (`keccak256`) containing the targeted contract payload, execution metrics, and a cryptographically hidden secret salt onto the ledger.
2. **Reveal Phase:** Following a mandatory verification block window delay, the user submits the unhashed, raw parameters along with the matching salt. The contract verifies integrity against the record and triggers execution atomically.

```text
       [ USER / WALLET ]
               │
      1. COMMIT PHASE (Blocks: N)
               │  (Submits Keccak256 Hash of: Target + Payload + Secret Salt)
               ▼
   ┌───────────────────────┐      [ MEMPOOL BOTS ]
   │  MevShield Contract   │ ───►  (See the hash, but CANNOT see
   └───────────────────────┘       the trade details or payload!)
               │
      ⏰ MANDATORY DELAY (e.g. 1+ Blocks)
               │
      2. REVEAL PHASE (Blocks: N + 1)
               │  (Submits Raw Parameters + Salt)
               ▼
   ┌───────────────────────┐
   │ Matches Hash? ──► YES │ ───► [ ATOMIC EXECUTION ] ──► (Target DEX)
   └───────────────────────┘

Core Project Directory
Plaintext
├── .github/          # Automated pipeline configs
├── lib/              # Foundry core Forge dependencies
├── script/
│   └── Deploy.s.sol  # On-chain smart contract deployment engine
├── src/
│   ├── MevShield.sol # Core MEV security smart contract
│   └── OmniRouter.sol# Decoupled mock swap executing engine
├── test/
│   └── MevShield.t.sol# Comprehensive automated validation test suite
├── .env              # Localized configuration deployment environment
├── foundry.toml      # Hardened compiler and framework options
└── README.md         # Documentation layout overview
================================================================================

PROTOCOL EXECUTION PROOF (TERMINAL & SMART CONTRACT VERIFICATION)
The protocol is fully operational, validated, and successfully deployed to the public test ledger:

The protocol is fully operational, validated, and successfully deployed to the public test ledger:

Verified Live Contract Address: 0x9685ed0b956580f8b46ce68696c15e7508dd43f8

Official Blockchain Explorer Record: View Open-Source Verified Contract on Sepolia Etherscan


Verified Live Contract Address: 0x9685ed0b956580f8b46ce68696c15e7508dd43f8
Official Blockchain Explorer Record: [View Open-Source Verified Contract on Sepolia Etherscan]
https://sepolia.etherscan.io/address/0x9685ed0b956580f8b46ce68696c15e7508dd43f8#code

================================================================================
SETUP & DEPLOYMENT GUIDE

1. Installation
Install and set up the professional Foundry testing environment workspace:

PowerShell
curl -L [https://foundry.paradigm.xyz](https://foundry.paradigm.xyz) | bash
foundryup
Initialize standard workspace dependencies:

PowerShell
forge init --force

2. Boilerplate Clean Up
Remove unneeded automated template logic to prevent compile mismatches:

PowerShell
Remove-Item script/Counter.s.sol

3. Configuration Setup
Populate localized environment values within a .env deployment file in the root workspace folder:

Fragmento de código
PRIVATE_KEY=0x9685ed0b956580f8b46ce68696c15e7508dd43f8...
SEPOLIA_RPC_URL=[https://eth-sepolia.g.alchemy.com/v2/
YOUR_ALCHEMY_API_KEY](https://eth-sepolia.g.alchemy.com/v2/
YOUR_ALCHEMY_API_KEY)
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_SECRET_API_KEY

4. Compilation Pipeline
Compile the smart contracts directly utilizing the high-speed Solc infrastructure engine:

PowerShell
forge compile

5. Executing the Test Suite
Trigger the full validation matrix evaluating phase transitions, storage verification, and cryptographic hash checks:

PowerShell
forge test -vvv

6. Production Network Deployment Simulation & Execution
Broadcast the script directly onto the Ethereum Sepolia Live Ledger parsing local .env values dynamically:

PowerShell
forge script script/Deploy.s.sol:DeployMevShield --rpc-url (Get-Content .env | Where-Object {$_ -match "SEPOLIA_RPC_URL"} | ForEach-Object {$_ -replace "SEPOLIA_RPC_URL=",""}) --private-key (Get-Content .env | Where-Object {$_ -match "PRIVATE_KEY"} | ForEach-Object {$_ -replace "PRIVATE_KEY=",""}) --broadcast

7. Contract Source Code Verification
Publish and register the source implementation files on Etherscan for trustless checking:

PowerShell
forge verify-contract 0x9685ed0b956580f8b46ce68696c15e7508dd43f8 src/MevShield.sol:MevShield --chain-id 11155111 --etherscan-api-key (Get-Content .env | Where-Object {$_ -match "ETHERSCAN_API_KEY"} | ForEach-Object {$_ -replace "ETHERSCAN_API_KEY=",""})

Developed for Web3 Security & Advanced Portfolio Showcasing.
