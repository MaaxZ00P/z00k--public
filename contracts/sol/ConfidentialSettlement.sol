// SPDX-License-Identifier: BUSL 1
pragma solidity ^0.8.0;

import "@aztec/protocol/contracts/libs/ProofUtils.sol";

contract ConfidentialSettlement {
    using ProofUtils for bytes32;

    event TradeSettled(bytes32 indexed proofHash, address indexed trader, uint256 amount, uint256 price, bool isBuy);

    function settleTrade(
        bytes32 proofHash,
        bytes memory proofData,
        address trader,
        uint256 amount,
        uint256 price,
        bool isBuy
    ) public {
        require(proofHash.validateProof(proofData), "Invalid proof");

        emit TradeSettled(proofHash, trader, amount, price, isBuy);
    }
}
