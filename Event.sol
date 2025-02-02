

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EveentContract{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }

    mapping(uint => Event) public events;  //details of the events 
    mapping(address =>mapping(uint=>uint)) public tickets;
    uint public nextId;

    function createEvent(string calldata _name , uint _date , uint _price , uint _ticketCount) public{
        require(block.timestamp < _date ,"You can not create an event for past date");
        require(_ticketCount > 0 ,"Ticket Price Must Greater Then 0");
        events[nextId] = Event(msg.sender , _name , _date , _price , _ticketCount , _ticketCount);
        nextId++;
    }

    function BuyTicket ( uint id , uint quantity) public payable  {
        require(events[id].date != 0 ,"Event Doest Not exits");
        require(events[id].date > block.timestamp , "Event has ended ");
        Event storage _event  = events[id];
        require(msg.value==(_event.price*quantity),"Ethere is not enough");
        require(_event.ticketRemain>=quantity,"Not enough tickets");
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;
    }
     function transferTicket(uint id,uint quantity,address to) external{
        require(events[id].date!=0,"Event does not exist");
        require(events[id].date>block.timestamp,"Event has already occured");
        require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
 }


}