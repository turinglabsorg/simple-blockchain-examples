// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WinePassport is AccessControl, Ownable {
    bytes32 public constant PRODUCER_ROLE = keccak256("PRODUCER_ROLE");
    bytes32 public constant INSPECTOR_ROLE = keccak256("INSPECTOR_ROLE");

    struct WineDetails {
        string wineName;
        string producer;
        uint256 harvestYear;
        string grapeVariety;
        string region;
        uint256 alcoholContent; // Stored as percentage * 100 (e.g., 13.5% = 1350)
        uint256 bottlingDate;
        string vinificationProcess;
        uint256 totalBottles;
        bool organicCertified;
        mapping(uint256 => QualityCheck) qualityChecks;
        uint256 qualityCheckCount;
    }

    struct QualityCheck {
        uint256 date;
        string inspector;
        uint256 score; // Out of 100
        string notes;
    }

    // Maps product ID to wine details
    mapping(uint256 => WineDetails) private winePassports;
    uint256[] private registeredProductIds;

    event WinePassportCreated(uint256 indexed productId, string wineName, string producer);
    event QualityCheckAdded(uint256 indexed productId, uint256 date, uint256 score);

    constructor() Ownable(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function createWinePassport(
        uint256 productId,
        string memory wineName,
        string memory producer,
        uint256 harvestYear,
        string memory grapeVariety,
        string memory region,
        uint256 alcoholContent,
        uint256 bottlingDate,
        string memory vinificationProcess,
        uint256 totalBottles,
        bool organicCertified
    ) external onlyRole(PRODUCER_ROLE) {
        require(winePassports[productId].harvestYear == 0, "Product ID already exists");
        
        WineDetails storage newWine = winePassports[productId];
        newWine.wineName = wineName;
        newWine.producer = producer;
        newWine.harvestYear = harvestYear;
        newWine.grapeVariety = grapeVariety;
        newWine.region = region;
        newWine.alcoholContent = alcoholContent;
        newWine.bottlingDate = bottlingDate;
        newWine.vinificationProcess = vinificationProcess;
        newWine.totalBottles = totalBottles;
        newWine.organicCertified = organicCertified;
        newWine.qualityCheckCount = 0;

        registeredProductIds.push(productId);
        
        emit WinePassportCreated(productId, wineName, producer);
    }

    function addQualityCheck(
        uint256 productId,
        string memory inspector,
        uint256 score,
        string memory notes
    ) external onlyRole(INSPECTOR_ROLE) {
        require(winePassports[productId].harvestYear != 0, "Product does not exist");
        require(score <= 100, "Score must be between 0 and 100");

        WineDetails storage wine = winePassports[productId];
        uint256 checkId = wine.qualityCheckCount;
        
        QualityCheck storage newCheck = wine.qualityChecks[checkId];
        newCheck.date = block.timestamp;
        newCheck.inspector = inspector;
        newCheck.score = score;
        newCheck.notes = notes;
        
        wine.qualityCheckCount++;
        
        emit QualityCheckAdded(productId, block.timestamp, score);
    }

    function getWineBasicDetails(uint256 productId) external view returns (
        string memory wineName,
        string memory producer,
        uint256 harvestYear,
        string memory grapeVariety,
        string memory region,
        uint256 alcoholContent,
        bool organicCertified
    ) {
        require(winePassports[productId].harvestYear != 0, "Product does not exist");
        WineDetails storage wine = winePassports[productId];
        
        return (
            wine.wineName,
            wine.producer,
            wine.harvestYear,
            wine.grapeVariety,
            wine.region,
            wine.alcoholContent,
            wine.organicCertified
        );
    }

    function getWineProductionDetails(uint256 productId) external view returns (
        uint256 bottlingDate,
        string memory vinificationProcess,
        uint256 totalBottles,
        uint256 qualityCheckCount
    ) {
        require(winePassports[productId].harvestYear != 0, "Product does not exist");
        WineDetails storage wine = winePassports[productId];
        
        return (
            wine.bottlingDate,
            wine.vinificationProcess,
            wine.totalBottles,
            wine.qualityCheckCount
        );
    }

    function getQualityCheck(uint256 productId, uint256 checkId) external view returns (
        uint256 date,
        string memory inspector,
        uint256 score,
        string memory notes
    ) {
        require(winePassports[productId].harvestYear != 0, "Product does not exist");
        require(checkId < winePassports[productId].qualityCheckCount, "Quality check does not exist");
        
        QualityCheck storage check = winePassports[productId].qualityChecks[checkId];
        return (
            check.date,
            check.inspector,
            check.score,
            check.notes
        );
    }

    function getAllProductIds() external view returns (uint256[] memory) {
        return registeredProductIds;
    }

    function addProducer(address producer) external onlyOwner {
        grantRole(PRODUCER_ROLE, producer);
    }

    function removeProducer(address producer) external onlyOwner {
        revokeRole(PRODUCER_ROLE, producer);
    }

    function addInspector(address inspector) external onlyOwner {
        grantRole(INSPECTOR_ROLE, inspector);
    }

    function removeInspector(address inspector) external onlyOwner {
        revokeRole(INSPECTOR_ROLE, inspector);
    }
}