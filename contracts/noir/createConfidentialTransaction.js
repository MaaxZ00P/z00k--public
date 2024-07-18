async function createConfidentialTransaction(sdk, amount, price, isBuy) {
    const proofData = sdk.createProof({
        assetId: sdk.ethAssetId,
        amount,
        price,
        isBuy,
    });

    return proofData;
}

module.exports = createConfidentialTransaction;
