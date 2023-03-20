// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IDex.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract Dex is IDex, ERC20 {
    address public tokenX;
    address public tokenY;
    address public lpToken;

    constructor(address _tokenX, address _tokenY) ERC20("DreamLP", "DLP") {
        tokenX = ERC20(_tokenX);
        tokenY = ERC20(_tokenY);
        lpToken = ERC20(address.this);
    }

    function swap(ERC20 sourceToken, ERC20 targetToken) public returns (bool) {
        require(address(sourceToken) != address(targetToken));

        uint256 approved = targetToken.allowance(msg.sender, this);
        uint256 balance = sourceToken.balanceOf(address(this));

        require(balance >= approved);

        require(targetToken.transferFrom(msg.sender, this, approved));
        require(sourceToken.tranfer(msg.sender, approved));

        return true;
    }

    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPToeknAmount) public returns (uint256) {
        
    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public returns (uint256, uint256){
        
    }
}
