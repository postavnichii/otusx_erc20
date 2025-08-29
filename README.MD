# **🪙 OtusX (OTUSX) - ERC-20 Token**

[![Solidity](https://img.shields.io/badge/Solidity-^0.8.0-363636.svg?logo=solidity)](https://soliditylang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenZeppelin](https://img.shields.io/badge/Built%20with-OpenZeppelin-3677FF)](https://openzeppelin.com/)

*A secure, role-based ERC-20 token with minting bonuses, burning, pausing, and permit functionality.*

---

## **📜 Overview**

`OtusX` (\$OTUSX) is an **ERC-20 compliant** token built with OpenZeppelin libraries, extended with additional features for flexible token management:

* **Standard ERC-20 functions** (`transfer`, `approve`, `balanceOf`, etc.).
* **Minting** with optional **bonus tokens**.
* **Burnable**: any holder can destroy their tokens.
* **Pausable**: transfers can be frozen in emergencies.
* **Role-based access control** (Admin, Minter, Pauser).
* **ERC20Permit (EIP-2612)**: gasless approvals via signatures.

---

## **🛠 Contract Features**

| Feature               | Description                                                            |
| --------------------- | ---------------------------------------------------------------------- |
| **ERC-20 Standard**   | Fully compliant with [EIP-20](https://eips.ethereum.org/EIPS/eip-20).  |
| **Mintable**          | `MINTER_ROLE` can mint new tokens.                                     |
| **Bonus Minting**     | `mintWithBonus` adds +10% automatically. Admins can set extra bonuses. |
| **Burnable**          | Any holder can burn their tokens.                                      |
| **Pausable**          | `PAUSER_ROLE` can pause/unpause transfers.                             |
| **Role-Based Access** | `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE`, `PAUSER_ROLE`.                    |
| **Permit (EIP-2612)** | Gasless approvals via signed messages.                                 |
| **Secure**            | Protected with OpenZeppelin best practices.                            |

---

## **🔧 Technical Details**

### **1. Contract Addresses**

| Network  | Contract Address | Explorer                             |
| -------- | ---------------- | ------------------------------------ |
| Ethereum | `0x...`          | [Etherscan](https://etherscan.io/)   |
| Polygon  | `0x...`          | [Polyscan](https://polygonscan.com/) |

### **2. Tokenomics**

| Parameter          | Value               | Notes                                         |
| ------------------ | ------------------- | --------------------------------------------- |
| **Name**           | OtusX               |                                               |
| **Symbol**         | OTUSX               |                                               |
| **Decimals**       | 18                  | Standard for ERC-20                           |
| **Initial Supply** | 0                   | All tokens minted post-deployment via roles.  |
| **Minting**        | Controlled by roles | Bonus mint adds extra tokens (10% or custom). |
| **Burning**        | Any holder          | Supply can decrease over time.                |

### **3. Smart Contract Details**

* **Solidity Version**: `^0.8.0`
* **License**: [MIT](https://opensource.org/licenses/MIT)
* **Dependencies**:

  * [`@openzeppelin/contracts`](https://github.com/OpenZeppelin/openzeppelin-contracts) (v4.9.0+)

---

## **📂 Contract Structure**

```
contracts/
├── OtusX.sol              # Main token contract
tests/
├── OtusX.test.js          # Hardhat/Foundry tests
scripts/
├── deploy.js              # Deployment script
└── interact.js            # Example interactions
```

---

## **🚀 Getting Started**

### **1. Prerequisites**

* Node.js v16+
* Hardhat or Foundry
* Remix IDE (optional for quick testing)

### **2. Installation**

```bash
# Clone the repo
git clone https://github.com/your-repo/otusx-token.git
cd otusx-token

# Install dependencies
npm install --save-dev @openzeppelin/contracts hardhat @nomicfoundation/hardhat-toolbox
```

### **3. Compile & Test**

```bash
# Using Hardhat
npx hardhat compile
npx hardhat test

# Using Foundry
forge build
forge test
```

### **4. Deployment**

```bash
npx hardhat run scripts/deploy.js --network [network]
```

Or via **Remix IDE**:

* Open `OtusX.sol`
* Compile with Solidity ^0.8.0
* Deploy using "Deploy & Run" tab

---

## **🔍 Security Considerations**

✅ Safe practices:

* ReentrancyGuard via OpenZeppelin
* SafeMath built into Solidity ≥0.8.0
* Role-based access for critical functions

⚠️ Risks & Mitigations:

| Risk                 | Mitigation                                 |
| -------------------- | ------------------------------------------ |
| Admin key compromise | Use multisig or timelock contracts.        |
| Over-minting         | Restricted via `MINTER_ROLE`/`ADMIN_ROLE`. |
| Pauser abuse         | Only `PAUSER_ROLE` can freeze transfers.   |

---

## **📊 Interacting with OtusX**

### **Read Functions**

| Function                   | Description                |
| -------------------------- | -------------------------- |
| `balanceOf(address)`       | Get balance of an address. |
| `totalSupply()`            | Get total supply.          |
| `allowance(owner,spender)` | Get approved allowance.    |

### **Write Functions**

| Function                       | Description                 | Access Control       |
| ------------------------------ | --------------------------- | -------------------- |
| `transfer(to, amount)`         | Send tokens.                | Any holder           |
| `approve(spender, amount)`     | Approve allowance.          | Any holder           |
| `mint(to, amount)`             | Mint tokens.                | MINTER\_ROLE         |
| `mintWithBonus(to, amount)`    | Mint tokens +10% bonus.     | MINTER\_ROLE         |
| `adminMint(to, amount, extra)` | Mint tokens + custom bonus. | DEFAULT\_ADMIN\_ROLE |
| `burn(amount)`                 | Burn tokens.                | Any holder           |
| `pause()` / `unpause()`        | Pause/unpause transfers.    | PAUSER\_ROLE         |

---

## **🧪 Example Code**

### Transfer Tokens (JavaScript, ethers.js)

```js
const { ethers } = require("ethers");
const ABI = [/* Token ABI */];
const provider = new ethers.providers.JsonRpcProvider("RPC_URL");
const wallet = new ethers.Wallet("PRIVATE_KEY", provider);
const token = new ethers.Contract("TOKEN_ADDRESS", ABI, wallet);

// Transfer 100 OTUSX
await token.transfer("0xRecipient", ethers.utils.parseUnits("100", 18));
```

### Check Balance (Solidity)

```solidity
IOtusX token = IOtusX(0xTokenAddress);
uint256 balance = token.balanceOf(msg.sender);
```