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
app.listen(3000)