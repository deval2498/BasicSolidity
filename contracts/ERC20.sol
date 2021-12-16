//SPDX-License-Identifier: Unlicense
pragma solidity^0.8.4;
contract ERC20 {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public setSupply;

    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Transfer(address indexed _from,
    address indexed _to,
    uint256 _amount
    );

    
    constructor () {
        name = 'GOLD TEST TOKEN';
        symbol = 'GTT';
        decimals = 18; 
        setSupply = 1 * 10 ** decimals;
        balance[msg.sender] = setSupply;

    }

    function totalSupply() public view returns(uint256) {
        return setSupply;
    }

    function balanceOf(address _account) public view returns(uint256) {
        return balance[_account];
    }

    function transfer(address _to, uint256 _amount) public returns (bool success) {
        require(balance[msg.sender] >= _amount, "Not enough Tokens!");
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;


    }

    function symbolIs() public view returns(string memory) {
        return symbol;
    }

    event Approve(address indexed _owner, address indexed _spender, uint256 _value);

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balance[_from]);
        require(allowance[_from][msg.sender] >= _value);
        balance[_from] -= _value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

}
