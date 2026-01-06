// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter{

    function getPrice() internal view returns(uint) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        (,int256 price,,, )= priceFeed.latestRoundData();
        return uint(price*1e10);
    }

    function getConversionRate(uint ethAmount) internal view returns(uint){
        uint ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;

    }

    function getVersion() internal view returns(uint){
        return AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22).version();
    }
    function getNew() view returns(uint){
        return "testing2";
        
    }

}