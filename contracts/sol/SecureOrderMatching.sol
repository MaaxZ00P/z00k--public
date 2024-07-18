// SPDX-License-Identifier: BUSL 1
pragma solidity ^0.8.0;

contract SecureOrderMatching {
    event OrderMatched(address indexed buyer, address indexed seller, uint256 amount, uint256 price);

    function matchOrders(
        address buyer,
        address seller,
        uint256 amount,
        uint256 price
    ) public {
        emit OrderMatched(buyer, seller, amount, price);
    }
}
