//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


interface iChallenge2 {
    function justCallMe() external;
}

contract CallChallenge2 is Ownable {
    address iChallenge2Address;
    
    constructor(address _iChallenge2, address initialOwner) Ownable(initialOwner){
        iChallenge2Address = _iChallenge2;
    }

    function callIt() public onlyOwner{
        iChallenge2(iChallenge2Address).justCallMe();
    }
    receive() external payable {}
}