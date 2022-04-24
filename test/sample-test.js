const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Deploy & Stake", function () {
  it("Should deploy the contract", async function () {
    const RB = await ethers.getContractFactory("ReputationBet");
    const rb = await RB.deploy();
    await rb.deployed();
    const [owner, addr1, addr2] = await ethers.getSigners();
    // console.log(rb)
    // console.log(await owner.getBalance())
    const ad = await addr1.getAddress();
    const stakeTx = await rb.stakeAndTrust(ad);
    await stakeTx.wait();

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
