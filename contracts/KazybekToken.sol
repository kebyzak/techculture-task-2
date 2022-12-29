// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract KazybekToken {
    uint256 public total = 1000000e18;

    address public minter;

    string myName = "KazybekToken";
    string mySymbol = "KAZ";
    uint myDecimal = 18;

    mapping(address => bool) private blacklisted;
    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint256)) public allow;

    function blacklist(address account) external returns (bool) {
        require(!blacklisted[account], "blacklisted");
        blacklisted[account] = true;
        return true;
    }

    constructor() {
        minter = msg.sender;
    }

    function name() public view returns (string memory) {
        return myName;
    }

    function symbol() public view returns (string memory) {
        return mySymbol;
    }

    function decimals() public view returns (uint) {
        return myDecimal;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter, "owner can mint");
        balance[receiver] += amount;
    }

    function totalSupply() public view returns (uint256) {
        return total;
    }

    function balanceOf(address account) external view returns (uint) {
        return balance[account];
    }

    function transfer(address recipient, uint amount) external returns (bool) {
        require(!blacklisted[msg.sender],"u are blacklisted");
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender,address recipient,uint amount) external returns (bool) {
        require(!blacklisted[msg.sender], "u are blacklisted");
        allow[sender][recipient] -= amount;
        balance[sender] -= amount;
        balance[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allow[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner,address spender) public view returns (uint256) {
        return allow[owner][spender];
    }

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approve(address indexed owner, address indexed spender, uint amount);
}
