// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;
import './ERC20.sol';

contract FixedDeposit {
    mapping(address => uint256) public balance;
    event Received(address _from, uint256 _amount);
    event Transferred(address _to, uint256 _amount);


    receive() external payable {
        balance[address(this)] += msg.value;
        emit Received(msg.sender,msg.value);
    }

    function deposit(uint256 _amount) public {
        require(balance[msg.sender] == 0, 'You have already made a deposit!');
        balance[msg.sender] += _amount;
    }

    function withdraw(ERC20 token,address _to) public {
        token.transfer(_to ,balance[_to]);
        emit Transferred(_to,balance[_to]);
    }
}
    