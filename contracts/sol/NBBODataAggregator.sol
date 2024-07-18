// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NBBODataAggregator {
    struct NBBO {
        uint256 bestBid;
        uint256 bestOffer;
        uint256 timestamp;
    }

    NBBO public currentNBBO;
    address public admin;

    event NBBOUpdated(uint256 bestBid, uint256 bestOffer, uint256 timestamp);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function updateNBBO(uint256 _bestBid, uint256 _bestOffer) external onlyAdmin {
        currentNBBO = NBBO(_bestBid, _bestOffer, block.timestamp);
        emit NBBOUpdated(_bestBid, _bestOffer, block.timestamp);
    }

    function getNBBO() external view returns (uint256, uint256, uint256) {
        return (currentNBBO.bestBid, currentNBBO.bestOffer, currentNBBO.timestamp);
    }
}
