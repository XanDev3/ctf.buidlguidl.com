//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {NFTFlagsMock} from "../mocks/NftFlagsMock.sol";


interface IChallenge8 {
    function nftContract() external view returns (address);
    function unknown8fd628f0(uint256 _param1) external;
}

contract Challenge8Test is Test {
    address challenge8;
    address mine;
    address nftContract;

    function setUp() public {
        challenge8 = 0x663145aA2918282A4F96af66320A5046C7009573;
        nftContract = 0xc1Ebd7a78FE7c075035c516B916A7FB3f33c26cE;
        mine = 0x5D09525B883020C65A2B5cd017FFbE51B6B6c58F;
    }

    function testGetNftContractWorks() public view {
        IChallenge8 target = IChallenge8(challenge8);

        assertEq(target.nftContract(), nftContract);
    }
    function testScriptCanMint() public {
        IChallenge8 target = IChallenge8(challenge8);
        vm.prank(mine);
        (bool flagSuccess,) = address(target).call(abi.encodeWithSelector(bytes4(0x8fd628f0),mine));
        require(flagSuccess, "Minting failed!");

        assertEq(flagSuccess, true);
        assertEq(NFTFlagsMock(nftContract).hasMinted(mine, 8), true);

    }
}