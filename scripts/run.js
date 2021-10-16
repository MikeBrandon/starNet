const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const starContractFactory = await hre.ethers.getContractFactory('StarNet');
    const starContract = await starContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1')
    });
    await starContract.deployed();

    console.log("Contract Deployed to: ", starContract.address);
    console.log("Contract Deployed by: ", owner.address);

    let contractBalance = await hre.ethers.provider.getBalance(starContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    let starCount;
    starCount = await starContract.getTotalStars();
    
    let starTxn = await starContract.sendStar('Hello');
    await starTxn.wait();

    starCount = await starContract.getTotalStars();

    starTxn = await starContract.connect(randomPerson).sendStar('bye bye');
    await starTxn.wait();

    starCount = await starContract.getTotalStars();

    starTxn = await starContract.sendStar('Hello again');
    await starTxn.wait();

    starCount = await starContract.getTotalStars();

    starTxn = await starContract.connect(randomPerson).sendStar('bye bye again');
    await starTxn.wait();

    starCount = await starContract.getTotalStars();
    let allStars = await starContract.getAllStars();
    console.log(allStars);

    lastStar = await starContract.getLastStar();

    contractBalance = await hre.ethers.provider.getBalance(starContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );
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