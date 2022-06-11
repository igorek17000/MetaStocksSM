const { ethers, upgrades } = require('hardhat')
import hre from 'hardhat'
const os = require('os')
import fs from "fs";
import { artifacts, network } from "hardhat";
const { getImplementationAddress } = require('@openzeppelin/upgrades-core')
const colors = require('colors/safe');
async function main(): Promise<string> {
    const [deployer] = await ethers.getSigners()
    if (deployer === undefined) throw new Error('Deployer is undefined.')
    console.log(colors.cyan('Deployer Address: ') + colors.yellow(deployer.address));
    console.log();
    console.log(colors.yellow('Deploying...'));
    console.log();

    const contractName = 'Company'
    const factory = await ethers.getContractFactory(contractName)
    const company = await upgrades.deployProxy(factory, [])
    await company.deployed()
    const implAddress = await getImplementationAddress(ethers.provider, company.address);
    await updateABI(contractName)
    await verify(implAddress, [])
    console.log(contractName, company.address, implAddress)

    await company.deployed()
    await sleep(1000)

    console.log(`Company Proxy Address: ${company.address}`)
    console.log(`Implementation Address: ${implAddress}`)

    return company.address;
}

export const updateABI = async (contractName: string) => {
    const abiDir = `${__dirname}/../abi`;
    if (!fs.existsSync(abiDir)) {
        fs.mkdirSync(abiDir);
    }
    const Artifact = artifacts.readArtifactSync(contractName);
    fs.writeFileSync(
        `${abiDir}/${contractName}.json`,
        JSON.stringify(Artifact.abi, null, 2)
    )
}

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

export const verify = async (contractAddress: string, args: string[] = []) => {
    // @ts-ignore
    if (network == 'localhost' || network == 'hardhat') return
    try {
        await hre.run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        });
    } catch (ex) {
    }
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
    .then(async (r: string) => {
        console.log("");
        console.log(colors.green('Deploy Successfully!'));
        console.log(colors.cyan('Deployed Token Address: ') + colors.yellow(r));
        console.log("");
        await execShellCommand("sleep 5");
        const command = "npx hardhat verify " + r;
        console.log(colors.cyan('Run: '));
        console.log("");
        console.log(colors.yellow(command));
        console.log("");
        console.log(colors.cyan("For ") + colors.green("verify") + colors.cyan(" your contract"));
        return r;
    })
    .catch(error => {
        console.error(error);
        return undefined;
    })