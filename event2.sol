// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract EventTicket{
    uint  noOfTickets;
    uint  ticketPrice;
    uint  totalAmount;
    uint  startAt;
    uint  endAt;
    uint  timeRange;
    string  message =  "Buy your First Event Ticket";

    constructor(uint _ticketPrice){
        ticketPrice = _ticketPrice;
        startAt = block.timestamp;
        endAt = block.timestamp + 7 days;
        timeRange = (endAt - startAt) /60/60/24;

    }

    function buyTickets(uint _value) public returns(uint ticketId){
        noOfTickets++;
        totalAmount += _value;
        ticketId = noOfTickets;
    }

    function getTotalAmount() public view returns(uint){
        return totalAmount;
    }

}