# Fraxtal node

This repo contains all the files required to start a fraxtal node.

### Usage

1. Copy the env file of the network you want to start removing the `.SAMPLE` suffix (e.g. from `.env.testnet.SAMPLE` to `.env.testnet`)
2. Edit the resulting file as needed (in this case `.env.testnet`)
3. Run the netork-specific compose file:

```
docker compose -f testnet.docker-compose.yml up
```

### Cleanup

Delete the \<network>/data folder (e.g. `testnet/data`) which contains all the stored chain data.

### Disclaimer

THE NODE SOFTWARE AND SMART CONTRACTS CONTAINED HEREIN ARE FURNISHED AS IS, WHERE IS, WITH ALL FAULTS AND WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTY OF MERCHANTABILITY, NON- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE. IN PARTICULAR, THERE IS NO REPRESENTATION OR WARRANTY THAT THE NODE SOFTWARE AND SMART CONTRACTS WILL PROTECT YOUR ASSETS — OR THE ASSETS OF THE USERS OF YOUR APPLICATION — FROM THEFT, HACKING, CYBER ATTACK, OR OTHER FORM OF LOSS OR DEVALUATION.

You also understand that using the node software and smart contracts are subject to applicable law, including without limitation, any applicable anti-money laundering laws, anti-terrorism laws, export control laws, end user restrictions, privacy laws, or economic sanctions laws/regulations.
