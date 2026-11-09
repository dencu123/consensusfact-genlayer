// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ConsensusFact {

    enum Verdict {
        Pending,
        True,
        False,
        Uncertain
    }

    struct Fact {
        string claim;
        Verdict verdict;
        uint256 timestamp;
        address requester;
    }

    uint256 public factCount;

    mapping(uint256 => Fact) public facts;

    event FactRequested(
        uint256 indexed factId,
        string claim
    );

    event FactResolved(
        uint256 indexed factId,
        Verdict verdict
    );

    function requestFact(
        string memory claim
    ) public {

        factCount++;

        facts[factCount] = Fact({
            claim: claim,
            verdict: Verdict.Pending,
            timestamp: block.timestamp,
            requester: msg.sender
        });

        emit FactRequested(
            factCount,
            claim
        );
    }

    function resolveFact(
        uint256 factId,
        Verdict verdict
    ) public {

        facts[factId].verdict = verdict;

        emit FactResolved(
            factId,
            verdict
        );
    }
}
