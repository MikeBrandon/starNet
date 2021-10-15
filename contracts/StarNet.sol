// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import 'hardhat/console.sol';

contract StarNet {
    uint256 totalStars;

    event NewStar(address indexed from, uint256 timestamp, string message);

    struct Star {
        address sender;
        string message;
        uint256 timestamp;
    }

    Star[] stars;

    constructor() {
        console.log('Welcome to StarNet Contract');
    }

    function sendStar(string memory _message) public {
        totalStars += 1;
        console.log('%s just sent a Star!', msg.sender);

        stars.push(Star(msg.sender, _message, block.timestamp));

        emit NewStar(msg.sender, block.timestamp, _message);
    }

    function getTotalStars() public view returns (uint256) {
        console.log('We have %d stars', totalStars);
        return totalStars;
    }

    function getAllStars() public view returns (Star[] memory) {
        return stars;
    }
}