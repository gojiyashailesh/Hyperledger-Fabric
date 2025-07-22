.
├── api/                  # Backend or REST APIs (likely FastAPI or Node)
├── bin/                  # Fabric binaries (peer, orderer, configtxgen, etc.)
├── ca/                   # Fabric CA server/client config & folders
├── chaincode/            # Chaincode (smart contracts) written in Go/Node
├── channel-artifacts/    # Generated channel block files (genesis, channel.tx, etc.)
├── configtx/             # configtx.yaml (could support both solo & raft)
├── cryptogen/            # crypto-config.yaml for cryptogen identities
├── docker/               # Modular docker-compose fragments or base images
├── docker-compose.yaml   # Top-level orchestrator
├── docs/                 # Documentation
├── filestructure.txt     # This tree output / folder design doc
├── orderer/              # Orderer volume files, MSPs, TLS, logs
├── peer/                 # Peer volume files, MSPs, TLS, logs
├── README.md
├── scripts/              # Network automation, CLI tooling
└── setup/                # Central task-based orchestrator (solo, raft, ca, cryptogen)