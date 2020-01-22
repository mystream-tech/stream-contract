
pragma solidity ^0.5.0;

import "./EIP20Interface.sol";
contract WrappedEtherInterface is EIP20Interface {

    function deposit() public payable;

    function withdraw(uint amount) public;
}
