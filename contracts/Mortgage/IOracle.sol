pragma solidity ^0.5.0;


interface IOracle {
   
    function getInterval() external view returns (uint256);
	
    function setInterval(uint256) external  returns (uint256);
	
	function getFuture() external view returns (uint256);
	
    function setFuture(uint256) external  returns (uint256);
	
	function getPrice() external view returns (uint256);
	
    function setPrice(uint256) external  returns (uint256);
    
    function getLastTime() external view returns (uint256);
	
    function setLastTime(uint256) external  returns (uint256);

    function getLimiteddone() external view returns (bool);

}
