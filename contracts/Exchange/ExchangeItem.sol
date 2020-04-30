pragma solidity ^0.5.0;
import "./SafeMath.sol";

contract ExchangeItem {
    using SafeMath for uint256;
    address private tokenA;
    address private tokenAOracle;
    address private tokenB;
    address private tokenBOracle;
    bool private enable;
    address private creator;
    uint256 private totalTokenA;
    uint256 private totalTokenB;

    constructor (address _tokenA, address _tokenAOracle, address _tokenB,
     address _tokenBOracle, bool _enable) public {
        creator = msg.sender;
        require(_tokenA != address(0x0),"require _tokenA != address(0x0)");
        require(_tokenAOracle != address(0x0),"require _tokenAOracle != address(0x0)");
        require(_tokenB != address(0x0),"require _tokenB != address(0x0)");
        require(_tokenBOracle != address(0x0),"require _tokenBOracle != address(0x0)");
        tokenA = _tokenA;
        tokenAOracle = _tokenAOracle;
        tokenB = _tokenB; 
        tokenBOracle = _tokenBOracle;
        enable = _enable;
    }

    function update(address _tokenA, address _tokenAOracle, address _tokenB, address _tokenBOracle, bool _enable) public {
        require(creator == msg.sender);
        require(tokenA != address(0x0),"require tokenA != address(0x0)");
        require(tokenAOracle != address(0x0),"require tokenAOracle != address(0x0)");
        require(tokenB != address(0x0),"require tokenB != address(0x0)");
        require(tokenBOracle != address(0x0),"require tokenBOracle != address(0x0)");
        tokenA = _tokenA;
        tokenAOracle = _tokenAOracle;
        tokenB = _tokenB; 
        tokenBOracle = _tokenBOracle;
        enable = _enable;
    }
    
    function addTotoalToken(uint256 addTokenA,uint256 addTokenB) public {
        totalTokenA = totalTokenA.add(addTokenA);
        totalTokenB = totalTokenB.add(addTokenB);
    }
    
    function getOracleA() public view returns(address)
    {
        return tokenAOracle;
    }

    function getCreator() public view returns(address)
    {
        return creator;
    }

    function getOracleB() public view returns(address)
    {
        return tokenBOracle;
    }

    function getEnable() public view returns(bool)
    {
        return enable;
    }

    function getTotalTokenA() public view returns(uint256)
    {
        return totalTokenA;
    }

    function getTotalTokenB() public view returns(uint256)
    {
        return totalTokenB;
    }

}

