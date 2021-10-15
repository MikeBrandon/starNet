// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import 'hardhat/console.sol';

contract StarNet {
    uint256 totalStars;

    constructor() {
        console.log('Welcome to StarNet Contract');
    }

    function sendStar() public {
        totalStars += 1;
        console.log('%s just sent a Star!', msg.sender);
    }

    function getTotalStars() public view returns (uint256) {
        console.log('We have %d stars', totalStars);
        return totalStars;
    }
}