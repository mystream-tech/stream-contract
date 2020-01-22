pragma solidity ^0.5.0;

import "./EIP20Interface.sol";
import "./WrappedEtherInterface.sol";
import "./IOracle.sol";
import "./SafeMath.sol";
import "./ConfigInterface.sol";

contract MortgageBill {
    using SafeMath for uint;
    uint constant expScale = 10**18;
    address creator;
    address payable owner;
    uint256 etherNumber; 
    uint256 orderID;
    uint256 tokenNumber;
    bool alive;
    WrappedEtherInterface weth;
    ConfigInterface config;
    EIP20Interface borrowedToken;
    uint timelock;
    uint8 status; 
    
    event Log(uint x, string m);
    event Log(int x, string m);

    modifier futureTimelock(uint _time) {
        
        require(_time < now, "timelock time must be in the future");
        _;
    }

    constructor (address payable _owner, address tokenAddress, address wethAddress,
     address _config, uint256 _etherNumber, uint256 _orderID, uint256 _tokenNumber) public {
        creator = msg.sender;
        owner = _owner;
        etherNumber = _etherNumber; 
        orderID = _orderID;
        tokenNumber = _tokenNumber;
        borrowedToken = EIP20Interface(tokenAddress);
        config = ConfigInterface(_config);
        weth = WrappedEtherInterface(wethAddress);
        alive = true;
        timelock = now + config.getConfigValue("minimum_mortgage_time");
        status = 0;
    }

 
    function fund() payable external {
        require(creator == msg.sender);
        weth.deposit.value(msg.value)();       
    }



    function back() payable external  futureTimelock(timelock) {
        require(creator == msg.sender);

        /* ---------- return ether to user ---------*/
        uint wethBalance = weth.balanceOf(address(this));
        weth.withdraw(wethBalance);
        owner.transfer(address(this).balance);
        alive = false;
    }

    function add(address _owner) payable external futureTimelock(timelock) {
        require(creator == msg.sender && msg.value > 0 && owner == _owner);
        etherNumber = etherNumber.add(msg.value);
        weth.deposit.value(msg.value)();
    }
    
    function liquid(address payable to, uint256 ethVal) payable external futureTimelock(timelock) {
        require(creator == msg.sender);

        /* ---------- return ether to user ---------*/
        uint wethBalance = weth.balanceOf(address(this));
        require(wethBalance >= ethVal);
        weth.withdraw(wethBalance);
        to.transfer(ethVal);
        owner.transfer(wethBalance.sub(ethVal));
        alive = false;
    }
    /* @dev it is necessary to accept eth to unwrap weth */
    function () external payable {}


    function isAlive() view external returns(bool _alive) {
        return alive;
    }
    
    function isNormal() view external returns(bool _alive) {
        return status == 0;
    }
    
    function isUnsafe() view external returns(bool _alive) {
        return status == 1;
    }
    
    function intoUnsafe() external {
        require(creator == msg.sender);
        require(status == 0);
        status = 1;
    }
    
    function intoback() external {
        require(creator == msg.sender);
        require(status == 0);
        status = 3;
    }

    function isLiquided() view external returns(bool _alive) {
        return status == 2;
    }
    
    function intoLiquided() external {
        require(creator == msg.sender);
        require(status == 1);
        status = 2;
    }
    
    function getMortgageBill() view external returns(address payable _owner, address _creator, address tokenAddress, address wethAddress,
     address _config, uint256 _etherNumber, uint256 _orderID, uint256 _tokenNumber,bool _alive) {
        return (owner,creator,address(borrowedToken),address(weth),address(config),etherNumber,orderID,tokenNumber,alive);
    }

    function getTokenNumber() view external returns(uint256 _tokenNumber) {
        return tokenNumber;
    }

    function getEtherNumber() view external returns(uint256 _etherNumber) {
        return etherNumber;
    }

    function getTimeLock() view external returns(uint256 _timelock) {
        return timelock;
    }
    
}
