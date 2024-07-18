// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@aztec/protocol/contracts/AZTEC.sol";
import "@aztec/protocol/contracts/ACE/ACE.sol";
import "@aztec/protocol/contracts/ERC20/ERC20Mintable.sol";
import "@aztec/protocol/contracts/libs/ProofUtils.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PrivateTrade is Ownable {
    using ProofUtils for bytes32;

    ACE public ace;
    AZTEC public aztec;
    ERC20Mintable public token;

    event TradeExecuted(bytes32 indexed proofHash, address indexed trader, uint256 amount, uint256 price, bool isBuy);
    event TradeSettled(bytes32 indexed proofHash, address indexed trader, uint256 amount, uint256 price, bool isBuy);

    constructor(address _ace, address _aztec, address _token) {
        ace = ACE(_ace);
        aztec = AZTEC(_aztec);
        token = ERC20Mintable(_token);
    }

    function executeTrade(
        bytes memory proofData,
        uint256 amount,
        uint256 price,
        bool isBuy
    ) public {
        bytes32 proofHash = keccak256(proofData);
        ace.validateProof(proofHash, proofData);

        emit TradeExecuted(proofHash, msg.sender, amount, price, isBuy);
    }

    function settleTrade(
        bytes32 proofHash,
        bytes memory proofData,
        address trader,
        uint256 amount,
        uint256 price,
        bool isBuy
    ) public onlyOwner {
        require(proofHash.validateProof(proofData), "Invalid proof");

        emit TradeSettled(proofHash, trader, amount, price, isBuy);
    }
}
