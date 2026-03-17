// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title BaseStrategy
 * @dev Abstract contract for building professional yield strategies.
 */
contract BaseStrategy is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    address public want;      // The token we want to maximize
    address public reward;    // The token earned as reward
    address public vault;     // The authorized vault

    modifier onlyVault() {
        require(msg.sender == vault, "Only vault");
        _;
    }

    constructor(address _want, address _reward, address _vault) Ownable(msg.sender) {
        want = _want;
        reward = _reward;
        vault = _vault;
    }

    function deposit() public virtual onlyVault {
        uint256 wantBal = IERC20(want).balanceOf(address(this));
        if (wantBal > 0) {
            _extDeposit(wantBal);
        }
    }

    function withdraw(uint256 _amount) external onlyVault nonReentrant {
        uint256 wantBal = IERC20(want).balanceOf(address(this));
        if (wantBal < _amount) {
            _extWithdraw(_amount - wantBal);
            wantBal = IERC20(want).balanceOf(address(this));
        }

        uint256 withdrawAmount = wantBal < _amount ? wantBal : _amount;
        IERC20(want).safeTransfer(vault, withdrawAmount);
    }

    function harvest() external nonReentrant {
        _extClaimRewards();
        uint256 rewardBal = IERC20(reward).balanceOf(address(this));
        if (rewardBal > 0) {
            _swapRewardsToWant(rewardBal);
            _extDeposit(IERC20(want).balanceOf(address(this)));
        }
    }

    // Internal logic to be customized for specific protocols (Aave, Curve, etc.)
    function _extDeposit(uint256 _amount) internal virtual {}
    function _extWithdraw(uint256 _amount) internal virtual {}
    function _extClaimRewards() internal virtual {}
    function _swapRewardsToWant(uint256 _amount) internal virtual {}
}
