// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract CertificateRegistry {
 struct Certificate { bytes32 documentHash; address issuer; uint64 issuedAt; uint64 expiresAt; bool revoked; }
 mapping(bytes32=>Certificate) public certificates; mapping(address=>bool) public authorizedIssuers; address public owner;
 modifier onlyOwner(){require(msg.sender==owner,"not owner");_;} modifier onlyIssuer(){require(authorizedIssuers[msg.sender],"not issuer");_;}
 event CertificateRegistered(bytes32 indexed id,bytes32 hash,address indexed issuer); event CertificateRevoked(bytes32 indexed id);
 constructor(){owner=msg.sender;authorizedIssuers[msg.sender]=true;}
 function authorizeIssuer(address account) external onlyOwner { authorizedIssuers[account]=true; }
 function registerCertificate(bytes32 id,bytes32 hash,string calldata,uint64 expiresAt) external onlyIssuer { require(certificates[id].issuedAt==0,"exists"); certificates[id]=Certificate(hash,msg.sender,uint64(block.timestamp),expiresAt,false); emit CertificateRegistered(id,hash,msg.sender); }
 function revokeCertificate(bytes32 id) external { require(certificates[id].issuer==msg.sender,"only issuer"); certificates[id].revoked=true; emit CertificateRevoked(id); }
 function verifyCertificate(bytes32 id,bytes32 hash) external view returns(bool,address,uint256,uint256,bool) { Certificate memory c=certificates[id]; bool active=c.issuedAt!=0&&!c.revoked&&(c.expiresAt==0||block.timestamp<=c.expiresAt); return(active&&c.documentHash==hash,c.issuer,c.issuedAt,c.expiresAt,c.revoked); }
}
