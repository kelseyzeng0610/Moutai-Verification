// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// import "hardhat/console.sol";

contract Transactions {
    uint256 transactionCount;

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

    TransferStruct[] transactions;
    Property[] properties;

        // constructor() {
        //     address creatorAdmin = msg.sender;
        //     userRoles[creatorAdmin] = Role.Admin;
        // }

    function addToBlockchain(address payable receiver, uint amount, uint propertyID) public {
        transactionCount += 1;
        transactions.push(TransferStruct(msg.sender, receiver, amount, propertyID, block.timestamp));
        properties[propertyID] = Property(propertyID, amount, receiver);
        emit Transfer(msg.sender, receiver, amount, propertyID, block.timestamp);
    }

    // function getProperty(uint256 _id) public view returns (Property memory) {
    //     return properties[_id];
    // }

    // function createProperty  (
    //     uint256 _propId,
    //     uint256 _value,
    //     address _owner
    // ) external verifiedAdmin returns (bool)
    //  {
    //     require(properties[_propId].status != Status.Approved, "Property already exists");
    //     properties[_propId] = Property(_propId, Status.Approved, _value, _owner);
    //     return true;
    // }

    function getAllProperties () public view returns (Property[] memory) {
        return properties;
    }

    function getAllTransactions() public view returns (TransferStruct[] memory) {
        return transactions;
    }

    function getTransactionCount() public view returns (uint256) {
        return transactionCount;
    }
}
