// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {Challenge3} from "../contracts/Challenge3.sol";
import {Challenge3Solution} from "../contracts/Challenge3Solution.sol";

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
contract DeploySolution3 is ScaffoldETHDeploy {
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
        // deployed @ 0x8E6097119636f5A6382d6DdCC93e6Dfc62c86bAf on OP
        Challenge3Solution challenge3Solution = new Challenge3Solution(0x03bF70f50fcF9420f27e31B47805bbd8f2f52571);
    }
}
