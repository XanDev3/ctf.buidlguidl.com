//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {Challenge5Solution} from "../../contracts/Challenge5Solution.sol";
import {Challenge5} from "../../contracts/Challenge5.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.sol";

contract Challenge5Test is Test {
    Challenge5 challenge5Contract;
    Challenge5Solution solutionAddr;
    NFTFlagsMock nftFlagsMock;
    address owner;
    function setUp() public {
        owner = makeAddr("owner");
        vm.deal(owner, 1 ether);
        vm.startBroadcast(owner);
            nftFlagsMock = new NFTFlagsMock(owner);
            challenge5Contract = new Challenge5(address(nftFlagsMock));
            solutionAddr = new Challenge5Solution(address(challenge5Contract));
            nftFlagsMock.addAllowedMinter(address(challenge5Contract));
        vm.stopBroadcast();
    }

    function testPointsAccumulate() public {
        vm.startBroadcast(owner);
            solutionAddr.startClaimingPoints();
        vm.stopBroadcast();
        console.log("points: ",solutionAddr.points());
        assertEq(solutionAddr.points(), uint256(10));
    }

    function testCanMintAfterClaim() public {
        vm.startBroadcast(owner);
            solutionAddr.startClaimingPoints();
            challenge5Contract.mintFlag();
        vm.stopBroadcast();
        console.log("points: ",solutionAddr.points());
        assertEq(nftFlagsMock.hasMinted(owner, 5), true);
    }
}