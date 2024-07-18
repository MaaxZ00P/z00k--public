const ethers = require('ethers');
const PrivateTrade = require('./artifacts/contracts/PrivateTrade.sol/PrivateTrade.json');

async function settleTrade(proofHash, proofData, trader, amount, price, isBuy) {
    const provider = new ethers.providers.JsonRpcProvider('https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID');
    const wallet = new ethers.Wallet('YOUR_PRIVATE_KEY', provider);
    const contractAddress = 'YOUR_CONTRACT_ADDRESS';
    const contract = new ethers.Contract(contractAddress, PrivateTrade.abi, wallet);

    const tx = await contract.settleTrade(proofHash, proofData, trader, amount, price, isBuy, {
        gasLimit: 500000,
    });
    await tx.wait();

    console.log('Trade settled:', proofHash);
}

module.exports = settleTrade;
