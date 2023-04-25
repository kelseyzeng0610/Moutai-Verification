// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// import "hardhat/console.sol";

contract Transactions {
    uint256 propertyCount;

    event Transfer(address from, address receiver, uint amount, uint propertyID, uint256 timestamp);

    struct TransferStruct {
        address sender;
        address receiver;
        uint amount;
        uint propertyID;
        uint256 timestamp;
    }

    struct Property {
        uint256 propId;
        uint256 value;
        address currOwner;
    }

    enum Status {NotExist, Approved}
    enum Role {Admin, User}

    TransferStruct[] transactions;
    Property[] properties;
    mapping (address => Role) public userRoles;

    constructor() {
        address creatorAdmin = msg.sender;
        userRoles[creatorAdmin] = Role.Admin;
        properties.push(Property(0, 0, 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4));
    }

    // Modifier to ensure only the verified admin access a function
    modifier verifiedAdmin() {
        require(
            userRoles[msg.sender] == Role.Admin
        );
        _;
    }

    function findIndex(uint target) public view returns (uint index) {
        uint length = properties.length;

        for (uint i = length - 1; i >= 0; i--) {
            if (properties[i].propId == target) {
                return i;
            }
            if (i == 0) {
            break;
            }
        }
        return 0;
    }

    function addToBlockchain(address payable receiver, uint amount, uint propertyID) public {
        propertyCount += 1;
        transactions.push(TransferStruct(msg.sender, receiver, amount, propertyID, block.timestamp));
        uint index = findIndex(propertyID);
        require (index != 0, "Property does not exist");
        properties[index].currOwner = receiver;
        emit Transfer(msg.sender, receiver, amount, propertyID, block.timestamp);
    }

    function getPropertyDetails(uint256 _id) public view returns (Property memory) {
        uint index = findIndex(_id);
        require (index != 0, "Property does not exist");
        return properties[index];
    }

    function createProperty  (
        uint256 _propId,
        uint256 _value,
        address _owner
    ) external verifiedAdmin returns (bool)
     {
        uint index = findIndex(_propId);
        require (index == 0, "Property already exists");
        properties.push(Property(_propId, _value, _owner));
        return true;
    }

    function getAllProperties () public view returns (Property[] memory) {
        return properties;
    }

    function getAllTransactions() public view returns (TransferStruct[] memory) {
        return transactions;
    }

    function getPropertyCount() public view returns (uint256) {
        return propertyCount;
    }
}
