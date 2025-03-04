// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
// import {Challenge7} from "../contracts/Challenge7.sol";
//import {Challenge7Solution} from "../contracts/Challenge7Solution.sol";

/**
 * @notice Deploy script for Challenge8Solution contract
 * @dev Inherits ScaffoldETHDeploy which:
 *      - Includes forge-std/Script.sol for deployment
 *      - Includes ScaffoldEthDeployerRunner modifier
 *      - Provides `deployer` variable
 * Example:
 * yarn deploy --file DeploySolution8.s.sol  # local anvil chain
 * yarn deploy --file DeploySolution8.s.sol --network optimism # live network (requires keystore)
 */
contract DeploySolution8 is ScaffoldETHDeploy {
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
        // deployed script to OP

        //(bool flagSuccess,) = address(0x663145aA2918282A4F96af66320A5046C7009573).call(abi.encodeWithSignature("unknown8fd628f0(uint256)",0x5D09525B883020C65A2B5cd017FFbE51B6B6c58F));
        // Here encodeWithSignature would not work because we don't know the signature all we know is the selector so I can just reuse the selector and I gathered from this transactionhttps://optimistic.etherscan.io/tx/0x25e130e24ae4d3c660a40e26a03f6329f1c5f27d8a5804654bc9f92b7a7fde6f that the encoded parameter was the sender's address so it was easy to tell I should add my own address
        (bool flagSuccess,) = address(0x663145aA2918282A4F96af66320A5046C7009573).call(abi.encodeWithSelector(bytes4(0x8fd628f0),0x5D09525B883020C65A2B5cd017FFbE51B6B6c58F));
        require(flagSuccess, "Minting failed!");

    }
}
