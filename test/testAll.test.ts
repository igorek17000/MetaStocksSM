import { ethers, upgrades } from 'hardhat'
const colors = require('colors');
import { Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { getImplementationAddress } from '@openzeppelin/upgrades-core'
//available functions
describe("Token contract", async () => {


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

    it("1. Get Signer", async () => {
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
    });

    it("2. Deploy MetaStocksToken", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksToken'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksToken = await upgrades.deployProxy(contractFactory, ["MetaStocksToken", "MST", 10000000000])
        await metaStocksToken.deployed()
        metaStocksTokenImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksToken.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksToken.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksTokenImplementationAddress)}`)
        console.log("");
    });

    it("3. Deploy MetaStocksCompany", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksCompany'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompany = await upgrades.deployProxy(contractFactory)
        await metaStocksCompany.deployed()
        metaStocksCompanyImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompany.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompany.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyImplementationAddress)}`)
        console.log("");
    });

    it("4. Deploy MetaStocksCompanyManager", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksCompanyManager'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address])
        await metaStocksCompanyManager.deployed()
        metaStocksCompanyManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompanyManager.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompanyManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyManagerImplementationAddress)}`)
        console.log("");
    });

    it("5. Deploy MetaStocksFranchise", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksFranchise'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchise = await upgrades.deployProxy(contractFactory)
        await metaStocksFranchise.deployed()
        metaStocksFranchiseImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchise.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseImplementationAddress)}`)
        console.log("");
    });



    it("6. Deploy MetaStocksCompanyManager", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksCompanyManager'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksCompanyManager = await upgrades.deployProxy(contractFactory, [metaStocksCompany.address])
        await metaStocksCompanyManager.deployed()
        metaStocksCompanyManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksCompanyManager.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksCompanyManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksCompanyManagerImplementationAddress)}`)
        console.log("");
    });

    it("7. Deploy MetaStocksFranchiseManager", async () => {
        console.log("");
        // DEPLOY
        const contractName = 'MetaStocksFranchiseManager'
        const contractFactory = await ethers.getContractFactory(contractName)
        metaStocksFranchiseManager = await upgrades.deployProxy(contractFactory, [metaStocksFranchise.address])
        await metaStocksFranchiseManager.deployed()
        metaStocksFranchiseManagerImplementationAddress = await getImplementationAddress(
            ethers.provider,
            metaStocksFranchise.address
        )

        console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksFranchiseManager.address)}`)
        console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksFranchiseManagerImplementationAddress)}`)
        console.log("");
    });



    /*
    it("3. Add Liquidity", async () => {
        await tokenDeployed.approve(util.chains.bsc.router, ethers.constants.MaxUint256, { from: deployer?.address })
        const tx = await router.connect(deployer).addLiquidityETH(
            tokenDeployed.address,
            parseEther("60000000"),
            parseEther("60000000"),
            parseEther("100"),
            deployer?.address,
            2648069985, // Saturday, 29 November 2053 22:59:45
            {
                value: parseEther("100"),
            }
        )
        console.log(`${colors.cyan('TX')}: ${colors.yellow(tx.hash)}`)
        console.log()

        const routerFactory = await util.connectFactory();
        const pairAddress = await routerFactory.getPair(util.chains.bsc.wChainCoin, tokenDeployed.address)
        pairContract = await util.connectPair(pairAddress);
        console.log(`${colors.cyan('LP Address')}: ${colors.yellow(pairContract?.address)}`)
        console.log(`${colors.cyan('LP Balance')}: ${colors.yellow(formatEther(await pairContract.balanceOf(deployer?.address)))}`)
        expect(1).to.be.eq(1);
        console.log()
    });

    it("4. Enable trading", async () => {
        await tokenDeployed.enableTrading();
        console.log()
    });

    it("5. Transfer From Owner To Bob ",async () => {
        await tokenDeployed.transfer(bob.address, parseEther("1000"))
        expect(await tokenDeployed.balanceOf(bob?.address)).to.be.eq(parseEther("1000"));
        console.log()
    });

    it("6. Transfer From Bob To Alice ", async () => {
        await tokenDeployed.connect(bob).transfer(alice?.address, parseEther("100"))
        expect(await tokenDeployed.balanceOf(alice?.address)).to.be.eq(parseEther("100"));
        console.log()
    });


    it("7. Buy Bob", async () => {

        console.log()
        //--- BUY
        console.log(`${colors.cyan('Contract token Balance Before Swap')}: ${colors.yellow(formatEther(await tokenDeployed.balanceOf(tokenDeployed.address)))}`)
        await util.swapExactETHForTokens(tokenDeployed.address, router, bob, parseEther("1.2"));
        console.log(`${colors.cyan('Bob token Balance After Swap')}: ${colors.yellow(formatEther(await tokenDeployed.balanceOf(bob?.address)))}`)
        console.log(`${colors.cyan('Contract token Balance After')}: ${colors.yellow(formatEther(await tokenDeployed.balanceOf(tokenDeployed.address)))}`)
        console.log()
    });


    it("8. Sell Bob", async () => {
        //--- SELL
        //await util.swapExactTokensForETH(tokenDeployed.address, router, bob, parseEther("1000")); // 100 tokens
        
        await tokenDeployed.connect(bob).approve(router.address, parseEther("100"))
        await util.swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenDeployed.address, router, bob, parseEther("100")); // 100 tokens
        console.log(`${colors.cyan('Bob token Balance')}: ${colors.yellow(formatEther(await tokenDeployed.balanceOf(bob?.address)))}`)
        console.log(`${colors.cyan('Contract token Balance After')}: ${colors.yellow(formatEther(await tokenDeployed.balanceOf(tokenDeployed.address)))}`)
        console.log()
    });
    */
});