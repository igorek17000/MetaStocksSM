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

        const metaStocksToken = await ethers.getContractAt("MetaStocksToken", '0x4BE17326cdC7501C0cf84ccD7788e37c498379BB');
        //const metaStocksCompany = await ethers.getContractAt("MetaStocksCompany", '0xd12194AF69833Ea624FF7ACd3226661d35255DfF');
        //const metaStocksFranchise = await ethers.getContractAt("MetaStocksFranchise", '0x1d65B22DcEf09a701494318f03735B7afd5CdA96');
        const metaStocksFranchiseManager = await ethers.getContractAt("MetaStocksFranchiseManager", '0xE925F6a07B4c8F09d99908477EF7C2EBFAfE857d');
        //const metaStocksCompanyManager = await ethers.getContractAt("MetaStocksCompanyManager", '0xCa83053A7C08Bdebc9a997F6B3a052be4132E278');


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