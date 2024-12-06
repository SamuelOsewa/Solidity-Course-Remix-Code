// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SimpleStorage {
    //This contract is a contract that helps us store our favorite number and other people's
    //favorite number

    uint256 internal myfavouriteNumber = 5;

    // uint256[] listOfFavoriteNumbers;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person public him = Person({ favoriteNumber: 5, name: "Him"});

    Person[] public favoritePeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favNumber) virtual  public {
        myfavouriteNumber = _favNumber;
    }

    function retrieve() public view returns (uint256) {
        return myfavouriteNumber;
        //return 7; This is an example of what a pure function would do because
        //it doesn't affect state and favouriteNumber is a state variable.
    }

    function join(string memory _name, uint256 _favoriteNumber) public {
        favoritePeople.push(Person({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
      




}