//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
  using PriceConverter for uint256;
    
    uint256 public constant MINIMUMUSD = 5e18;

    address[] public funders;

    mapping (address => uint256) public fundersAndAmounts;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }
    
    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUMUSD, "Not enough eth");
        funders.push(msg.sender);
        fundersAndAmounts[msg.sender] = fundersAndAmounts[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            fundersAndAmounts[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Transfer Failed");
    }

    modifier onlyOwner {
        if (msg.sender == i_owner) {
            revert NotOwner();
        }
        _;
    }
}
