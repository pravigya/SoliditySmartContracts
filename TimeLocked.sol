pragma solidity ^0.8.0;

contract TimeLockedContract {
    uint256 private releaseTime;
    address private beneficiary;
    uint256 private amount;

    constructor(address _beneficiary, uint256 _releaseTime) payable {
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
        amount = msg.value;
    }

    function withdraw() external {
        require(block.timestamp >= releaseTime, "Funds are locked");
        require(msg.sender == beneficiary, "Only the beneficiary can withdraw");
        
        payable(beneficiary).transfer(amount);
    }

    function getReleaseTime() external view returns (uint256) {
        return releaseTime;
    }
}
