// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge2} from "../contracts/Challenge2.sol";
import {CallChallenge2} from "../contracts/CallChallenge2.sol";

/**
 * @notice Deploy script for Challenge2Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution2.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution2.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution2 is ScaffoldETHDeploy {
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
        // Deployed @0xf184d196fD7005350387B22a1ea99152ec8388aA on OP
        CallChallenge2 challenge2Solution = new CallChallenge2(0x0b997E0a306c47EEc755Df75fad7F41977C5582d, 0x5D09525B883020C65A2B5cd017FFbE51B6B6c58F);
    }
}
