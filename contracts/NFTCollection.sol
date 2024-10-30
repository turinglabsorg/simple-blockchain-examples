// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTCollection is ERC721, Ownable {
    using Strings for uint256;

    uint256 public constant MINT_PRICE = 0.05 ether;
    uint256 public constant MAX_SUPPLY = 1000;
    
    uint256 private _currentTokenId = 0;
    string private _baseTokenURI;

    constructor(string memory baseURI) ERC721("MyNFTCollection", "MNFT") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    function mint() public payable {
        require(msg.value >= MINT_PRICE, "Insufficient payment");
        require(_currentTokenId < MAX_SUPPLY, "Max supply reached");

        _currentTokenId++;
        _safeMint(msg.sender, _currentTokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return string(abi.encodePacked(_baseTokenURI, tokenId.toString(), ".json"));
    }
} 