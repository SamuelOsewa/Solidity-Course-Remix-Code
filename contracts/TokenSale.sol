// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract UnpaidCoinSale {

    //IN UC
    uint256 public totalSupply = 250000e18;
    uint256 internal ethAmount;
    uint256 internal totalRaised;

    address[] public buyers;
    mapping (address => uint256) public buyersToUCAmount;

    //Users have to send money to the contract
    function fund() public payable {
        require(msg.value > 0, "Not enough Eth Sent");
        buyers.push(msg.sender);
        ethAmount = msg.value;
        buyersToUCAmount[msg.sender] = conversionRate(ethAmount);
        totalRaised += ethAmount;
        tokenDisbursal();
    }

    // 240000 100,000,000,000,000
    // 249900 1,000,000,000,000,000,000
    // 100 1,000,000,000,000,000,000
    // 249,898 1,000,000,000,000,000,000

    //The contract has to keep track of all the money and users sent to the contract

    //Users have to get a certain amount of token for the money spent
    function tokenDisbursal() internal {
        require(totalSupply >= conversionRate(ethAmount), "Token Exhausted");
         totalSupply = totalSupply - conversionRate(ethAmount);
    }

    function conversionRate(uint256 amountInEth) internal pure returns(uint256) {
        //Conversion Rate 1eth - 100UC
        //100 * 10000000000000000
        uint256 amountFunded = amountInEth; 
        uint256 amountInUc = (amountFunded * 100e18) / 1e18;
        return amountInUc;
    }

    receive() external payable {
        fund();
     }

    fallback() external payable {
        fund();
     }

}