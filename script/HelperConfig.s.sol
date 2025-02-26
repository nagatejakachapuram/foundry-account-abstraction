// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    error HelperConfig_InvalidChainId();

    struct NetwrokConfig {
        address entryPoint;
        address account;
    }

    uint256 constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 constant LOCAL_CHAIN_ID = 31337;
    address constant BURNER_WALLET = 0x0B06159B8E0097d03Bdf9eA9d441Ec8DfE22D99e;
    address constant FOUNDRY_DEFAULT_WALLET = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;

    NetwrokConfig public localNetworkConfig;

    mapping(uint256 chainId => NetwrokConfig) public networkConfigs;

    constructor() {
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getEthSepoliaConfig();
    }

    function getConfig() public view returns (NetwrokConfig memory) {
        return getConfigByChainId(block.chainid);
    }

    function getConfigByChainId(uint256 chainId) public view returns (NetwrokConfig memory) {
        if (chainId == LOCAL_CHAIN_ID) {
            return getOrCreateAnvilEthConfig();
        } else if (networkConfigs[chainId].account != address(0)) {
            return networkConfigs[chainId];
        } else {
            revert HelperConfig_InvalidChainId();
        }
    }

    function getEthSepoliaConfig() public pure returns (NetwrokConfig memory) {
        return NetwrokConfig({entryPoint: 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789, account: BURNER_WALLET});
    }

    function getZksyncSepoliaConfig() public pure returns (NetwrokConfig memory) {
        return NetwrokConfig({entryPoint: address(0), account: BURNER_WALLET});
    }

    function getOrCreateAnvilEthConfig() public view returns (NetwrokConfig memory) {
        if (localNetworkConfig.account != address(0)) {
            return localNetworkConfig;
        }
        return NetwrokConfig({entryPoint: address(0), account: FOUNDRY_DEFAULT_WALLET});

        // Deploy a mock entry point contract
    }
}
