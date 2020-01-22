pragma solidity ^0.5.0;

import "./Roles.sol";

contract ProxyRole {
    using Roles for Roles.Role;

    event ProxyAdded(address indexed account);
    event ProxyRemoved(address indexed account);

    Roles.Role private _Proxys;

    constructor () internal {
        _addProxy(msg.sender);
    }

    modifier onlyProxy() {
        require(isProxy(msg.sender), "ProxyRole: caller does not have the Proxy role");
        _;
    }

    function isProxy(address account) public view returns (bool) {
        return _Proxys.has(account);
    }

    function addProxy(address account) public onlyProxy {
        _addProxy(account);
    }

    function renounceProxy() public {
        _removeProxy(msg.sender);
    }

    function _addProxy(address account) internal {
        _Proxys.add(account);
        emit ProxyAdded(account);
    }

    function _removeProxy(address account) internal {
        _Proxys.remove(account);
        emit ProxyRemoved(account);
    }
}
