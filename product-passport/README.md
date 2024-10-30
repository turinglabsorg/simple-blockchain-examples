# Wine Product Passport Smart Contract

## Overview
The Wine Product Passport is a blockchain-based solution for tracking and verifying the authenticity and journey of wine products. This smart contract implements a digital passport system that stores and manages critical information about wine products throughout their lifecycle.

## Features
- Unique digital identity for each wine product
- Secure storage of product information and certifications
- Tracking of ownership transfers
- Verification of product authenticity
- Storage of production and quality control data
- Management of regulatory compliance information

## Contract Structure
The smart contract consists of the following main components:
- Product registration and identification
- Ownership management
- Product information storage
- Certification tracking
- Event logging

## Usage

### Prerequisites
- Solidity ^0.8.0
- OpenZeppelin Contracts
- Hardhat or Truffle development environment

### Installation
1. Clone the repository
2. Install dependencies:
```bash
npm install
```

### Deployment
1. Configure your network settings in the deployment configuration file
2. Deploy the contract:
```bash
npx hardhat run scripts/deploy.js --network <your-network>
```

### Main Functions

#### Creating a New Wine Passport
```solidity
function createPassport(
    string memory productId,
    string memory productData,
    address initialOwner
) public returns (uint256)
```
Creates a new digital passport for a wine product with unique identification and initial product data.

#### Updating Product Information
```solidity
function updateProductInfo(
    uint256 passportId,
    string memory newProductData
) public
```
Updates the stored information for an existing wine passport. Only authorized parties can perform updates.

#### Transferring Ownership
```solidity
function transferPassport(
    uint256 passportId,
    address newOwner
) public
```
Transfers the ownership of a wine passport to a new address. Only the current owner can initiate transfers.

#### Adding Certifications
```solidity
function addCertification(
    uint256 passportId,
    string memory certificationData
) public
```
Adds certification information to a wine passport. Only authorized certifiers can add certifications.

## Events
- `PassportCreated(uint256 indexed passportId, string productId, address owner)`
- `PassportTransferred(uint256 indexed passportId, address from, address to)`
- `ProductInfoUpdated(uint256 indexed passportId, string newProductData)`
- `CertificationAdded(uint256 indexed passportId, string certificationData)`

## Role-Based Access Control
The contract implements role-based access control with the following roles:
- ADMIN_ROLE: Can manage other roles and contract settings
- PRODUCER_ROLE: Can create new passports
- CERTIFIER_ROLE: Can add certifications
- UPDATER_ROLE: Can update product information

## Data Structure
Each wine passport contains:
- Unique identifier (passportId)
- Product information
- Ownership history
- Certifications
- Timestamps for all major events

## Security Features
- Role-based access control
- Ownership validation
- Data integrity checks
- Event logging for transparency
- Emergency pause functionality

## Testing
Run the test suite:
```bash
npx hardhat test
```

To run specific test files:
```bash
npx hardhat test test/WinePassport.test.js
```

## Development
To start local development:
1. Start local Hardhat network:
```bash
npx hardhat node
```

2. Deploy contract to local network:
```bash
npx hardhat run scripts/deploy.js --network localhost
```

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For questions and support, please open an issue in the repository.

## Acknowledgments
- OpenZeppelin for secure contract libraries
- Hardhat development environment
- Ethereum community for best practices and standards
