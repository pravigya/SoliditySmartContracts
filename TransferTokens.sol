pragma solidity ^0.8.0;

contract Token {

    mapping(address => uint256) public balances;

    function transfer(address _to, uint256 _amount) public {
        
        require(balances[msg.sender]>=_amount, "Insufficient Balance" );
        require(_to!=address(0), "Invalid recipient");

        balances[msg.sender]-=_amount;
        balances[_to]+=_amount;
    }
}