// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

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
    // Store paperURIs as single string, e.g. "https://arxiv.org/x,ipfs://hash"
    // make sure to URL encode the URIs so they don't have commas
    // https://stackoverflow.com/questions/42716858/string-array-in-solidity
    string paperURIs;
    uint[] auditIds;
    address[] requestedBy;
  }

  Paperfax[] paperfaxes;
  Audit[] audits;
  mapping (address => uint[]) public auditIdsByUser;

  constructor() {}

  function initializePaperfax(string memory _paperURIs) external {
  }

  function requestAudit(uint _paperfaxId) external {
  }

  function createAudit(uint _paperfaxId) external {
  }

  function upvoteAudit(uint _auditId) external { // stretch?
    // remove existing vote first
  }

  // other external functions
  // stretch: how to handle minds changing? retract/respond/edit/addendum?

  // ERC-1155 functions?
}
