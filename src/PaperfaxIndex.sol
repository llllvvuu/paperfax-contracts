// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

contract PaperfaxIndex { // extends ERC1155?
    enum Vote {
        UP,
        DOWN
    }

    enum Verdict {
        GREEN,
        YELLOW,
        RED
    }

    struct Audit {
        uint paperfaxId;
        string ipfsHash;
        uint32 numMinorIssues;
        uint32 numMajorIssues;
        uint32 numRecommendations;
        uint32 upvotes;
        uint32 downvotes;
        mapping (address => Vote) userToVote;
        Verdict verdict;
    }

    struct Paperfax {
        string[] paperURIs;
        uint[] auditIds;
        address[] auditRequestedBy;
    }

    mapping (uint => Paperfax) paperfaxes;
    mapping (uint => Audit) audits;
    mapping (address => uint[]) public userToAudits;
    mapping (string => uint) public uriToPaperfaxId;
    uint public numPaperfaxes;
    uint public numAudits;

    function initializePaperfax(string[] memory _paperURIs) external {
        Paperfax storage paperfax = paperfaxes[++numPaperfaxes];
        paperfax.paperURIs = _paperURIs;
        for (uint i = 0; i < _paperURIs.length; i++) {
            uriToPaperfaxId[_paperURIs[i]] = numPaperfaxes;
        }
    }

    function paperfaxDetails(string calldata _paperURI) external view returns(
        uint paperfaxId,
        Verdict[] memory verdicts,
        string[] memory ipfsHashes,
        uint32[] memory numMinorIssues,
        uint32[] memory numMajorIssues,
        uint32[] memory numRecommendations,
        uint32[] memory upvotes,
        uint32[] memory downvotes
    ) {
        paperfaxId = uriToPaperfaxId[_paperURI];
        Paperfax storage paperfax = paperfaxes[paperfaxId];
        uint numPaperAudits = paperfax.auditIds.length;
        verdicts = new Verdict[](numPaperAudits);
        ipfsHashes = new string[](numPaperAudits);
        numMinorIssues = new uint32[](numPaperAudits);
        numMajorIssues = new uint32[](numPaperAudits);
        numRecommendations = new uint32[](numPaperAudits);
        upvotes = new uint32[](numPaperAudits);
        downvotes = new uint32[](numPaperAudits);

        for (uint i = 0; i < numPaperAudits; i++) {
            Audit storage audit = audits[paperfax.auditIds[i]];
            verdicts[i] = audit.verdict;
            ipfsHashes[i] = audit.ipfsHash;
            numMinorIssues[i] = audit.numMinorIssues;
            numMajorIssues[i] = audit.numMajorIssues;
            numRecommendations[i] = audit.numRecommendations;
            upvotes[i] = audit.upvotes;
            downvotes[i] = audit.downvotes;
        }
    }

    function requestAudit(uint _paperfaxId) external {
        paperfaxes[_paperfaxId].auditRequestedBy.push(msg.sender);
    }

    function createAudit(
        uint _paperfaxId,
        Verdict _verdict,
        string calldata _ipfsHash,
        uint32 _numMinorIssues,
        uint32 _numMajorIssues,
        uint32 _numRecommendations
    ) external {
        // when you submit an audit,
        // call the IPFS API/SDK to upload the comments and get the hash,
        // then submit the ethereum tx with that hash
        Audit storage audit = audits[++numAudits];
        Paperfax storage paperfax = paperfaxes[_paperfaxId];
        paperfax.auditIds.push(numAudits);
        audit.paperfaxId = _paperfaxId;
        audit.verdict = _verdict;
        audit.ipfsHash = _ipfsHash;
        audit.numMinorIssues = _numMinorIssues;
        audit.numMajorIssues = _numMajorIssues;
        audit.numRecommendations = _numRecommendations;
        userToAudits[msg.sender].push(numAudits);
    }

    function upvoteAudit(uint _auditId, Vote _type) external {
        // TODO: remove existing vote first
        audits[_auditId].userToVote[msg.sender] = _type;
        if (_type == Vote.UP) {
            audits[_auditId].upvotes++;
        } else {
            audits[_auditId].downvotes++;
        }
    }

      /**
  function setVote
  function upvoteAudit(uint auditId) external { // stretch?
    // remove existing vote first
    audits[auditId].verdict = Vote.UP;
    
  }
  
  /**
  
  //    SHOW ME THE PAPERFAX
  function getPaperfax(string memory _uri) public view returns(Paperfax memory){
      for(uint i= 0; i<paperfaxes.length; i++){
          Paperfax memory p = paperfaxes[i];
          for(uint j = 0; j< p.paperURIs.length; j++){
              if(_uri == p.paperURIs[j]){
                  return p;
              }
          }
      }
      return 0;
  }
  
  
   
   function getPaperfaxID(string memory _uri) public view returns(uint _ans){
      for(uint i= 0; i<paperfaxes.length; i++){
          Paperfax memory p = paperfaxes[i];
          for(uint j = 0; j< p.paperURIs.length; j++){
              if(_uri == p.paperURIs[j]){
                  return j;
              }
          }
      }
      return 0;
  }
  
  
  function getPaperfaxIndex() external view returns(Paperfax[] memory _index){
      return paperfaxes;
  }
 */

    // other external functions
    // stretch: how to handle minds changing? retract/respond/edit/addendum?

    // ERC-1155 functions?
}
