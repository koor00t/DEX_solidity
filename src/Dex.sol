// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IDex.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract Dex is IDex, ERC20 {
    address public tokenX;
    address public tokenY;



    constructor(address _tokenX, address _tokenY) ERC20("DreamLP", "DLP") {
        tokenX = ERC20(_tokenX);
        tokenY = ERC20(_tokenY);
        lpToken = ERC20(address.this);
    }

    function swap(ERC20 sourceToken, ERC20 targetToken) public returns (bool) {
        require(address(sourceToken) != address(targetToken));

        uint256 approve = targetToken.allowance(msg.sender, this);
        uint256 balance = sourceToken.balanceOf(address(this));

        require(balance >= approve);

        require(targetToken.transferFrom(msg.sender, this, approve));
        require(sourceToken.tranfer(msg.sender, approve));

        return true;
    }

    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPToeknAmount) public return (uin256) {
        number = newNumber;
    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public return (uint256, uint256){
        number++;
    }
}
