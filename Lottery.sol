pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address[] public players;
    uint256 public ticketPrice;
    uint256 public prizeAmount;
    uint256 public minimumPlayers;

    constructor(uint256 _ticketPrice, uint256 _prizeAmount, uint256 _minimumPlayers) {
        manager = msg.sender;
        ticketPrice = _ticketPrice;
        prizeAmount = _prizeAmount;
        minimumPlayers = _minimumPlayers;
    }

    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Invalid ticket price");
        players.push(msg.sender);
    }

    function getNumberOfPlayers() public view returns (uint256) {
        return players.length;
    }

    function pickWinner() public restricted {
        require(players.length >= minimumPlayers, "Not enough players to pick a winner");
        
        uint256 winnerIndex = random() % players.length;
        address winner = players[winnerIndex];
        payable(winner).transfer(prizeAmount);
        
        // Reset the lottery for the next round
        delete players;
    }

    function random() private view returns (uint256) {
        return uint256(
            keccak256(
                abi.encodePacked(block.difficulty, block.timestamp, players.length)
            )
        );
    }

    modifier restricted() {
        require(msg.sender == manager, "Access restricted to the manager");
        _;
    }
}
