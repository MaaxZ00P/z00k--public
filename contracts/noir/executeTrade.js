const setupAztec = require('./setupAztec');
const createConfidentialTransaction = require('./createConfidentialTransaction');
const ethers = require('ethers');
const PrivateTrade = require('./artifacts/contracts/PrivateTrade.sol/PrivateTrade.json');

async function executeTrade(amount, price, isBuy) {
    const sdk = await setupAztec();
    const contractAddress = 'YOUR_CONTRACT_ADDRESS';
    const contract = new ethers.Contract(contractAddress, PrivateTrade.abi, sdk.provider.getSigner());

    const proofData = await createConfidentialTransaction(sdk, amount, price, isBuy);
    const proofHash = ethers.utils.keccak256(proofData);

    const tx = await contract.executeTrade(proofData, amount, price, isBuy, {
        gasLimit: 500000,
    });
    await tx.wait();

    console.log('Trade executed:', proofHash);
}

executeTrade(100, 500, true);
