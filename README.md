# Decentralized Certificate Verification

Full-stack starter with a responsive UI, Express backend, SHA-256 hashing, demo mode, and an optional Solidity blockchain registry.

## Run

```bash
npm install
cp .env.example .env
npm start
```

Open http://localhost:4000. Empty blockchain settings intentionally use demo mode with an in-memory registry.

## Blockchain mode

Deploy `contracts/CertificateRegistry.sol` to an EVM network and set `RPC_URL`, `ISSUER_PRIVATE_KEY`, and `CONTRACT_ADDRESS` in `.env`. Never commit private keys or real documents. Only document hashes should be stored on-chain.

API: `POST /api/certificates`, `POST /api/verify`, `POST /api/certificates/:id/revoke`, and `GET /api/health`.
