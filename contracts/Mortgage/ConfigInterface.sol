pragma solidity ^0.5.0;

contract ConfigInterface {

  function getConfigValue(string memory key) public view returns (uint256);
  function getOracleAddress(string memory key) public view returns (address);
  function getTokenAddress(string memory key) public view returns (address);

}
