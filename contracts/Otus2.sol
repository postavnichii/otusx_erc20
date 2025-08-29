// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract OtusX is Context, AccessControlEnumerable, ERC20Burnable, ERC20Permit, ERC20Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    event MintEvent(address indexed to, uint256 amount, address indexed triggeredBy);

    constructor() ERC20("OtusX", "OTUSX") ERC20Permit("OTUSX") {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(PAUSER_ROLE, _msgSender());
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "### OTUSX: ADMIN ONLY");
        _;
    }

    modifier onlyMinter() {
        require(hasRole(MINTER_ROLE, _msgSender()), "### OTUSX: MINTER ONLY");
        _;
    }

    modifier onlyPauser() {
        require(hasRole(PAUSER_ROLE, _msgSender()), "### OTUSX: PAUSER ONLY");
        _;
    }

    function _mintLog(address to, uint256 value) internal {
        emit MintEvent(to, value, _msgSender());
    }

    function _calculateBonus(uint256 amount) internal pure returns (uint256) {
        return (amount * 10) / 100;
    }

    function _calculateBonus(uint256 amount, uint256 extra) internal pure returns (uint256) {
        return (amount * (10 + extra)) / 100;
    }

    function mintWithBonus(address to, uint256 amount) public onlyMinter {
        uint256 total = amount + _calculateBonus(amount);
        _mint(to, total);
        _mintLog(to, total);
    }

    function adminMint(address to, uint256 amount, uint256 extra) public onlyAdmin {
        uint256 total = amount + _calculateBonus(amount, extra);
        _mint(to, total);
        _mintLog(to, total);
    }

    function mint(address to, uint256 amount) public virtual onlyMinter {
        _mint(to, amount);
        _mintLog(to, amount);
    }

    function pause() public virtual onlyPauser {
        _pause();
    }

    function unpause() public virtual onlyPauser {
        _unpause();
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override (ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}