pragma solidity ^0.5.0;

import "./Roles.sol";

contract OracleRole {
    using Roles for Roles.Role;

    event OracleAdded(address indexed account);
    event OracleRemoved(address indexed account);

    Roles.Role private _Oracles;

    constructor () internal {
        _addOracle(msg.sender);
    }

    modifier onlyOracle() {
        require(isOracle(msg.sender), "OracleRole: caller does not have the Oracle role");
        _;
    }

    function isOracle(address account) public view returns (bool) {
        return _Oracles.has(account);
    }

    function addOracle(address account) public onlyOracle {
        _addOracle(account);
    }

    function renounceOracle() public {
        _removeOracle(msg.sender);
    }

    function _addOracle(address account) internal {
        _Oracles.add(account);
        emit OracleAdded(account);
    }

    function _removeOracle(address account) internal {
        _Oracles.remove(account);
        emit OracleRemoved(account);
    }
}
