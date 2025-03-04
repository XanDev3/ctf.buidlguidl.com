//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IChallenge6 {
    function mintFlag(uint256 code) external;
}

contract Challenge6Solution {
    IChallenge6 challenge6;

    constructor(address _challenge6){
        challenge6 = IChallenge6(_challenge6);
    }

    function name() external pure returns (string memory){
        return "BG CTF Challenge 6 Solution";
    }

    function solve(uint256 _count) public {
        uint256 code = _count << 8; // or _count * 256 aka 2^8
        (bool success, ) = address(challenge6).call{gas: 200_000}( // Gas between 190k-200k 199_000 + 
            abi.encodeWithSignature("mintFlag(uint256)", code)
        );
        require(success, "failed to solve");
 
    }
}