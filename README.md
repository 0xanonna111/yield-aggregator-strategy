# Yield Aggregator Strategy

A high-quality, flat-structured yield farming strategy. This repository demonstrates how to build an automated compounding machine that interacts with external DeFi protocols.

## Features
* **Auto-Compounding:** Converts reward tokens back into the staked asset automatically.
* **DeFi Integration:** Designed to interface with lending pools and decentralized exchanges (DEXs).
* **Efficiency:** Minimizes gas by bundling harvest and reinvestment logic.
* **Access Control:** Restricted functions for "Keepers" or "Strategists" to trigger harvests.

## How It Works
1. **Deposit:** Assets are moved from a Vault into this Strategy.
2. **Deploy:** The Strategy supplies assets to a lending market (e.g., Aave) to earn interest and rewards.
3. **Harvest:** A keeper calls `harvest()`. The contract claims rewards, swaps them on a DEX for the underlying asset, and redeposits.
4. **Withdraw:** The Vault requests funds back, and the strategy unwinds its position.

## Security
Includes protection against "sandwich attacks" by implementing slippage tolerance during the reward swap phase.
