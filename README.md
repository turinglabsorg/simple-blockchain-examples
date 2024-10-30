# Wine Passport Smart Contract

A blockchain-based solution for tracking and verifying wine authenticity and quality throughout its lifecycle. This smart contract implements a digital passport system for wine products, allowing authorized producers to register wines and certified inspectors to add quality checks.

## Overview

The Wine Passport system provides a transparent and immutable record of wine products, including:
- Basic wine details (name, producer, harvest year, etc.)
- Production information
- Quality control checks
- Organic certification status

## Features

- **Role-Based Access Control**
  - Owner: Can manage producer and inspector roles
  - Producers: Can create wine passports
  - Inspectors: Can add quality checks
  - Public: Can view wine details and quality checks

- **Wine Passport Creation**
  - Unique product ID for each wine
  - Comprehensive wine details including:
    - Wine name and producer
    - Harvest year
    - Grape variety
    - Region
    - Alcohol content
    - Bottling date
    - Vinification process
    - Total bottles produced
    - Organic certification status

- **Quality Control System**
  - Multiple quality checks per wine
  - Timestamp for each inspection
  - Inspector identification
  - Numerical scoring (0-100)
  - Detailed inspection notes

## Technical Details

### Prerequisites

- Node.js and npm
- Hardhat or Truffle
- OpenZeppelin Contracts

### Installation

1. Clone the repository: 