# Ethereum Vault System

A Solidity smart contract that implements a secure vault system for depositing and withdrawing ETH using inheritance, libraries, and events.

## Features

- **Safe Math Operations**: Uses SafeMath library to prevent overflow/underflow attacks
- **Inheritance Structure**: VaultBase (foundation) + VaultManager (functionality)
- **Event Logging**: Permanent blockchain records of all deposits and withdrawals
- **Secure Validations**: Prevents 0 ETH deposits/withdrawals and over-withdrawing
- **ETH Handling**: Full payable functionality for receiving and sending Ethereum

## Contract Architecture

### SafeMath Library
```solidity
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256);
    function sub(uint256 a, uint256 b) internal pure returns (uint256);
}
```
- Prevents arithmetic overflow and underflow vulnerabilities
- Essential for secure financial smart contracts

### VaultBase (Parent Contract)
- **Storage**: `mapping(address => uint256) public balances` - tracks user balances
- **Events**: `Deposit` and `Withdrawal` event definitions
- **Functions**: 
  - `getBalance(address _user)` - check individual user balance
  - `getTotalBalance()` - check total ETH held by contract

### VaultManager (Child Contract)
- **Inherits**: All VaultBase functionality using `is VaultBase`
- **Library Usage**: `using SafeMath for uint256`
- **Core Functions**:
  - `deposit()` - accept ETH deposits with validation
  - `withdraw(uint256 _amount)` - process ETH withdrawals with security checks

## Function Details

### `deposit()` - payable function
```solidity
function deposit() public payable
```
- **Validation**: Requires `msg.value > 0`
- **Updates**: User balance using SafeMath addition
- **Events**: Emits `Deposit(user, amount, timestamp)`

### `withdraw(uint256 _amount)` - withdrawal function
```solidity
function withdraw(uint256 _amount) public
```
- **Validation**: Requires `_amount > 0` and sufficient balance
- **Updates**: User balance using SafeMath subtraction  
- **Transfer**: Sends ETH to user via `payable(msg.sender).transfer(_amount)`
- **Events**: Emits `Withdrawal(user, amount, timestamp)`

## Assignment Requirements Met

✅ **Use a Library for math** - SafeMath library for secure arithmetic  
✅ **Emit Events** - Deposit and Withdrawal events logged  
✅ **Use require()** - Multiple validations prevent invalid operations  
✅ **Prevent over-withdrawing** - Balance checks before withdrawal  
✅ **Prevent 0 ETH deposits** - Input validation on deposits  
✅ **Implement Inheritance** - VaultBase (base) + VaultManager (derived)  

## Usage Examples

### Deploy Contract
Deploy `VaultManager` (which automatically inherits `VaultBase` functionality)

### Deposit ETH
```solidity
// User sends 1 ETH with function call
contract.deposit{value: 1 ether}();
```

### Check Balance
```solidity
// Check Alice's balance
uint256 balance = contract.getBalance(0x123...);
```

### Withdraw ETH  
```solidity
// Withdraw 0.5 ETH
contract.withdraw(500000000000000000); // 0.5 ETH in Wei
```

### View Events
```solidity
// Events are automatically logged on blockchain
// External apps can listen for Deposit/Withdrawal events
```

## Security Features

1. **Overflow Protection**: SafeMath prevents arithmetic vulnerabilities
2. **Balance Validation**: Users cannot withdraw more than they deposited
3. **Zero Amount Protection**: Prevents gas-wasting zero-value transactions
4. **Event Logging**: Creates permanent audit trail of all transactions

## Testing

Successfully tested in Remix IDE with:
- ✅ Multiple deposits and withdrawals
- ✅ Error cases (0 deposits, over-withdrawing)
- ✅ Balance tracking accuracy
- ✅ Event emission verification

## Technical Notes

- **Solidity Version**: ^0.8.0
- **Units**: All amounts in Wei (1 ETH = 10^18 Wei)
- **Gas Optimization**: Uses appropriate function visibility and validation order
- **Inheritance**: Demonstrates proper contract inheritance patterns
- **Library Integration**: Shows best practices for library usage

## Development

This smart contract was developed as part of a blockchain development course, demonstrating:
- Smart contract inheritance patterns
- Library integration for security
- Event-driven architecture
- ETH handling and validation
- Professional Solidity development practices