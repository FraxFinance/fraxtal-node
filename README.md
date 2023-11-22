# Fraxchain node

This repo contains all the files required to start a fraxchain node.

### Usage

1. Copy the env file of the network you want to start removing the `.SAMPLE` suffyx (e.g. from `.env.testnet.SAMPLE` to `.env.testnet`)
2. Edit the resulting file as needed (in this case `.env.testnet`)
3. Run the netork-specific compose file:

```
docker compose -f testnet.docker-compose.yml up
```

### Cleanup

Delete the \<network>/data folder (e.g. `testnet/data`) which contains all the stored chain data.
