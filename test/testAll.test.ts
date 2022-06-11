import { ethers, upgrades } from 'hardhat'
const colors = require('colors');
import { Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { getImplementationAddress } from '@openzeppelin/upgrades-core'
import { parseEther } from 'ethers/lib/utils';
import { expect } from 'chai';

describe("MetaStocks Testing", async () => {

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

    describe("1 - Deploy MetaStock Contracts", async () => {

        it("1.1 - Get Signer", async () => {
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

        it("1.2 - Deploy MetaStocksToken", async () => {
            console.log("");
            // DEPLOY
            const contractName = 'MetaStocksToken'
            const contractFactory = await ethers.getContractFactory(contractName)
            metaStocksToken = await upgrades.deployProxy(contractFactory, ["MetaStocksToken", "MST", parseEther("1000000")])
            await metaStocksToken.deployed()
            metaStocksTokenImplementationAddress = await getImplementationAddress(
                ethers.provider,
                metaStocksToken.address
            )

            console.log(`${colors.cyan(contractName + ' Proxy Address: ')} ${colors.yellow(metaStocksToken.address)}`)
            console.log(`${colors.cyan(contractName + ' Implementation Address: ')} ${colors.yellow(metaStocksTokenImplementationAddress)}`)
            console.log("");
        });

        it("1.3 - Deploy MetaStocksCompany", async () => {
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


        it("1.4 - Deploy MetaStocksFranchise", async () => {
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
    });

    describe("Deploy Deploy MetaStock Contract Managers", async () => {

        it("5. Deploy MetaStocksCompanyManager", async () => {
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


    });

    describe("Transfer Ownerships", async () => {

        it("8. Transfer Ownership MetastockCompany -> MetaStocksCompanyManager", async () => {
            await metaStocksCompany.transferOwnership(metaStocksCompanyManager.address);
        })

        it("9. Transfer Ownership MetaStocksFranchise -> MetaStocksFranchiseManager", async () => {
            await metaStocksFranchise.transferOwnership(metaStocksFranchiseManager.address);
        })
    })

    describe("Config MetaStocks Token", async () => {



        it("10. Set Router", async () => {
            await metaStocksToken.setRouterAddress("0x688d21b0B8Dc35971AF58cFF1F7Bf65639937860");
            console.log()
        });


        it("11. Enable trading", async () => {
            await metaStocksToken.enableTrading();
            console.log()
        });

        it("12. Transfer From Owner To Bob ", async () => {
            console.log(`${colors.cyan("Deployer Token Balance:")} ${colors.yellow(await metaStocksToken.balanceOf(deployer?.address))}`)
            expect(await metaStocksToken.balanceOf(deployer?.address)).to.be.gt(parseEther("0"));

            //await metaStocksToken.transfer(bob?.address, parseEther("1000"))
            await metaStocksToken.connect(deployer).transfer(bob?.address, parseEther("10"))
            console.log(`${colors.cyan("Bob Token Balance:")} ${colors.yellow(await metaStocksToken.balanceOf(bob?.address))}`)
            expect(await metaStocksToken.balanceOf(bob?.address)).to.be.gt(parseEther("0"));
            console.log()
        });
    })


    describe("Config contract", async () => {

        it("11. Create MetastockCompany", async () => {
            await metaStocksCompanyManager.connect(deployer).create();

            const isCeo = await metaStocksCompanyManager.isCeo(deployer.address);
            console.log(`${colors.cyan("isCeo: ")} ${colors.yellow(isCeo)}`)

            const companyId = await metaStocksCompanyManager.getCompanyId(deployer.address);
            console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)

            let companyCeoAddress = await metaStocksCompanyManager.getCompanyCEOAddress(deployer.address);
            console.log(`${colors.cyan("CompanyCEOAddress: ")} ${colors.yellow(companyCeoAddress)}`)

        })

        it("12. Set Payment Token Address MetaStocksFranchise", async () => {
            await metaStocksToken.connect(deployer).approve(metaStocksFranchiseManager.address, parseEther("1000000000"))
            await metaStocksFranchiseManager.setPaymentTokenAddress(metaStocksToken.address);
        })

        it("13. Create MetaStocksFranchise", async () => {
            let companyId = await metaStocksCompanyManager.getCompanyId(deployer.address);
            console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)

            await metaStocksFranchiseManager.connect(deployer).createMetaStocksFranchise(metaStocksFranchiseManager.address, companyId, 1, 0x0);
            //console.log(`${colors.cyan("CompanyId: ")} ${colors.yellow(companyId)}`)


        })
    });

});