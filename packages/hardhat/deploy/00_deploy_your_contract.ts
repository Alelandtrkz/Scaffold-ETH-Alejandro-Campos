//import { ethers } from "hardhat";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const { getNamedAccounts, deployments } = hre;
    const { deploy } = deployments;
    const { deployer } = await getNamedAccounts();

    await deploy("YourContract", {
        from: deployer,
        args: [["Option1", "Option2", "Option3"]],
        log: true,
    });
};

export default deployYourContract;
deployYourContract.tags = ["YourContract"];
