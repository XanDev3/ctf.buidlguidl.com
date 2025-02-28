// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge4} from "../contracts/Challenge4.sol";
// This is the solution to challenge 4 so no solution contract needed
import { ECDSA } from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import {console} from "forge-std/Script.sol";

/**
 * @notice Deploy script for Challenge3Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution3.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution3.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution4 is ScaffoldETHDeploy {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;
    /**
     * @dev Deployer setup based on `ETH_KEYSTORE_ACCOUNT` in `.env`:
     *      - "scaffold-eth-default": Uses Anvil's account #9 (0xa0Ee7A142d267C1f36714E4a8F75612F20a79720), no password prompt
     *      - "scaffold-eth-custom": requires password used while creating keystore
     *
     * Note: Must use ScaffoldEthDeployerRunner modifier to:
     *      - Setup correct `deployer` account and fund it
     *      - Export contract addresses & ABIs to nextjs & scripts packages
     */
    
    function run(address challenge4Contract) external ScaffoldEthDeployerRunner {
        string memory hardhatMnemonic = "test test test test test test test test test test test junk";
        uint256 minterPrivKey = vm.deriveKey(hardhatMnemonic, 12);
        address minter = vm.addr(minterPrivKey);
        (, address deployer,) = vm.readCallers();
        bytes memory sig;
        
        console.log("minter address in deployer: ", minter);
        console.log("msg.sender from deployer = " , msg.sender);
        console.log("deployer address in deployer = ", deployer);

        sig = createSignature(minterPrivKey, deployer);
        Challenge4(challenge4Contract).mintFlag(minter, sig);
    }

    function createSignature(uint256 _privKey, address user) public pure returns (bytes memory signature){
        bytes32 digest = keccak256(abi.encode("BG CTF Challenge 4", user)).toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(_privKey, digest);
        return signature = abi.encodePacked(r, s, v);
    }
}
