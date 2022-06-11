const { ethers, upgrades } = require('hardhat')
const os = require('os')
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { Contract } from '@ethersproject/contracts';
import { parseEther } from 'ethers/lib/utils';
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
        bob = signers[0];
        alice = signers[0];

        console.log("");
        // DEPLOY
        let contractName = 'MetaStocksToken'
        let contractFactory = await ethers.getContractFactory(contractName)
        metaStocksToken = await upgrades.deployProxy(contractFactory, ["MetaStocksToken", "MST", parseEther("1000000")])
        await metaStocksToken.deployed()
        metaStocksTokenImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksToken.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksToken.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksTokenImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksToken.address)

        console.log("");
        // DEPLOY
        contractName = 'MetaStocksCompany'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompany = await upgrades.deployProxy(contractFactory)
        await metaStocksCompany.deployed()
        metaStocksCompanyImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompany.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompany.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksCompany.address)



        console.log("");
        // DEPLOY
        contractName = 'MetaStocksFranchise'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchise = await upgrades.deployProxy(contractFactory)
        await metaStocksFranchise.deployed()
        metaStocksFranchiseImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchise.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksFranchise.address)


        console.log("");
        // DEPLOY
        contractName = 'MetaStocksCompanyManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address])
        await metaStocksCompanyManager.deployed()
        metaStocksCompanyManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompanyManager.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompanyManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyManagerImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksFranchise.address)




        console.log("");
        // DEPLOY
        contractName = 'MetaStocksCompanyManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address])
        await metaStocksCompanyManager.deployed()
        metaStocksCompanyManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompanyManager.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompanyManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyManagerImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksCompanyManager.address, [metaStocksCompany.address])



        console.log("");
        // DEPLOY
        contractName = 'MetaStocksFranchiseManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchiseManager = await upgrades.deployProxy(contractFactory, [metaStocksFranchise.address])
        await metaStocksFranchiseManager.deployed()
        metaStocksFranchiseManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchiseManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseManagerImplementationAddress)}`)
        console.log("");
        await sleep(5000)
        await test_util.verifyWithotDeploy(contractName, metaStocksCompanyManager.address, [metaStocksFranchise.address])

        await metaStocksCompany.connect(deployer).transferOwnership(metaStocksCompanyManager.address);
        await sleep(2000);
        await metaStocksFranchise.connect(deployer).transferOwnership(metaStocksFranchiseManager.address);
        await sleep(2000);
        await metaStocksFranchiseManager.connect(deployer).setPaymentTokenAddress(metaStocksToken.address);
        await sleep(2000);
        await metaStocksToken.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3");
        await sleep(2000);
        await metaStocksToken.connect(deployer).transfer(metaStocksFranchiseManager?.address, parseEther("10000"))
        await sleep(2000);
        await metaStocksToken.connect(deployer).enableTrading();
        await sleep(2000);
        await metaStocksToken.connect(deployer).transfer(bob?.address, parseEther("1000"))
        await sleep(2000);

        await metaStocksCompanyManager.connect(bob).create();
        await sleep(2000);

        console.log(`${colors.cyan("Deployer Token Balance:")} ${colors.yellow(await metaStocksToken.balanceOf(deployer?.address))}`)
        console.log(`${colors.cyan("Bob Token Balance:")} ${colors.yellow(await metaStocksToken.balanceOf(bob?.address))}`)

        const isCeo = await metaStocksCompanyManager.isCeo(bob.address);
        let companyId = await metaStocksCompanyManager.getCompanyId(bob.address);
        let companyCeoAddress = await metaStocksCompanyManager.getCompanyCEOAddress(bob.address);

        console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)
        console.log(`${colors.cyan("isCeo: ")} ${colors.yellow(isCeo)}`)
        console.log(`${colors.cyan("CompanyCEOAddress: ")} ${colors.yellow(companyCeoAddress)}`)

        await metaStocksToken.connect(bob).approve(metaStocksFranchiseManager.address, parseEther("1000000000"))
        await sleep(2000);

        console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)

        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 1, 0x0);
        await sleep(2000);
        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 2, 0x0);
        await sleep(2000);
        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 3, 0x0);
        await sleep(2000);


        const franchisesNumber = await metaStocksFranchiseManager.connect(bob).getNumberOfMetaStocksFranchises(companyId)

        console.log(`${colors.cyan("Franchises Number: ")} ${colors.yellow(franchisesNumber)}`)

        await sleep(5000)


        const getMetaStocksFranchisesUnclaimedRewards = await metaStocksFranchiseManager.connect(bob).getMetaStocksFranchisesUnclaimedRewards(companyId)
        console.log(`${colors.cyan("getMetaStocksFranchisesUnclaimedRewards : ")} ${colors.yellow(getMetaStocksFranchisesUnclaimedRewards)}`)

        const bobBalance = await metaStocksToken.balanceOf(bob?.address);
        console.log(`${colors.cyan("bob Balance : ")} ${colors.yellow(bobBalance)}`)

        companyId = await metaStocksCompanyManager.getCompanyId(deployer.address);
        await metaStocksFranchiseManager.connect(deployer).claimFromAllFranchises(companyId)


        const bobBalanceAfter = await metaStocksToken.balanceOf(deployer?.address);
        console.log(`${colors.cyan("bob BalanceAfter : ")} ${colors.yellow(bobBalanceAfter)}`)
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