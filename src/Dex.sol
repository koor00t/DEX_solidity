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

    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public override returns (uint256, uint256){
        
    }

    function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) public override returns (uint256) {
    }

    function transfer(address to, uint256 lpAmount) public override(ERC20, IDex) returns (bool) {

    }

}
