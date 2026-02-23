// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ProMang} from "../src/ProMang.sol";

contract ProMangScript is Script {
    ProMang public promang;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        promang = new ProMang();

        vm.stopBroadcast();
    }
}
