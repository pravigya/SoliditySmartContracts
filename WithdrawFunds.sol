pragma solidity ^0.8.0;

contract WithdrawFunds {

    address private owner;

    constructor(){
        owner = msg.sender;

    }

    modifier onlyOwner(){
        require(msg.sender ==owner, "access denied");
        _;
    }

    function withdraw(uint256 amount) public onlyOwner{
        require(address(this).balance >= amount, "Insufficient contract balance");
        payable(msg.sender).transfer(amount);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}