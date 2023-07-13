pragma solidity ^0.8.0;

contract VotingSystem {
    mapping(address => bool) public hasVoted;
    mapping(bytes32 => uint256) public voteCount;

    function vote(bytes32 candidate) public {
        require(!hasVoted[msg.sender], "Address has already voted.");

        hasVoted[msg.sender] = true;
        voteCount[candidate]++;
    }
}
