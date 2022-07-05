const { ethers } = require('hardhat')
const os = require('os')
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

const colors = require('colors/safe');
async function main(): Promise<void> {


    let deployer: SignerWithAddress;
    let bob: SignerWithAddress;
    let alice: SignerWithAddress;

    console.log("");
    const signers = await ethers.getSigners();
    if (signers[0] !== undefined) {
        deployer = signers[0];
        console.log(`${colors.cyan('Deployer Address')}: ${colors.yellow(deployer?.address)}`)
    }
    if (signers[1] !== undefined) {
        bob = signers[1];
        console.log(`${colors.cyan('Bob Address')}: ${colors.yellow(bob?.address)}`)
    }
    if (signers[2] !== undefined) {
        alice = signers[2];
        console.log(`${colors.cyan('Alice Address')}: ${colors.yellow(alice?.address)}`)
    }
    console.log("");

    if (signers[0] != undefined) {

        deployer = signers[0];
        bob = signers[1];
        alice = signers[2];

        const metaStocksToken = await ethers.getContractAt("MetaStocksToken", '0x803F2C9606a35974b3F9E05e17A7adFF38A8FCB9');
        //const metaStocksCompany = await ethers.getContractAt("MetaStocksCompany", '0x2b1962CFCD231D48bBD290f77Fb433827196384d');
        //const metaStocksFranchise = await ethers.getContractAt("MetaStocksFranchise", '0xdd1F77340D82f2F5ED5Bf77963D1C994A8AF7885');
        const metaStocksFranchiseManager = await ethers.getContractAt("MetaStocksFranchiseManager", '0x419f033AFA97DD568738Eae9EaE27aD90a7d3a0A');
        //const metaStocksCompanyManager = await ethers.getContractAt("MetaStocksCompanyManager", '0x5Fc01c005189DDeed527EfD9e1A929a84B7917c5');


        //await metaStocksCompany.connect(deployer).transferOwnership(metaStocksCompanyManager.address);
        //await metaStocksFranchise.connect(deployer).transferOwnership(metaStocksFranchiseManager.address);
        await metaStocksFranchiseManager.connect(deployer).setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksToken.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"); // bsc testnet - bnb chanlink
        await metaStocksFranchiseManager.connect(deployer).setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksFranchiseManager.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"); // bsc testnet - bnb chanlink

    }


};

export const sleep = async (ms: number) => {
    let command = 'sleep'
    if (os.platform() === 'linux') {
        command = 'sleep'
    }

    console.log()
    const s = ms / 1000
    console.log(command + ' ', s.toString(), ' seconds')
    await execShellCommand(command + ' ' + s.toString())
    console.log('awake')
    console.log()
}
/**
 * Executes a shell command and return it as a Promise.
 * @param cmd {string}
 * @return {Promise<string>}
 */
function execShellCommand(cmd: string) {
    const exec = require('child_process').exec
    return new Promise((resolve) => {
        exec(cmd, (error: any, stdout: string, stderr: string) => {
            if (error) {
                console.warn(error)
            }
            resolve(stdout ? stdout : stderr)
        })
    })
}

main()
    .then(async (r: void) => {
        console.log("");
        console.log(colors.green('Deploy Successfully!'));
        console.log("");
        return r;
    })
    .catch(error => {
        console.error(error);
        return undefined;
    })