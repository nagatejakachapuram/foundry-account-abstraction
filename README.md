# Account Abstraction on Ethereum

## Introduction
Account Abstraction (AA) is a concept in Ethereum that aims to improve user experience by making smart contracts function like externally owned accounts (EOAs). This enables features such as gas sponsorship, multi-signature wallets, session keys, and more flexible authentication mechanisms.

This project demonstrates how to implement account abstraction using smart contracts, bundlers, and paymasters.

## Features
- Smart contract-based accounts (ERC-4337)
- UserOperation bundling
- Gas sponsorship through Paymasters
- Custom authentication mechanisms
- Enhanced security and user experience

## Prerequisites
Ensure you have the following installed:
- [Node.js](https://nodejs.org/en/download/) (v16 or later)
- [Foundry](https://getfoundry.sh/) (for smart contract development)
- [Hardhat](https://hardhat.org/) (for testing and deployment)
- [Go-Ethereum](https://geth.ethereum.org/) (optional for local nodes)

## Setup
### 1. Clone the Repository
```sh
git clone https://github.com/foundry-account-abstraction/account-abstraction.git
cd account-abstraction
```

### 2. Install Dependencies
```sh
npm install
```

### 3. Compile Smart Contracts
Using Hardhat:
```sh
npx hardhat compile
```
Using Foundry:
```sh
forge build
```

### 4. Deploy Contracts
```sh
npx hardhat run scripts/deploy.js --network goerli
```

### 5. Run a Bundler (For ERC-4337)
Use a bundler such as [Stackup](https://stackup.sh/) or your own instance:
```sh
yarn start-bundler
```

### 6. Running Tests
```sh
npx hardhat test
```

## Usage
1. Create a smart contract wallet
2. Sign transactions with a custom authentication method
3. Bundle user operations and submit them to the EntryPoint contract
4. Use Paymasters to sponsor gas fees

## Folder Structure
```
account-abstraction/
│── contracts/           # Solidity contracts for smart wallets
│── scripts/            # Deployment and interaction scripts
│── test/               # Unit tests for contracts
│── bundler/            # Bundler implementation
│── README.md           # Project documentation
```

## Future Improvements
- Implement more authentication methods
- Optimize gas efficiency
- Integrate with different paymasters
- Expand support for L2 solutions

## Resources
- [EIP-4337: Account Abstraction](https://eips.ethereum.org/EIPS/eip-4337)
- [Ethereum.org - Account Abstraction](https://ethereum.org/en/developers/docs/account-abstraction/)
- [Stackup Bundler](https://stackup.sh/)

## License
This project is licensed under the MIT License.

