## 1. Install dependences

Before running any command, make sure to install dependencies:

```sh
npm install
```

## 2. Run localnode

Before running any command, make sure to install dependencies:

```sh
npx hardhat node --fork https://speedy-nodes-nyc.moralis.io/aaf5f27c6c7a9ad182a69ccd/bsc/testnet/archive
```

## 2. Run tests
```sh
npx hardhat test  --network localhost 

npx hardhat test test/MetaStocks.test.ts --network localhost

```