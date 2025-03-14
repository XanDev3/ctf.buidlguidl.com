// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge6Solution} from "../contracts/Challenge6Solution.sol";

/**
 * @notice Deploy script for Challenge6Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution6.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution6.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution6 is ScaffoldETHDeploy {
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
        // deployed @ 0xbFa243816C7F80C2b853E61114716ae0240E4892 on OP
        Challenge6Solution challenge6Solution = new Challenge6Solution(0x75961D2da1DEeBaEC24cD0E180187E6D55F55840); //Challenge6 contract on OP
    }
}


