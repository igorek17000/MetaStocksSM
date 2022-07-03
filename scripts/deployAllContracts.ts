const { ethers, upgrades } = require('hardhat')
const os = require('os')
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { Contract } from '@ethersproject/contracts';
import { formatEther, parseEther } from 'ethers/lib/utils';
const { getImplementationAddress } = require('@openzeppelin/upgrades-core')
const colors = require('colors/safe');
import test_util from '../test/util'
async function main(): Promise<void> {

    let router: Contract;

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
        router = await test_util.connectRouter()
        console.log("router:", router.address);

        console.log("");
        // 1 TOKEN ---------------------------------------------------------------
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
        // ----------------------------------------------------------------------

        // 2 Company ---------------------------------------------------------------
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
        // ----------------------------------------------------------------------

        // 3 Franchise ------------------------------------------------
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
        // ----------------------------------------------------------------------

        // 4 Franchise Manager ------------------------------------------------
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
        console.log("");
        // ----------------------------------------------------------------------

        // Company Manager ------------------------------------------------
        contractName = 'MetaStocksCompanyManager'
        contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address, metaStocksFranchiseManager])
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
        // ----------------------------------------------------------------------


        const routerFactory = await test_util.connectFactory();
        const pairAddress = await routerFactory.getPair(test_util?.chains?.bsc?.wChainCoin, metaStocksToken.address)
        await metaStocksToken.setPairAddress(pairAddress);
        const pairContract = await test_util.connectPair(pairAddress);
        console.log(`${colors.cyan('LP Address')}: ${colors.yellow(pairContract?.address)}`)
        console.log(`${colors.cyan('LP Balance')}: ${colors.yellow(formatEther(await pairContract.balanceOf(deployer?.address)))}`)
        console.log()

        await metaStocksToken.enableTrading();
        await metaStocksCompany.transferOwnership(metaStocksCompanyManager.address);
        await metaStocksFranchise.transferOwnership(metaStocksFranchiseManager.address);
        await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksToken.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"); // bsc testnet - bnb chanlink
        await metaStocksToken.approve(test_util?.chains?.bsc?.router, ethers.constants.MaxUint256, { from: deployer?.address })
        await metaStocksToken.connect(deployer).transfer(metaStocksFranchiseManager?.address, parseEther("10000"))
        await metaStocksToken.connect(bob).approve(metaStocksFranchiseManager.address, parseEther("1000000000"))
        await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
        await metaStocksFranchiseManager.connect(deployer).setRouterAddress("0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"); // bsc testnet - bnb chanlink



        /*
        const tx = await router.connect(deployer).addLiquidityETH(
            metaStocksToken.address,
            parseEther("100000"),
            parseEther("100000"),
            parseEther("3"),
            deployer?.address,
            2648069985, // Saturday, 29 November 2053 22:59:45
            {
                value: parseEther("3"),
            }
        )
        console.log(`${colors.cyan('TX')}: ${colors.yellow(tx.hash)}`)
        console.log()
        
    
        console.log(`${colors.cyan("Deployer Token Balance:")} ${colors.yellow(formatEther(await metaStocksToken.balanceOf(deployer?.address)))}`)
        await metaStocksToken.transfer(bob?.address, parseEther("1000"))
        await metaStocksToken.connect(deployer).transfer(bob?.address, parseEther("500"))
        console.log(`${colors.cyan("Bob Token Balance:")} ${colors.yellow(formatEther(await metaStocksToken.balanceOf(bob?.address)))}`)
        console.log()


        await metaStocksCompanyManager.connect(bob).create();
        await sleep(2000)

        const isCeo = await metaStocksCompanyManager.isCeo(bob.address);
        console.log(`${colors.cyan("isCeo: ")} ${colors.yellow(isCeo)}`)

        const companyId = await metaStocksCompanyManager.getCompanyId(bob.address);
        console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)

        let companyCeoAddress = await metaStocksCompanyManager.getCompanyCEOAddress(companyId);
        console.log(`${colors.cyan("CompanyCEOAddress: ")} ${colors.yellow(companyCeoAddress)}`)


        console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)
        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 0, 1);
        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 2);
        await metaStocksFranchiseManager.connect(bob).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 3);




        const franchisesNumber = await metaStocksFranchiseManager.connect(bob).getNumberOfMetaStocksFranchises(companyId)

        console.log(`${colors.cyan("Franchises Number: ")} ${colors.yellow(franchisesNumber)}`)


        const bobBalance = await metaStocksToken.balanceOf(bob?.address);
        console.log(`${colors.cyan("Bob Balance Before Claim: ")} ${colors.yellow(formatEther(bobBalance))}`)

        const getMetaStocksFranchisesUnclaimedRewards = await metaStocksFranchiseManager.connect(bob).getMetaStocksFranchisesUnclaimedRewards(companyId)
        console.log(`${colors.cyan("getMetaStocksFranchisesUnclaimedRewards : ")} ${colors.yellow(formatEther(getMetaStocksFranchisesUnclaimedRewards))}`)

        await sleep(5000)
        await metaStocksFranchiseManager.connect(bob).claimFromAllFranchises(companyId)


        const getMetaStocksFranchisesUnclaimedRewardsAfter = await metaStocksFranchiseManager.connect(bob).getMetaStocksFranchisesUnclaimedRewards(companyId)
        console.log(`${colors.cyan("getMetaStocksFranchisesUnclaimedRewardsAfter : ")} ${colors.yellow(formatEther(getMetaStocksFranchisesUnclaimedRewardsAfter))}`)


        const bobBalanceAfter = await metaStocksToken.balanceOf(bob?.address);
        console.log(`${colors.cyan("Bob Balance After Claim: ")} ${colors.yellow(formatEther(bobBalanceAfter))}`)
*/
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