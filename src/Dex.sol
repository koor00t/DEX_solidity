// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IDex.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract Dex is IDex, ERC20 {
    ERC20 public tokenX;
    ERC20 public tokenY;
    ERC20 public lpToken;

    constructor(address _tokenX, address _tokenY) ERC20("DreamLP", "DLP") {
        tokenX = ERC20(_tokenX);
        tokenY = ERC20(_tokenY);
        lpToken = ERC20(address(this));
    }

    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPToeknAmount) public returns (uint256) {
        require(tokenXAmount > 0 && tokenYAmount > 0, "Token must be not zero.");
        uint256 tokenXreserved;
        uint256 tokenYreserved;
        uint256 tokenXliquidity;
        uint256 tokenYliquidity;
        uint256 lptokenmatch;

        



    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public override returns (uint256, uint256){
        require(LPTokenAmount > 0, "Token must be not zero.");

        _burn(msg.sender, LPTokenAmount);
        
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

}
