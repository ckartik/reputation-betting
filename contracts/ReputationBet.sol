// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ReputationBet {
    // The list of addreseses the key address trusts.
    mapping (address=>address[]) TrustedAddresses;
    // The stake assosciated with 
    mapping (address=>uint[]) StakedValues;
    // Addresses that trust the key address.
    mapping (address=>address[]) Stakers;
    mapping (address=>uint) TotalStake;
    mapping (address=>uint) TotalStakers;
    mapping (address=>uint) Claimable;

    function stakeAndTrust(address TrustedAddress) public payable {
        console.log("SMART CONTRACT: SENDER %s ", msg.sender);
        TrustedAddresses[msg.sender].push(TrustedAddress);
        Stakers[TrustedAddress].push(msg.sender);
        StakedValues[TrustedAddress].push(msg.value);

        TotalStake[TrustedAddress] += msg.value;

        uint val = msg.value;
        for (uint i=0; i < TotalStakers[TrustedAddress] - 1; i++){
            val = val;
        }
    }


}