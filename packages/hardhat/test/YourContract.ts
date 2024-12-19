import { expect } from "chai";
import { ethers } from "hardhat";
import { YourContract } from "../typechain-types";

describe("YourContract", function () {
  let yourContract: YourContract;
  let _owner;

  before(async () => {
    [owner] = await ethers.getSigners();
    const yourContractFactory = await ethers.getContractFactory("YourContract");

    // Pasa un array de nombres de propuestas al desplegar el contrato
    const proposalNames = ["Option1", "Option2", "Option3"];
    yourContract = (await yourContractFactory.deploy(proposalNames)) as YourContract;
    await yourContract.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should have the right initial proposals", async function () {
      expect(await yourContract.proposals(0)).to.deep.equal(["Option1", 0]);
      expect(await yourContract.proposals(1)).to.deep.equal(["Option2", 0]);
      expect(await yourContract.proposals(2)).to.deep.equal(["Option3", 0]);
    });

    it("Should allow voting for a proposal", async function () {
      await yourContract.vote(1);
      const proposal = await yourContract.proposals(1);
      expect(proposal.voteCount).to.equal(1);
    });
  });
});
