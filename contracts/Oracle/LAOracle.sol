pragma solidity ^0.5.0;

import "./Oracle.sol";
import "./SafeMath.sol";
import "./OracleRole.sol";

contract LAOracle is Oracle {

    event SetPrice(address indexed fromAddress, uint256 value);

    function setPrice(uint256 price) public onlyOracle returns (uint256) {
        require(price>0, "price <=0");
        require(
            block.timestamp >= getLastTime() + getInterval(),
            "TIME_LOCK_INCOMPLETE"
        );
        _setPrice(price);
        setLastTime(block.timestamp);
        emit SetPrice(msg.sender, price);
        return price;
    }
    
    function getInfo() public view returns (uint256,uint256, uint256, uint256) {
        return (getPrice(), getInterval(), getFuture(), getLastTime());
    }
}