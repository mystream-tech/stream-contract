pragma solidity ^0.5.0;

import "./Roles.sol";

contract LiquidRole {
    using Roles for Roles.Role;

    event LiquidAdded(address indexed account);
    event LiquidRemoved(address indexed account);

    Roles.Role private _Liquids;

    constructor () internal {
        _addLiquid(msg.sender);
    }

    modifier onlyLiquid() {
        require(isLiquid(msg.sender), "LiquidRole: caller does not have the Liquid role");
        _;
    }

    function isLiquid(address account) public view returns (bool) {
        return _Liquids.has(account);
    }

    function addLiquid(address account) public onlyLiquid {
        _addLiquid(account);
    }

    function renounceLiquid() public {
        _removeLiquid(msg.sender);
    }

    function _addLiquid(address account) internal {
        _Liquids.add(account);
        emit LiquidAdded(account);
    }

    function _removeLiquid(address account) internal {
        _Liquids.remove(account);
        emit LiquidRemoved(account);
    }
}
