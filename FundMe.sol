//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint;
    uint public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address=> uint) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable  {
    
        require(msg.value.getConversionRate() > MINIMUM_USD, "you dont have enough Eth to send");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender]+msg.value;
    }

    function withdraw() public onlyOwner{
        for(uint funderIndex = 0; funderIndex<funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders = new address[](0);
        //transfer
        payable(msg.sender).transfer(address(this).balance);
        //send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess,"Send failed"); 
        //call
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value:address(this).balance}("");
    }

    modifier onlyOwner(){
        //require(i_owner == msg.sender,"sender is not the owner!");
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    
}