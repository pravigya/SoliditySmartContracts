pragma solidity ^0.8.0;

contract BalanceChecker {
    function getBalance(address _address) public view returns (uint256) {
        return _address.balance;
    }
}
