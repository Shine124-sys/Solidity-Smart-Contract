1️⃣ DUIS (Digital Unique ID System) — README.md
Overview

DUIS is a blockchain-based Digital Unique ID System for issuing tamper-proof, self-sovereign digital identities.
Each ID is uniquely linked to a controller wallet and off-chain metadata (IPFS/Arweave).

Features

Unique on-chain ID issuance

Controller-based management

Metadata storage via IPFS/Arweave

Verifiable attestations from third-party authorities

Optional guardian recovery for lost keys

Architecture

Smart contract: DUISRegistry.sol

Frontend: React / Next.js

Storage: IPFS/Arweave for personal data

Key Functions

createID(bytes32 uid, string metadataCID) — register ID

updateMetadata(bytes32 uid, string newMetadataCID) — update user data

changeController(bytes32 uid, address newController) — rotate key

verifyID(bytes32 uid) — third-party verification

getIdentity(bytes32 uid) — fetch identity info

Deployment

Compile & deploy with Hardhat:

npx hardhat compile
npx hardhat run scripts/deploy.js --network <network>


Frontend connects via Ethers.js and MetaMask.

Security & Privacy

Off-chain storage for sensitive info

Controller-only updates

Guardians for recovery

Optional zero-knowledge attestations

2️⃣ Land Registry — README.md
Overview

A blockchain-based Land Registry allowing land parcels to be registered, tracked, and transferred securely.
Ownership is linked to DUIS (Digital Unique ID System) for identity verification.

Features

Register parcels with unique IDs

Link parcel → DUIS owner

Store document hashes (IPFS)

Ownership transfer with DUIS verification

Role-based access control for registrars

Architecture

Smart contracts: LandRegistry.sol

Identity integration: DUISRegistry.sol

Off-chain storage: IPFS for deeds and legal docs

Key Functions

registerParcel(bytes32 parcelId, string ipfsDocCID, string ownerDID)

transferParcel(bytes32 parcelId, string newOwnerDID)

authorizeTransfer(bytes32 parcelId, bytes signature)

getParcel(bytes32 parcelId) — returns parcel info

Deployment

Deploy DUISRegistry.sol first

Deploy LandRegistry.sol with DUISRegistry address

Interact via React frontend or scripts

Security

Only registrar can register parcels

Ownership transfers validated via DUIS signatures

Sensitive documents stored off-chain

3️⃣ Lottery — README.md
Overview

A simple payable lottery contract demonstrating secure fund handling and randomness.
Can integrate DUIS to restrict entries to verified users.

Features

Entry via ETH payment

Random winner selection (placeholder pseudo-random for testing; VRF recommended)

On-chain prize payout

Optional DUIS verification for participants

Architecture

Smart contract: Lottery.sol

Frontend: React / Next.js

Optional randomness: Chainlink VRF for production

Key Functions

enter() — enter lottery by sending ETH

drawWinner() — pick a winner (admin only)

getEntries() — view participants

Deployment
npx hardhat compile
npx hardhat run scripts/deploy.js --network <network>

Security

Use Chainlink VRF for fair randomness

Restrict drawWinner to trusted account or DAO

Avoid storing sensitive data