//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract YourContract {
    struct Proposal {
        string name;
        uint voteCount;
    }

    Proposal[] public proposals;

    mapping(address => bool) public hasVoted;

    constructor(string[] memory proposalNames) {
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({ name: proposalNames[i], voteCount: 0 }));
        }
    }
    function vote(uint proposalIndex) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal index.");

        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount += 1;
    }
    function winningProposal() public view returns (uint winningProposalIndex) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }
    }
    function winnerName() public view returns (string memory) {
        return proposals[winningProposal()].name;
    }
}