// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address payable[] public players;

    constructor() {
        manager = msg.sender;
    }

    function alreadyEntered() public view returns(bool) {
        for (uint i = 0; i < players.length; i++) {
            if (players[i] == msg.sender) {
                return true;
            }
        }
        return false;
    }

    function enter() public payable {
        require(msg.sender != manager, "Manager cannot enter");
        require(!alreadyEntered(), "You are already entered");
        require(msg.value > 1 ether, "Minimum entry value is 1 ether");

        players.push(payable(msg.sender));
    }

    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick the winner");
        require(players.length > 0, "No players in the lottery");

        uint index = random() % players.length;
        address payable winner = players[index];
        winner.transfer(address(this).balance);

        // Reset the players array
        players = new address payable[](0) ;
    }
}
