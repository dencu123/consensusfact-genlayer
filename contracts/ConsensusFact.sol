// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ConsensusFact {

    enum Verdict {
        TRUE,
        FALSE,
        UNCERTAIN
    }

    struct Fact {
        string claim;
        Verdict verdict;
        uint256 timestamp;
    }

    mapping(bytes32 => Fact) public facts;

    event FactStored(
        bytes32 indexed factId,
        Verdict verdict
    );

    function storeFact(
        string memory claim,
        Verdict verdict
    ) public {

        bytes32 factId =
            keccak256(bytes(claim));

        facts[factId] = Fact(
            claim,
            verdict,
            block.timestamp
        );

        emit FactStored(
            factId,
            verdict
        );
    }
}
