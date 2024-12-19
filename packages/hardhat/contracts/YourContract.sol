pragma solidity ^0.8.0;

contract YourContract {
    // Estructura para una propuesta
    struct Proposal {
        string name;
        uint voteCount;
    }

    // Lista de propuestas
    Proposal[] public proposals;

    // Mapeo para registrar si una dirección ya votó
    mapping(address => bool) public hasVoted;

    // Constructor para inicializar las propuestas
    constructor(string[] memory proposalNames) {
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({ name: proposalNames[i], voteCount: 0 }));
        }
    }

    // Función para votar por una propuesta
    function vote(uint proposalIndex) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal index.");

        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount += 1;
    }

    // Función para obtener el índice de la propuesta ganadora
    function winningProposal() public view returns (uint winningProposalIndex) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }
    }

    // Función para obtener el nombre de la propuesta ganadora
    function winnerName() public view returns (string memory) {
        return proposals[winningProposal()].name;
    }
}
