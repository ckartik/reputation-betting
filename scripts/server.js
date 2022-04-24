const { ethers } = require("hardhat");

const express = require('express')
const app = express()
app.use(express.json())


function local_deploy() {
	const rb =  ethers.getContractFactory("ReputationBet").then((Rep) =>  Rep.deploy())

	const accounts = ethers.getSigners();

	return {"contract": rb, "accounts": accounts}
}

pair = local_deploy()

let rb = pair.contract
let accounts_pr = pair.accounts

app.get("/accounts", async (req, res) => {
    const accounts = await accounts_pr;
    const contract = await rb;

    res.send(accounts.slice(10).map((v,idx) => Object({ref_id: idx, address: v.address})))
})

app.post("/stake", async (req, res) => {
    const accounts = await accounts_pr;
    const contract = await rb;
    
    
    const staker = accounts[req.body.staker]
    const trustedAddress = accounts[req.body.addressToStake].address
    const valueToStake = req.body.value
    console.log(trustedAddress)
    const stakeTx = await contract.connect(staker).stakeAndTrust(trustedAddress, {value: ethers.utils.parseUnits(valueToStake,"wei")});
    await stakeTx.wait();
    res.send(200)
})
app.get("/claimable", async (req, res) => {
    const accounts = await accounts_pr;
    const contract = await rb;

    const account = accounts[req.body.account]
    const v = await contract.connect(account).claimable();

    res.send(v.toString())
})
app.listen(3000)