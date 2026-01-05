//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint;
    uint public minUsd = 5e18;

    address[] public funders;
    mapping(address=> uint) public addressToAmountFunded;

    function fund() public payable  {
        

        require(msg.value.getConversionRate() > minUsd, "you dont have enough Eth to send");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender]+msg.value;
        

    }

    
}