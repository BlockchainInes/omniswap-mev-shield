// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MevShield {
    
    struct Commit {
        bytes32 commitmentHex;
        uint256 timestamp;
        bool revealed;
    }

    mapping(address => Commit) public userCommitments;
    
    uint256 public constant MIN_REVEAL_DELAY = 1;
    uint256 public constant MAX_REVEAL_WINDOW = 300;

    event LogCommitted(address indexed user, bytes32 indexed commitment);
    event LogRevealed(address indexed user, uint256 amount, uint256 minAmountOut);

    function commitSwap(bytes32 _commitment) external {
        require(_commitment != bytes32(0), "Invalid commitment hash");
        
        userCommitments[msg.sender] = Commit({
            commitmentHex: _commitment,
            timestamp: block.timestamp,
            revealed: false
        });

        emit LogCommitted(msg.sender, _commitment);
    }

    function verifyAndReveal(
        uint256 _amount,
        uint256 _minAmountOut,
        bytes32 _salt
    ) external view returns (bool) {
        Commit memory storedCommit = userCommitments[msg.sender];
        
        require(storedCommit.timestamp > 0, "No commitment found");
        require(!storedCommit.revealed, "Commitment already revealed");
        require(block.timestamp <= storedCommit.timestamp + MAX_REVEAL_WINDOW, "Reveal window expired");

        bytes32 computedHash = keccak256(abi.encodePacked(msg.sender, _amount, _minAmountOut, _salt));
        require(computedHash == storedCommit.commitmentHex, "Cryptographic verification failed");

        return true;
    }
}