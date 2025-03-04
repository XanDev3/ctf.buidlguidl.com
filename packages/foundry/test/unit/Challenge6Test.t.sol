//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {Challenge6Solution} from "../../contracts/Challenge6Solution.sol";
import {Challenge6Mock} from "../mocks/Challenge6Mock.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract Challenge6Test is Test {
    using Strings for uint256;

    Challenge6Mock challenge6Contract;
    Challenge6Solution solutionAddr;
    NFTFlagsMock nftFlagsMock;
    address user;
    function setUp() public {
        user = makeAddr("user");
        vm.deal(user, 1 ether);
        vm.startBroadcast(user);
            nftFlagsMock = new NFTFlagsMock(user);
            challenge6Contract = new Challenge6Mock(address(nftFlagsMock));
            solutionAddr = new Challenge6Solution(address(challenge6Contract)/* , "BG CTF Challenge 6 Solution" */);
            nftFlagsMock.addAllowedMinter(address(challenge6Contract));
        vm.stopBroadcast();
    }

    function testChal6CountIsZero() public view{
        assertEq(challenge6Contract.count(), 0);
    }
// Test passed prior to refactor back to correct solution
 /*    function testCodeIsCorrect() public {
        Challenge6Solution wrongNameSolution = new Challenge6Solution(address(challenge6Contract), "Wrong name");
        // The 2nd require in Challenge6 is for wrong name and we pass changed the name in the contract to the wrong one so that we can confirm the first require passes and the second is where the revert occurs. In the deployed contract we will simply return a string that is the correct name to save gas.
        vm.expectRevert(bytes("Wrong name"));
        wrongNameSolution.solve();
        console.log("code :", wrongNameSolution.codeForChal6());
    } */
    
    function testNameIsCorrect() public {
        vm.expectRevert(bytes(string.concat("Wrong gas: ", gasleft().toString())));
        // If test reverts on gasleft() then name is correct
        solutionAddr.solve(challenge6Contract.count());
    }

    function testCanSolveCorrectly() public{
        assertEq(nftFlagsMock.hasMinted(tx.origin, 6), false);

        
        vm.prank(msg.sender); // Costs: 200
        solutionAddr.solve(challenge6Contract.count());
        

        assertEq(nftFlagsMock.hasMinted(tx.origin, 6), true);
    }

}