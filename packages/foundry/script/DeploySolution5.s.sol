// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge5} from "../contracts/Challenge5.sol";
import {Challenge5Solution} from "../contracts/Challenge5Solution.sol";

/**
 * @notice Deploy script for Challenge5Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution5.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution5.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution5 is ScaffoldETHDeploy {
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
        // deployed @ 0x2C71e35D5634A8b4040caB57e5b6FCd9BD485a40 on OP
        Challenge5Solution challenge5Solution = new Challenge5Solution(0xB76AdFe9a791367A8fCBC2FDa44cB1a2c39D8F59);
    }
}
