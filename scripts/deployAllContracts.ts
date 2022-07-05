const { ethers, upgrades } = require('hardhat')
const os = require('os')
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { Contract } from '@ethersproject/contracts';
import { formatEther, parseEther } from 'ethers/lib/utils';
const { getImplementationAddress } = require('@openzeppelin/upgrades-core')
const colors = require('colors/safe');
import test_util from '../test/util'
async function main(): Promise<void> {

    let deployer: SignerWithAddress;
    let bob: SignerWithAddress;
    let alice: SignerWithAddress;

    let metaStocksToken: Contract;
    let metaStocksTokenImplementationAddress: string;

    let metaStocksCompany: Contract;
    let metaStocksCompanyImplementationAddress: string;


    let metaStocksFranchise: Contract;
    let metaStocksFranchiseImplementationAddress: string;


    let metaStocksCompanyManager: Contract;
    let metaStocksCompanyManagerImplementationAddress: string;

    let metaStocksFranchiseManager: Contract;
    let metaStocksFranchiseManagerImplementationAddress: string;


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

        let initialBalance = formatEther(await deployer.getBalance());
        console.log(colors.cyan('Deployer Address: ') + colors.yellow(deployer.address));
        console.log(colors.cyan('Account balance: ') + colors.yellow(initialBalance));
        console.log();


        // 1
        let contractName = 'MetaStocksToken'
        let contractFactory = await ethers.getContractFactory(contractName)
        metaStocksToken = await upgrades.deployProxy(contractFactory, ["MetaStocksToken", "MST", parseEther("1000000")])
        await metaStocksToken.deployed()
        metaStocksTokenImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksToken.address
        )
        test_util.verify(metaStocksToken.address, ["MetaStocksToken", "MST", parseEther("1000000")])

        console.log(`${colors.cyan(contractName + 'ProxyAddress: ')} ${colors.yellow(metaStocksToken.address)}`)
        console.log(`${colors.cyan(contractName + 'ImplAddress: ')} ${colors.yellow(metaStocksTokenImplementationAddress)}`)


        // 2
        contractName = 'MetaStocksCompany'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompany = await upgrades.deployProxy(contractFactory)
        await metaStocksCompany.deployed()
        metaStocksCompanyImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompany.address
        )
        test_util.verify(metaStocksCompany.address)

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompany.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyImplementationAddress)}`)
        console.log("");

        // 3
        contractName = 'MetaStocksFranchise'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchise = await upgrades.deployProxy(contractFactory)
        await metaStocksFranchise.deployed()
        metaStocksFranchiseImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )
        test_util.verify(metaStocksFranchise.address)

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchise.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseImplementationAddress)}`)
        console.log("");

        // 4
        contractName = 'MetaStocksFranchiseManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchiseManager = await upgrades.deployProxy(contractFactory, [metaStocksFranchise.address])
        await metaStocksFranchiseManager.deployed()
        metaStocksFranchiseManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )
        test_util.verify(metaStocksFranchiseManager.address)

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchiseManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseManagerImplementationAddress)}`)
        console.log("");

        // 5
        contractName = 'MetaStocksCompanyManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address, metaStocksFranchiseManager.address])
        await metaStocksCompanyManager.deployed()
        metaStocksCompanyManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompanyManager.address
        )
        test_util.verify(metaStocksCompanyManager.address)

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompanyManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyManagerImplementationAddress)}`)
        console.log("");

        // 6
        await metaStocksCompany.transferOwnership(metaStocksCompanyManager.address);
        await metaStocksFranchise.transferOwnership(metaStocksFranchiseManager.address);
        await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksToken.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"); // bsc testnet - bnb chanlink
        await metaStocksToken.connect(bob).approve(metaStocksFranchiseManager.address, parseEther("1000000000"))
        await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
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