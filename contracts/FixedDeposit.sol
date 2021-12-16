// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;
import './ERC20.sol';

contract FixedDeposit {
    uint256 public ethBal;
    mapping(address => uint256) public balance;
    event Received(address _from, uint256 _amount);
    event Transferred(address _to, uint256 _amount);
    uint256 TimePeriod;
    uint256 deadline;

    constructor() {
        TimePeriod = 3 seconds;
    }


    fallback() external payable {
        ethBal += msg.value;
        emit Received(msg.sender,msg.value);
    }

    receive() external payable {
        ethBal += msg.value;
        emit Received(msg.sender , msg.value);
    }

    function deposit(uint256 _amount,ERC20 _token) public {
        require(balance[msg.sender] == 0, 'You have already made a deposit!');
        require(_token.balanceOf(msg.sender) >= _amount, 'you dont have enough balance!');
        _token.approve(address(this), _amount);
        _token.transferFrom(msg.sender,address(this),_amount);
        deadline = block.timestamp + TimePeriod;
        emit Transferred(address(this),_amount);
    }

    function withdraw(ERC20 _token,address payable _to) public {
        require(block.timestamp >= deadline, 'Still time left!');
        require(msg.sender == _to, 'You are not the owner!');
        uint256 tokenBalance = _token.balanceOf(address(this));
        _token.transfer(_to ,tokenBalance);
        _to.transfer(1 ether);
        emit Transferred(_to,balance[_to]);
    }
}
    