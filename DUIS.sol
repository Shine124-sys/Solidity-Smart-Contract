// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DUIS {

    struct Device {
        string uniqueIdentifier; // IMEI or Serial Number
        address currentOwner;     // Current owner address
        bool isStolen;            // Flag if the device is stolen or lost
    }

    mapping(string => Device) public devices;  // Mapping to store device details using IMEI/Serial Number as the key

    event DeviceRegistered(string uniqueIdentifier, address owner);
    event OwnershipTransferred(string uniqueIdentifier, address newOwner);
    event DeviceFlaggedAsStolen(string uniqueIdentifier);

    modifier onlyOwner(string memory _uniqueIdentifier) {
        require(devices[_uniqueIdentifier].currentOwner == msg.sender, "You are not the owner of this device");
        _;
    }

    // Register a new device on the blockchain
    function registerDevice(string memory _uniqueIdentifier) public {
        require(devices[_uniqueIdentifier].currentOwner == address(0), "Device already registered");

        devices[_uniqueIdentifier] = Device({
            uniqueIdentifier: _uniqueIdentifier,
            currentOwner: msg.sender,
            isStolen: false
        });

        emit DeviceRegistered(_uniqueIdentifier, msg.sender);
    }

    // Transfer ownership of the device
    function transferOwnership(string memory _uniqueIdentifier, address newOwner) public onlyOwner(_uniqueIdentifier) {
        require(newOwner != address(0), "Invalid new owner address");

        devices[_uniqueIdentifier].currentOwner = newOwner;

        emit OwnershipTransferred(_uniqueIdentifier, newOwner);
    }

    // Flag the device as stolen
    function flagAsStolen(string memory _uniqueIdentifier) public onlyOwner(_uniqueIdentifier) {
        devices[_uniqueIdentifier].isStolen = true;

        emit DeviceFlaggedAsStolen(_uniqueIdentifier);
    }

    // Verify if a device is stolen or not
    function isDeviceStolen(string memory _uniqueIdentifier) public view returns (bool) {
        return devices[_uniqueIdentifier].isStolen;
    }

    // Get the current owner of a device
    function getOwner(string memory _uniqueIdentifier) public view returns (address) {
        return devices[_uniqueIdentifier].currentOwner;
    }
}
