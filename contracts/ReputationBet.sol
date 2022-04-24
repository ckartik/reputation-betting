// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ReputationBet {
    // The list of addreseses the key address trusts.
    mapping (address=>address[]) TrustedAddresses;
    // The stake assosciated with 
    mapping (address=>uint256[]) StakedValues;
    // Addresses that trust the key address.
    mapping (address=>address[]) Stakers;
    mapping (address=>uint256) TotalStake;
    mapping (address=>uint256) TotalNumOfStakers;
    mapping (address=>uint256) Claimable;

    function claim() public {
        require(Claimable[msg.sender] > 0);
        payable(msg.sender).transfer(Claimable[msg.sender]);
    }

    function claimable() public view returns (uint256) {
        console.log("SMART CONTRACT: SENDER %s ", msg.sender);
        return Claimable[msg.sender];
    }

    function stakeAndTrust(address TrustedAddress) public payable {
        console.log("SMART CONTRACT: SENDER %s ", msg.sender);
        TrustedAddresses[msg.sender].push(TrustedAddress);
        Stakers[TrustedAddress].push(msg.sender);
        StakedValues[TrustedAddress].push(msg.value);

        TotalStake[TrustedAddress] += msg.value;

        uint val = msg.value;
        for (uint i=0; i < TotalNumOfStakers[TrustedAddress]; i++){
            console.log("SMART CONTRACT: I GET HERE", msg.sender);
            console.log("Staked value:",StakedValues[TrustedAddress][i]);
            console.log("Staked Value by person", StakedValues[TrustedAddress][i] << 10);
            console.log("The Total staked on this individiual", TotalStake[TrustedAddress]);
            console.log("big value", ((StakedValues[TrustedAddress][i] << 10) / TotalStake[TrustedAddress]));
            
            Claimable[Stakers[TrustedAddress][i]] += (((StakedValues[TrustedAddress][i] << 10) / TotalStake[TrustedAddress]) * TotalStake[TrustedAddress]) >> 10;
            console.log("Loaded final value", Claimable[Stakers[TrustedAddress][i]]);
            console.log("Loading address",Stakers[TrustedAddress][i]);
            val -= StakedValues[TrustedAddress][i] / TotalStake[TrustedAddress];


            // Here figure out the highest staker and dispurse funds to them.
        }
        TotalNumOfStakers[TrustedAddress]+= 1;
    }



}