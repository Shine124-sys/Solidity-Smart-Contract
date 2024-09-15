// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {

    struct Land {
        uint256 landId;            // Unique ID for the land parcel
        string landDetails;        // Description of the land (location, size, etc.)
        address currentOwner;      // Current owner address
        string documentHash;       // Hash of the land deed document
    }

    mapping(uint256 => Land) public lands;  // Mapping to store land records using landId as the key

    event LandRegistered(uint256 landId, address owner);
    event OwnershipTransferred(uint256 landId, address newOwner);
    event DocumentHashUpdated(uint256 landId, string newDocumentHash);

    modifier onlyOwner(uint256 _landId) {
        require(lands[_landId].currentOwner == msg.sender, "You are not the owner of this land");
        _;
    }

    // Register new land on the blockchain
    function registerLand(uint256 _landId, string memory _landDetails, string memory _documentHash) public {
        require(lands[_landId].currentOwner == address(0), "Land already registered");

        lands[_landId] = Land({
            landId: _landId,
            landDetails: _landDetails,
            currentOwner: msg.sender,
            documentHash: _documentHash
        });

        emit LandRegistered(_landId, msg.sender);
    }

    // Transfer ownership of the land
    function transferOwnership(uint256 _landId, address newOwner) public onlyOwner(_landId) {
        require(newOwner != address(0), "Invalid new owner address");

        lands[_landId].currentOwner = newOwner;

        emit OwnershipTransferred(_landId, newOwner);
    }

    // Update the document hash for a land record
    function updateDocumentHash(uint256 _landId, string memory _newDocumentHash) public onlyOwner(_landId) {
        lands[_landId].documentHash = _newDocumentHash;

        emit DocumentHashUpdated(_landId, _newDocumentHash);
    }

    // Get the current owner of a land parcel
    function getOwner(uint256 _landId) public view returns (address) {
        return lands[_landId].currentOwner;
    }

    // Get land details
    function getLandDetails(uint256 _landId) public view returns (string memory, string memory, address) {
        Land memory land = lands[_landId];
        return (land.landDetails, land.documentHash, land.currentOwner);
    }
}
