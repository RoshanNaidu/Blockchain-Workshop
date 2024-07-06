// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Sender {
    bool private locked = false;

    constructor() payable {}

    function balance() public view returns(uint256) {
        return address(this).balance;
    }

    function sendWithTransfer(address payable _addr) public {
        _addr.transfer(0.001 ether);
    }

    function sendWithSend(address payable _addr) public returns(bool){
        bool sent = _addr.send(0.001 ether);
        return sent;
    }
    function sendWithCall(address payable _addr) public returns(bool){
        require(!locked,"Re-entrancy detected");
        locked=true;
        (bool sent,)=_addr.call{value: 0.001 ether}("");
        locked=false;
        return sent;
    }
}
contract Receiver{
    address public VC;

    function setVC(address _contr) public{
        VC= _contr;
    }

    function attack() internal {
        (bool success,) = VC.call{value: 0.001 ether}(abi.encodeWithSignature("sendWithCall(address)",address(this)));
        require(success,"Transfer failed.");
    }
    function balance()public view returns(uint256){
        return address(this).balance;
    }
    receive() external payable {

        attack();
     }
}