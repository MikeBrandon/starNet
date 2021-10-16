// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import 'hardhat/console.sol';

contract StarNet {
    uint256 totalStars;
    uint256 private seed;

    event NewStar(address indexed from, uint256 timestamp, string message);
    event NewWinner(address indexed from);

    struct Star {
        address sender;
        string message;
        uint256 timestamp;
        bool won;
    }

    Star[] stars;
    mapping(address => uint256) public lastStarred;

    constructor() payable {
        console.log('Welcome to StarNet Contract');
    }

    function sendStar(string memory _message) public {

        require((lastStarred[msg.sender] + 15 minutes) < block.timestamp, 'Wait 15min');
        lastStarred[msg.sender] = block.timestamp;

        totalStars += 1;
        console.log('%s just sent a Star!', msg.sender);

        // NEVER TO BE USED IN AN ACTUAL CONTRACT TO RANDOMIZE!!!
        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);
        seed = randomNumber;

        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");

            stars.push(Star(msg.sender, _message, block.timestamp, true));
            emit NewStar(msg.sender, block.timestamp, _message);
            emit NewWinner(msg.sender);
        } else {
            stars.push(Star(msg.sender, _message, block.timestamp, false));
            emit NewStar(msg.sender, block.timestamp, _message);
        }
    }

    function getTotalStars() public view returns (uint256) {
        console.log('We have %d stars', totalStars);
        return totalStars;
    }

    function getAllStars() public view returns (Star[] memory) {
        return stars;
    }

    function getLastStar() public view returns (uint256) {
        console.log('Last Star:', lastStarred[msg.sender]);
        return lastStarred[msg.sender];
    }
}