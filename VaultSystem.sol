// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction underflow");
        return a - b;
    }
}

contract VaultBase {
    mapping(address => uint256) public balances;
    
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);
    
    function getBalance(address _user) public view returns (uint256) {
        return balances[_user];
    }
    
    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract VaultManager is VaultBase {
    using SafeMath for uint256;
    
    function deposit() public payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        
        uint256 currentBalance = balances[msg.sender];
        uint256 newBalance = currentBalance.add(msg.value);
        
        balances[msg.sender] = newBalance;
        
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    
    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Cannot withdraw 0 ETH");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        uint256 currentBalance = balances[msg.sender];
        uint256 newBalance = currentBalance.sub(_amount);
        balances[msg.sender] = newBalance;
        
        payable(msg.sender).transfer(_amount);
        
        emit Withdrawal(msg.sender, _amount, block.timestamp);
    }
}