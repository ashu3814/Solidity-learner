
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Lottry{
    address manage;
    address payable[] players;
    address payable  winner;

    constructor(){
        manage = msg.sender;
    }

    function addParticipent() public  payable {
        require(msg.value == 1, "Required 1 Eather for every Particeent..........");
        players.push(payable (msg.sender));
    }
    function getBalance() public view  returns(uint)  {
        require(msg.sender == manage," You are not a manager");
        return address(this).balance;
    }

    function random() internal view returns(uint){
      return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,players.length)));
  }


    function pickWinner() public {
        require(msg.sender == manage, "You are not a mangeer");
        require(players.length >=3,"Min  3 players are Require");
        uint r = random();
        uint index = r%players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players= new address payable[](0);

    }
}