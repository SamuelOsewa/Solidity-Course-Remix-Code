// SPDX-License-Identifier: MIT


pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
        function getPrice() internal  view returns (uint256) {
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      (,int256 answer,,,) = priceFeed.latestRoundData();
      return uint256(answer * 1e10);
      //3587590000000000000000
      //5,000,000,000,000,000,000
    }

    function getConversionRate(uint256 ethAmount) internal  view  returns(uint256) {
        uint256 ethPriceInUsd = getPrice();
        //uint256 ethAmountToWei = ethAmount * 1e18;
        uint256 ethAmountInUsd = (ethAmount * ethPriceInUsd) / 1e18;
        return ethAmountInUsd;
    }


    function getVersion() internal  view  returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
