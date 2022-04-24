const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Deploy & Stake", function () {
  it("Should deploy the contract", async function () {
    const RB = await ethers.getContractFactory("ReputationBet");
    const rb = await RB.deploy();
    await rb.deployed();
    const prov = ethers.getDefaultProvider();

    const [owner, addr1, addr2] = await ethers.getSigners();
    // console.log(rb)
    // console.log(await owner.getBalance())
    const ad = await addr1.getAddress();
    const ad2 = await addr2.getAddress();
    const stakeTx = await rb.connect(owner).stakeAndTrust(ad, {value: ethers.utils.parseUnits("10", "wei")});
    const value1 = await rb.connect(addr1).claimable();
    const balance = await prov.getBalance(rb.address);
    console.log(balance);
    await stakeTx.wait();
    console.log(value1)
    const stakeTx2 = await rb.connect(addr2).stakeAndTrust(ad, {value: ethers.utils.parseUnits("5","wei")});
    await stakeTx2.wait();

    const value2 = await rb.connect(owner).claimable();
    console.log(value2)

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
