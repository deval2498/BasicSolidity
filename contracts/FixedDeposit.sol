// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract FixedDeposit {
    uint256 public interest; 
    mapping(address => uint256) public balance;
    mapping(address => uint256) public timefor;
    uint256 public deadline;
    constructor() payable {
        balance[address(this)] = 10000000 ;
    }
    function interestPaid() public payable {
        interest = timefor[msg.sender];
        balance[msg.sender] = balance[msg.sender] + interest;
    }


    function deposit(uint256 _amount, uint256 _TimePeriod) public payable {
        require(balance[msg.sender] == 0, 'You have already made a deposit!');
        balance[msg.sender] = _amount;
        timefor[msg.sender] = _TimePeriod;
        balance[address(this)] += _amount;
        deadline = block.timestamp + timefor[msg.sender];

    }

    function withdraw(address payable _addr) public payable {
        require(block.timestamp >= deadline, 'Time limit not reached!');
        require(msg.sender == _addr, 'You are not the owner!');
        interestPaid();
        balance[address(this)] -= balance[msg.sender];
    }

    function balanceOf(address _addr) public view returns(uint256) {
        return balance[_addr];
    }
}