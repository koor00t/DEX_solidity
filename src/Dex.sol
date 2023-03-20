// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IDex.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract Dex is IDex, ERC20 {
    uint public constant MINIMUM_LIQUIDITY = 10**3;
    ERC20 public tokenX;
    ERC20 public tokenY;
    ERC20 public lpToken;

    uint private reserveX;
    uint private reserveY;

    constructor(address _tokenX, address _tokenY) ERC20("DreamLP", "DLP") {
        tokenX = ERC20(_tokenX);
        tokenY = ERC20(_tokenY);
        lpToken = ERC20(address(this));
    }

    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPToeknAmount) public returns (uint256 LPTokenAmount) {
        require(tokenXAmount > 0 && tokenYAmount > 0, "Token must be not zero.");
        require(balanceOf(msg.sender) >= LPTokenAmount, "Insufficient LP.");
        reserveX = tokenX.balanceOf(address(this));
        reserveY = tokenY.balanceOf(address(this));
        uint256 liquidity;

        uint256 _totalSupply = totalSupply();
        if (_totalSupply == 0) {
            LPTokenAmount = sqrt((tokenXAmount + reserveX) * (tokenYAmount + reserveY) / MINIMUM_LIQUIDITY);
        } else {
            require(reserveX * tokenYAmount == reserveY * tokenXAmount, "Add Liquidity Error");
            LPTokenAmount = min(_totalSupply * tokenXAmount / reserveX, _totalSupply * tokenYAmount / reserveY);
        }
        require(LPTokenAmount >= minimumLPToeknAmount, "Minimum LP Error");
        _mint(msg.sender, LPTokenAmount);
        reserveX += tokenXAmount;
        reserveY += tokenYAmount;
        tokenX.transferFrom(msg.sender, address(this), tokenXAmount);
        tokenY.transferFrom(msg.sender, address(this), tokenYAmount);

        emit AddLiquidity(msg.sender, tokenXAmount, tokenYAmount);

    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public override returns (uint256, uint256){
        require(LPTokenAmount > 0, "Token must be not zero.");
        reserveX = tokenX.balanceOf(address(this));
        reserveY = tokenY.balanceOf(address(this));
        uint256 _totalSupply = totalSupply();
        uint256 tokenXAmount = div(mul(LPTokenAmount, tokenX.balanceOf(address(this))), _totalSupply);
        uint256 tokenYAmount = div(mul(LPTokenAmount, tokenY.balanceOf(address(this))), _totalSupply);
        require(tokenXAmount >= minimumTokenXAmount && tokenYAmount >= minimumTokenYAmount, "Minimum liquidity.");

        reserveX -= tokenXAmount;
        reserveY -= tokenYAmount;

        tokenX.transfer(msg.sender, tokenXAmount);
        tokenY.transfer(msg.sender, tokenYAmount);

        _burn(msg.sender, LPTokenAmount);
        emit RemoveLiquidity(msg.sender, tokenXAmount, tokenYAmount);
        return (tokenXAmount, tokenYAmount);
        
    }

    function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) public override returns (uint256) {
        require(tokenXAmount > 0 && tokenYAmount > 0, "Token must be not zero.");

    }

    function transfer(address to, uint256 lpAmount) public override(ERC20, IDex) returns (bool) {
        _mint(to, lpAmount);
        return true;
    }

    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    function add(uint x, uint y) internal pure returns (uint z) {
        require((z=x+y) >= x, "ds-math-add-overflow");
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z=x-y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z=x*y) / y == x, 'ds-math-mul-overflow');
    }
    
    function div(uint x, uint y) internal pure returns (uint z) {
        require(y > 0 || (z=x/y) * y == x,"ds-math-div-overflow");
    }
}
