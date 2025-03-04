//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {Challenge4Solution} from "../../contracts/Challenge4Solution.sol";
import {DeploySolution4} from "../../script/DeploySolution4.s.sol";
import {Challenge4} from "../../contracts/Challenge4.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.sol";
import { ECDSA } from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";


contract Challenge4Test is Test {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;


    Challenge4 challenge4Addr;
    Challenge4Solution solutionAddr;
    NFTFlagsMock nftFlagsMock;
    address owner;
    address minter;
    uint256 minterPrivKey;
    bytes challengeSig;
    DeploySolution4 deployer;

    function setUp() public {
        owner = makeAddr("owner");
        // Next 3 lines are from deployer except the assignment to minter variable
        string memory hardhatMnemonic = "test test test test test test test test test test test junk";
        minterPrivKey = vm.deriveKey(hardhatMnemonic, 12);
        minter = vm.addr(minterPrivKey);
        

        vm.deal(owner, 1 ether);
        vm.deal(minter, 1 ether);
        vm.startBroadcast(owner);
            nftFlagsMock = new NFTFlagsMock(owner);
            challenge4Addr = new Challenge4(address(nftFlagsMock));
            challenge4Addr.addMinter(minter);
            nftFlagsMock.addAllowedMinter(address(challenge4Addr));
            deployer = new DeploySolution4();
        vm.stopBroadcast();
        console.log("minter addr:", minter);
                // create signature
        vm.startPrank(minter);
        bytes32 digest = keccak256(abi.encode("BG CTF Challenge 4", owner)).toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(minterPrivKey, digest);
        bytes memory signature = abi.encodePacked(r, s, v); // note the order here is different from line above.
        challengeSig = signature;
        vm.stopPrank();
        
    }

    function testMinterAdded() public view {
        assertEq(challenge4Addr.isMinter(minter), true);
    }

    function testSignatureIsValid() public view {

/*         vm.startPrank(minter);
        bytes32 digest = keccak256(abi.encode("BG CTF Challenge 4", owner)).toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(minterPrivKey, digest);
        bytes memory signature = abi.encodePacked(r, s, v); // note the order here is different from line above.
        challengeSig = signature;
        vm.stopPrank(); */
        // recover from signature
        bytes32 message = keccak256(abi.encode("BG CTF Challenge 4", owner));
        bytes32 hash = message.toEthSignedMessageHash();
        address recoveredSigner = hash.recover(challengeSig);
        console.log("recovered signer: ", recoveredSigner);

        assertEq(recoveredSigner, minter);
    }

    function testCanMintNft() public {
        vm.startBroadcast(owner);
            challenge4Addr.mintFlag(minter, challengeSig);
        vm.stopBroadcast();
        assertEq(nftFlagsMock.hasMinted(owner, 4), true);
    }

    function testDeployScript() public {
        
        deployer.run(address(challenge4Addr));


        console.log("msg.sender address =", msg.sender);
        console.log("owner address =", owner);
        assertEq(nftFlagsMock.hasMinted(msg.sender, 4), true);
    }


}