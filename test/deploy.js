const { expect } = require("chai");
const { ethers } = require("hardhat");

describe('Our FD contract', function() {
    let fixeddeposit;
    let FixedDeposit;
    beforeEach(async function() {
    FixedDeposit = await ethers.getContractFactory("FixedDeposit");
    fixeddeposit = await FixedDeposit.deploy();
    await fixeddeposit.deployed(); 
  
  });
  describe('Checking',function(){
  it('Should deploy FD with 10000000 balance',async function () {
  
  
  expect(await fixeddeposit.balanceOf(fixeddeposit.address)).to.equal(10000000);
  
});
});
});
