// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

import "../LQTY/LQTYToken.sol";

contract LQTYTokenTester is LQTYToken {

    function unprotectedMint(address account, uint256 amount) external {
        // No check for the caller here

        _mint(account, amount);
    }

    function unprotectedSendToLQTYStaking(address _sender, uint256 _amount) external {
        // No check for the caller here
        
        if (_isHalfYear()) {_requireSenderHasNoLockPeriod(_sender);}
        _transfer(_sender, lqtyStakingAddress, _amount);
    }

    function callInternalApprove(address owner, address spender, uint256 amount) external returns (bool) {
        _approve(owner, spender, amount);
    }

    function callInternalTransfer(address sender, address recipient, uint256 amount) external returns (bool) {
        _transfer(sender, recipient, amount);
    }

    function getChainId() external pure returns (uint256 chainID) {
        //return _chainID(); // it’s private
        assembly {
            chainID := chainid()
        }
    }
}