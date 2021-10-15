const main = async () => {
    const starContractFactory = await hre.ethers.getContractFactory('StarNet');
    const starContract = await starContractFactory.deploy();
    await starContract.deployed();
    console.log("Contract Deployed to: ", starContract.address);
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (e) {
        console.log("Error: ", e);
        process.exit(1);
    }
}

runMain();