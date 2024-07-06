// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Math {
    uint private id;

    function sum(uint a , uint b) public pure returns(uint){
        return a+b;
    }

    function pow(uint a , uint b) public pure returns(uint){
        return a**b;
    }
}

contract Inheritance is Math {
    string public name;

    constructor(){
        name = "Roshan The Superior";
    }

    function ssum()public pure returns(uint){
        return sum(12,8);
    }
}