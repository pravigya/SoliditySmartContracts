// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockVerifier {
    struct BlockHeader {
        bytes32 previousBlockHash;
        bytes32 merkleRoot;
        uint256 timestamp;
        uint256 difficulty;
        uint256 nonce;
    }

    function verifyBlockHeader(
        BlockHeader memory header,
        bytes32 targetDifficulty
    ) public pure returns (bool) {
        // Check the proof of work
        bytes32 blockHash = calculateBlockHash(header);
        require(blockHash <= targetDifficulty, "Proof of work verification failed");

        // Additional checks can be added, such as verifying the previous block hash,
        // checking the timestamp, etc.

        return true;
    }

    function calculateBlockHash(BlockHeader memory header)
        internal
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    header.previousBlockHash,
                    header.merkleRoot,
                    header.timestamp,
                    header.difficulty,
                    header.nonce
                )
            );
    }
}
