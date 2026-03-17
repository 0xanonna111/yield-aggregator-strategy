// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BaseStrategy.sol";

/**
 * @title AaveV3Strategy
 * @dev Implementation of BaseStrategy for Aave V3.
 */
contract AaveV3Strategy is BaseStrategy {
    constructor(address _want, address _reward, address _vault) 
        BaseStrategy(_want, _reward, _vault) {}

    function _extDeposit(uint256 _amount) internal override {
        // Logic to supply to Aave Pool
    }

    function _extWithdraw(uint256 _amount) internal override {
        // Logic to withdraw from Aave Pool
    }

    function _extClaimRewards() internal override {
        // Logic to claim incentives (e.g. OP, ARB, or AAVE tokens)
    }

    function _swapRewardsToWant(uint256 _amount) internal override {
        // Logic to swap via Uniswap V3 or internal DEX aggregator
    }
}
