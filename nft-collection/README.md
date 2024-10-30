# NFT-Based Product Authentication System

A smart contract system for creating and managing NFT-based certificates of authenticity for physical products. This system enables brands and manufacturers to issue digital certificates of authenticity that are linked to their physical products.

## Overview

The NFT Collection system provides:
- Unique digital certificates for physical products
- Verifiable ownership and transfer history
- Product metadata storage and retrieval
- Brand authentication mechanisms

## Features

- **Brand Management**
  - Verified brand accounts
  - Multiple product lines per brand
  - Customizable metadata standards

- **NFT Certificate Creation**
  - Unique token ID per product
  - Secure minting process
  - Product metadata linking
  - Batch minting capabilities

- **Authentication Features**
  - QR code integration
  - Serial number verification
  - Manufacturing date tracking
  - Ownership history

## Technical Details

### Smart Contract Architecture

The system consists of the following components:
- ERC-721 compliant NFT contract
- Access control system
- Metadata management
- Brand verification system

### Prerequisites

- Node.js and npm
- Hardhat development environment
- OpenZeppelin Contracts
- IPFS (for metadata storage)

### Installation

1. Install the package in your project:
```bash
npm install @openzeppelin/contracts
```

2. Import required contracts:
```solidity
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
```

### Main Functions

#### Administrative Functions
- `registerBrand(address, string)`: Register a new brand
- `revokeBrand(address)`: Revoke brand access
- `updateBrandMetadata(string)`: Update brand information

#### Brand Functions
- `mintCertificate(address, uint256, string)`: Create new product certificate
- `batchMintCertificates(address[], uint256[], string[])`: Batch create certificates
- `setProductMetadata(uint256, string)`: Update product information

#### Public Functions
- `verifyCertificate(uint256)`: Verify certificate authenticity
- `getProductDetails(uint256)`: Retrieve product information
- `getBrandInfo(address)`: Get brand details

## Usage Example

```solidity
// Deploy contract
const NFTCollection = await ethers.getContractFactory("NFTCollection");
const nftCollection = await NFTCollection.deploy("Product Certificates", "CERT");

// Register a brand
await nftCollection.registerBrand(
    brandAddress,
    "Brand Metadata URI"
);

// Mint certificate (as brand)
await nftCollection.connect(brand).mintCertificate(
    ownerAddress,
    productId,
    "ipfs://ProductMetadataURI"
);

// Verify certificate
const isValid = await nftCollection.verifyCertificate(tokenId);
```

## Metadata Standard

### Brand Metadata
```json
{
    "name": "Brand Name",
    "description": "Brand Description",
    "logo": "ipfs://LogoURI",
    "website": "https://brand.com",
    "verificationDetails": {
        "registrationNumber": "12345",
        "verificationDate": "2024-01-01"
    }
}
```

### Product Metadata
```json
{
    "name": "Product Name",
    "description": "Product Description",
    "image": "ipfs://ProductImageURI",
    "attributes": [
        {
            "trait_type": "Manufacturing Date",
            "value": "2024-01-01"
        },
        {
            "trait_type": "Serial Number",
            "value": "SN123456789"
        }
    ]
}
```

## Security Features

- Role-based access control
- Pausable functionality for emergencies
- Brand verification system
- Immutable certificate records
- Anti-counterfeit measures

## Events

The contract emits the following events:
- `BrandRegistered(address indexed brand, string metadataURI)`
- `CertificateMinted(uint256 indexed tokenId, address indexed brand)`
- `MetadataUpdated(uint256 indexed tokenId, string newURI)`

## Gas Optimization

- Batch minting capabilities
- Efficient storage patterns
- Optimized metadata management
- Minimal on-chain storage

## Testing

Run the test suite:
```bash
npx hardhat test test/NFTCollection.test.js
```

## Future Improvements

- Enhanced metadata standards
- Multi-signature brand verification
- Integration with physical authentication methods
- Secondary market royalties
- Cross-chain compatibility
- Advanced analytics dashboard

## License

This project is licensed under the MIT License - see the LICENSE file for details. 