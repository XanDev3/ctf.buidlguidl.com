//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
//import { DeploySolution2 } from "./DeploySolution2.s.sol"; - deployed to OP
//import { DeploySolution3 } from "./DeploySolution3.s.sol"; - deployed to OP
import { DeploySolution4 } from "./DeploySolution4.s.sol";

/**
 * @notice Main deployment script for all contracts
 * @dev Run this when you want to deploy multiple contracts at once
 *
 * Example: yarn deploy # runs this script(without`--file` flag)
 */
contract DeployScript is ScaffoldETHDeploy {
    function run() external {
        // Deploys all your contracts sequentially
        // Add new deployments here when needed

        // Deploy Solution 2 - deployed on OP
        //DeploySolution2 deploySolution2 = new DeploySolution2();
        //deploySolution2.run();

        // Deploy Solution 3 - deployed on OP
        // DeploySolution3 deploySolution3 = new DeploySolution3();
        // deploySolution3.run();

        // Deploy Solution 4 - deployed on OP
        //DeploySolution4 deploySolution4 = new DeploySolution4();
        // Challenge 4 contract addres on OP - 0x9c4A48Dd70a3219877a252E9a0d45Fc1Db808a1D
        //deploySolution4.run(0x9c4A48Dd70a3219877a252E9a0d45Fc1Db808a1D);

        // Deploy another contract
        // DeployMyContract myContract = new DeployMyContract();
        // myContract.run();
    }
}
