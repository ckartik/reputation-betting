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
    mapping (address=>uint) TotalNumOfStakers;
    mapping (address=>uint) Claimable;

    function claim() public {
        require(Claimable[msg.sender] > 0);
        payable(msg.sender).transfer(Claimable[msg.sender]);
    }

    function stakeAndTrust(address TrustedAddress) public payable {
        console.log("SMART CONTRACT: SENDER %s ", msg.sender);
        TrustedAddresses[msg.sender].push(TrustedAddress);
        Stakers[TrustedAddress].push(msg.sender);
        StakedValues[TrustedAddress].push(msg.value);

        TotalStake[TrustedAddress] += msg.value;

        uint val = msg.value;
        for (uint i=0; i < TotalNumOfStakers[TrustedAddress] - 1; i++){
            Claimable[Stakers[TrustedAddress][i]] += StakedValues[TrustedAddress][i] / TotalStake[TrustedAddress];
            val -= StakedValues[TrustedAddress][i] / TotalStake[TrustedAddress];
        }
        // Here figure out the highest staker and dispurse funds to them.
    }

}