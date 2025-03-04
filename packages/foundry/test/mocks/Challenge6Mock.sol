//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import {NFTFlagsMock} from "./NftFlagsMock.sol";
import {console} from "forge-std/console.sol";

interface IContract6Solution {
    function name() external view returns (string memory);
}

contract Challenge6Mock {
    using Strings for uint256;

    address public nftContract;
    uint256 public count;

    constructor(address _nftContract) {
        nftContract = _nftContract;
    }

    function mintFlag(uint256 code) public {
        uint256 gasStart = gasleft();
        console.log("gas start: ", gasStart);
        require(code == count << 8, "Wrong code");
        require(
            keccak256(abi.encodePacked(IContract6Solution(msg.sender).name()))
                == keccak256("BG CTF Challenge 6 Solution"),
            "Wrong name"
        );
        uint256 gasEnd = gasleft();
        console.log("gasEnd :", gasEnd);
        console.log("gasUSed : ", gasStart - gasEnd );
        uint256 gas = gasleft();
        console.log("gas remaining: ", gas);
        require(gas > 190_000 && gas < 200_000, string.concat("Wrong gas: ", gas.toString()));

        NFTFlagsMock(nftContract).mint(tx.origin, 6);
        count += 1;
    }
}
