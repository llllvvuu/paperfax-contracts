contract PaperfaxIndex { // extends ERC1155?
  struct Audit {
    uint paperfaxId;
    string ipfsHash;
    uint32 numMinorIssues;
    uint32 numMajorIssues;
    uint32 numRecommendations;
    uint32 upvotes; // stretch?
    uint32 downvotes; // stretch?
    mapping (address => uint8) voteByAddress; // does solidity have enum?
    uint8 verdict; //does solidity have enum?
  }

  struct Paperfax {
    string[] paperURIs;
    uint[] auditIds;
    address[] requestedBy;
  }

  Paperfax[] public paperfaxes;
  Audit[] public audits;
  mapping (address => uint[]) public auditIdsByUser;

  function initializePaperfax(string[] paperURIs) external {
  }

  function requestAudit(uint paperfaxId) external {
  }

  function createAudit(uint paperfaxId) external {
  }

  function upvoteAudit(uint auditId) external { // stretch?
    // remove existing vote first
  }

  // other external functions
  // stretch: how to handle minds changing? retract/respond/edit/addendum?

  // ERC-1155 functions?
}
