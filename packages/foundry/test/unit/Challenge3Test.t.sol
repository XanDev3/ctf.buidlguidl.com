//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {Challenge3Solution} from "../../contracts/Challenge3Solution.sol";
import {Challenge3} from "../../contracts/Challenge3.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.s.sol";
import {DeployChallenges} from "../../script/DeployChallenges.s.sol";
contract Challenge3Test is Test {
    Challenge3 challenge3Addr;
    Challenge3Solution solutionAddr;
    NFTFlagsMock nftFlagsMock;
    address owner;
/*     DeployChallenges helper;
    address[] deployedChallenges; */
    function setUp() public {
        owner = makeAddr("owner");
        vm.deal(owner, 1 ether);
/*         (deployedChallenges) = helper.run();
        // should be deployedChallenges = [c1, c2, c3][0,1,2]
        console.log(deployedChallenges[2]); */
        vm.startBroadcast(owner);
            nftFlagsMock = new NFTFlagsMock(owner);
            challenge3Addr = new Challenge3(address(nftFlagsMock));
            nftFlagsMock.addAllowedMinter(address(challenge3Addr));
            solutionAddr = new Challenge3Solution(address(challenge3Addr));
        vm.stopBroadcast();
    }

    function testNftFlagsOwner() public view {
        assertEq(nftFlagsMock.owner(), owner);
        console.log("tokenidcounter :", nftFlagsMock.tokenIdCounter());
        console.log("owner has minted? :", nftFlagsMock.hasMinted(owner, 3));
    }

}