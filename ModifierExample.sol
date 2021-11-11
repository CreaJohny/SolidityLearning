//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract Owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "Du bist nicht berechtigt");
        _;
    }
}

contract InheritanceModifierExample is Owned {
    mapping(address => uint) public tokenBalance;
    
    uint tokenPrice = 1 ether;
    
    constructor()public {
        tokenBalance[owner]= 100;
    }
    
    
     function getOwner() public view returns(address) {
        return owner;
    }
    
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner]* tokenPrice) / msg.value > 0, "nicht genug guthaben");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
    
    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >=  _amount,"Nicht genug Guthaben");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
    
    
}