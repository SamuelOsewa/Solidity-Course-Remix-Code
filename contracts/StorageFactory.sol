// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage public simpleStorage;

    SimpleStorage[] public listOfSimpleStorage;

    function createSimpleStorageContract() public {   
        listOfSimpleStorage.push(simpleStorage = new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        SimpleStorage newSimpleStorage = listOfSimpleStorage[_simpleStorageIndex];
        newSimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage newSimpleStorage = listOfSimpleStorage[_simpleStorageIndex];
        return newSimpleStorage.retrieve();
    }

}