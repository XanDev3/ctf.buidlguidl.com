//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Challenge 4's Deployment
 *      Challenge4 challenge4 = new Challenge4(address(nftFlags));
        console.log("Challenge #4 deployed at", address(challenge4));
        string memory hardhatMnemonic = "test test test test test test test test test test test junk";
        uint256 challenge4AccountPrivateKey = vm.deriveKey(hardhatMnemonic, 12);
        address challenge4AccountAddress = vm.addr(challenge4AccountPrivateKey);
        challenge4.addMinter(challenge4AccountAddress);
 * 
 */
// First create an account from that hardhatMnemonic
// check that it's added as a minter
// Need to sign a message "BG CTF Challenge 4" with that address
// attach that to the call of mintFlag(address _minter, bytes memory signature)

//CONTRACT NOT USED, SEE DeploySolution4.s.sol

contract Challenge4Solution {
    address public challenge4;
    constructor(address _challenge4) {
        challenge4 = _challenge4;

    }
}