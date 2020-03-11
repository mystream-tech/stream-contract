pragma solidity ^0.5.0;

import "./IOracle.sol";
import "./SafeMath.sol";
import "./OracleRole.sol";

contract Oracle is IOracle, OracleRole{
    using SafeMath for uint256;
	
    uint256 private _price;
    uint256 private _lastTime;
    uint256 private _interval;
    uint256 private _future;
    bool _limitedDone;
    constructor () public {
        _price = 0;
        _lastTime = block.timestamp;
        _interval = 10;
        _future = 10;
        _limitedDone = false;
    }
   
    function getPrice() public view returns (uint256) {
        return _price;
    }
    
    function getInterval() public view returns (uint256) {
        return _interval;
    }
    
    function getFuture() public view returns (uint256) {
        return _future;
    }

    function getLimiteddone() public view returns (bool)
    {
        return _limitedDone;
    }
    
    function getLastTime() public view returns (uint256) {
        return _lastTime;
    }
    
    function setFuture(uint256 future) public onlyOracle returns (uint256) {
        _future = future;
        return _future;
    }
    
    function setInterval(uint256 interval) public onlyOracle returns (uint256) {
        _interval = interval;
        return _interval;
    }

    function setLastTime(uint256 lastTime) public onlyOracle returns (uint256) {
        _lastTime = lastTime;
        return _lastTime;
    }

    function _setPrice(uint256 price) internal onlyOracle returns (uint256) {
        _price = price;
        return _price;
    }

    function _setLimitedDone(bool limitedDone) internal onlyOracle returns (bool)
    {
        _limitedDone = limitedDone;
        return _limitedDone;
    }
    
}
