/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  MetaStocksFranchiseShareManager,
  MetaStocksFranchiseShareManagerInterface,
} from "../MetaStocksFranchiseShareManager";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Approval",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint8",
        name: "version",
        type: "uint8",
      },
    ],
    name: "Initialized",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "previousOwner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "OwnershipTransferred",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Transfer",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
    ],
    name: "allowance",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "approve",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "balanceOf",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "create",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "companyAddress",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "id",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "createMetaStocksFranchise",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "decimals",
    outputs: [
      {
        internalType: "uint8",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "subtractedValue",
        type: "uint256",
      },
    ],
    name: "decreaseAllowance",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "getCreateFranchisePrice",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getFranchiseDailyEarnings",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getFranchiseValue",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getMaintainceFranchiseExpenses",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getPaymentTokenAddress",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getUnclaimedRewards",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "addedValue",
        type: "uint256",
      },
    ],
    name: "increaseAllowance",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_metaStocksCompanyAddress",
        type: "address",
      },
    ],
    name: "initialize",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "name",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "companyId",
        type: "uint256",
      },
    ],
    name: "remove",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint16",
        name: "_createFranchisePrice",
        type: "uint16",
      },
    ],
    name: "setCreateFranchisePrice",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint16",
        name: "_franchiseDailyEarnings",
        type: "uint16",
      },
    ],
    name: "setFranchiseDailyEarnings",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint16",
        name: "_maintainceFranchiseExpenses",
        type: "uint16",
      },
    ],
    name: "setMaintainceFranchiseExpenses",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_paymentTokenAddress",
        type: "address",
      },
    ],
    name: "setPaymentTokenAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_paymentTokenAddress",
        type: "address",
      },
    ],
    name: "setPaymentTokenAddress222",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "symbol",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "totalSupply",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transfer",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transferFrom",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "transferOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "managerId",
        type: "uint256",
      },
    ],
    name: "update",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b50611916806100206000396000f3fe60806040526004361061018d5760003560e01c80638da5cb5b116100d7578063be154d2b11610085578063be154d2b1461041e578063c36f6e2414610442578063c4d66de814610462578063dcb98f7e146102d6578063dd62ed3e14610482578063dea182c1146104a2578063efc81a8c14610265578063f2fde38b146104c057600080fd5b80638da5cb5b1461035e57806395d89b41146103905780639d58f3e0146101ed5780639e201466146103a55780639f2e747f146103c9578063a457c2d7146103de578063a9059cbb146103fe57600080fd5b8063313ce5671161013f578063313ce5671461027c578063395093511461029857806344716080146101ed5780634cc82215146102b85780636188389c146102d657806370a0823114610313578063715018a61461034957806382ab890a146102b857600080fd5b806306fdde0314610192578063095ea7b3146101bd57806316230257146101ed57806318160ddd1461020c57806323b872dd146102215780632a5bb068146102415780632c602e5b14610267575b600080fd5b34801561019e57600080fd5b506101a76104e0565b6040516101b49190610d80565b60405180910390f35b3480156101c957600080fd5b506101dd6101d8366004610dec565b610572565b60405190151581526020016101b4565b3480156101f957600080fd5b50609b545b6040519081526020016101b4565b34801561021857600080fd5b506035546101fe565b34801561022d57600080fd5b506101dd61023c366004610e16565b61058a565b34801561024d57600080fd5b5061026561025c366004610e52565b61ffff16609a55565b005b34801561027357600080fd5b506099546101fe565b34801561028857600080fd5b50604051601281526020016101b4565b3480156102a457600080fd5b506101dd6102b3366004610dec565b6105ae565b3480156102c457600080fd5b506102656102d3366004610e7d565b50565b3480156102e257600080fd5b506102656102f1366004610e96565b609c80546001600160a01b0319166001600160a01b0392909216919091179055565b34801561031f57600080fd5b506101fe61032e366004610e96565b6001600160a01b031660009081526033602052604090205490565b34801561035557600080fd5b506102656105d0565b34801561036a57600080fd5b506065546001600160a01b03165b6040516001600160a01b0390911681526020016101b4565b34801561039c57600080fd5b506101a761060f565b3480156103b157600080fd5b506102656103c0366004610e52565b61ffff16609b55565b3480156103d557600080fd5b50609a546101fe565b3480156103ea57600080fd5b506101dd6103f9366004610dec565b61061e565b34801561040a57600080fd5b506101dd610419366004610dec565b610699565b34801561042a57600080fd5b50610265610439366004610e52565b61ffff16609955565b34801561044e57600080fd5b5061026561045d366004610ec7565b6106a7565b34801561046e57600080fd5b5061026561047d366004610e96565b61075a565b34801561048e57600080fd5b506101fe61049d366004610f92565b61086b565b3480156104ae57600080fd5b50609c546001600160a01b0316610378565b3480156104cc57600080fd5b506102656104db366004610e96565b610896565b6060603680546104ef90610fc5565b80601f016020809104026020016040519081016040528092919081815260200182805461051b90610fc5565b80156105685780601f1061053d57610100808354040283529160200191610568565b820191906000526020600020905b81548152906001019060200180831161054b57829003601f168201915b5050505050905090565b60003361058081858561092e565b5060019392505050565b600033610598858285610a52565b6105a3858585610ac6565b506001949350505050565b6000336105808185856105c1838361086b565b6105cb9190610fff565b61092e565b6065546001600160a01b031633146106035760405162461bcd60e51b81526004016105fa90611025565b60405180910390fd5b61060d6000610c94565b565b6060603780546104ef90610fc5565b6000338161062c828661086b565b90508381101561068c5760405162461bcd60e51b815260206004820152602560248201527f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f77604482015264207a65726f60d81b60648201526084016105fa565b6105a3828686840361092e565b600033610580818585610ac6565b6065546001600160a01b031633146106d15760405162461bcd60e51b81526004016105fa90611025565b609c546040516323b872dd60e01b81523360048201526001600160a01b0390911660248201819052678ac7230489e800006044830152906323b872dd906064016020604051808303816000875af1158015610730573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610754919061105a565b50505050565b60006107666001610ce6565b9050801561077e576000805461ff0019166101001790555b678ac7230489e80000609955670de0b6b3a7640000609a5567016345785d8a0000609b55609c80546001600160a01b0319169055604051730a77230d17318075983913bc2145db16c7366156906107d490610d73565b6001600160a01b039091168152602001604051809103906000f080158015610800573d6000803e3d6000fd5b50609880546001600160a01b0319166001600160a01b03929092169190911790558015610867576000805461ff0019169055604051600181527f7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb38474024989060200160405180910390a15b5050565b6001600160a01b03918216600090815260346020908152604080832093909416825291909152205490565b6065546001600160a01b031633146108c05760405162461bcd60e51b81526004016105fa90611025565b6001600160a01b0381166109255760405162461bcd60e51b815260206004820152602660248201527f4f776e61626c653a206e6577206f776e657220697320746865207a65726f206160448201526564647265737360d01b60648201526084016105fa565b6102d381610c94565b6001600160a01b0383166109905760405162461bcd60e51b8152602060048201526024808201527f45524332303a20617070726f76652066726f6d20746865207a65726f206164646044820152637265737360e01b60648201526084016105fa565b6001600160a01b0382166109f15760405162461bcd60e51b815260206004820152602260248201527f45524332303a20617070726f766520746f20746865207a65726f206164647265604482015261737360f01b60648201526084016105fa565b6001600160a01b0383811660008181526034602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b6000610a5e848461086b565b905060001981146107545781811015610ab95760405162461bcd60e51b815260206004820152601d60248201527f45524332303a20696e73756666696369656e7420616c6c6f77616e636500000060448201526064016105fa565b610754848484840361092e565b6001600160a01b038316610b2a5760405162461bcd60e51b815260206004820152602560248201527f45524332303a207472616e736665722066726f6d20746865207a65726f206164604482015264647265737360d81b60648201526084016105fa565b6001600160a01b038216610b8c5760405162461bcd60e51b815260206004820152602360248201527f45524332303a207472616e7366657220746f20746865207a65726f206164647260448201526265737360e81b60648201526084016105fa565b6001600160a01b03831660009081526033602052604090205481811015610c045760405162461bcd60e51b815260206004820152602660248201527f45524332303a207472616e7366657220616d6f756e7420657863656564732062604482015265616c616e636560d01b60648201526084016105fa565b6001600160a01b03808516600090815260336020526040808220858503905591851681529081208054849290610c3b908490610fff565b92505081905550826001600160a01b0316846001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef84604051610c8791815260200190565b60405180910390a3610754565b606580546001600160a01b038381166001600160a01b0319831681179093556040519116919082907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a35050565b60008054610100900460ff1615610d2d578160ff166001148015610d095750303b155b610d255760405162461bcd60e51b81526004016105fa9061107c565b506000919050565b60005460ff808416911610610d545760405162461bcd60e51b81526004016105fa9061107c565b506000805460ff191660ff92909216919091179055600190565b919050565b610816806110cb83390190565b600060208083528351808285015260005b81811015610dad57858101830151858201604001528201610d91565b81811115610dbf576000604083870101525b50601f01601f1916929092016040019392505050565b80356001600160a01b0381168114610d6e57600080fd5b60008060408385031215610dff57600080fd5b610e0883610dd5565b946020939093013593505050565b600080600060608486031215610e2b57600080fd5b610e3484610dd5565b9250610e4260208501610dd5565b9150604084013590509250925092565b600060208284031215610e6457600080fd5b813561ffff81168114610e7657600080fd5b9392505050565b600060208284031215610e8f57600080fd5b5035919050565b600060208284031215610ea857600080fd5b610e7682610dd5565b634e487b7160e01b600052604160045260246000fd5b600080600060608486031215610edc57600080fd5b610ee584610dd5565b925060208401359150604084013567ffffffffffffffff80821115610f0957600080fd5b818601915086601f830112610f1d57600080fd5b813581811115610f2f57610f2f610eb1565b604051601f8201601f19908116603f01168101908382118183101715610f5757610f57610eb1565b81604052828152896020848701011115610f7057600080fd5b8260208601602083013760006020848301015280955050505050509250925092565b60008060408385031215610fa557600080fd5b610fae83610dd5565b9150610fbc60208401610dd5565b90509250929050565b600181811c90821680610fd957607f821691505b602082108103610ff957634e487b7160e01b600052602260045260246000fd5b50919050565b6000821982111561102057634e487b7160e01b600052601160045260246000fd5b500190565b6020808252818101527f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572604082015260600190565b60006020828403121561106c57600080fd5b81518015158114610e7657600080fd5b6020808252602e908201527f496e697469616c697a61626c653a20636f6e747261637420697320616c72656160408201526d191e481a5b9a5d1a585b1a5e995960921b60608201526080019056fe608060405234801561001057600080fd5b5060405161081638038061081683398101604081905261002f91610054565b600080546001600160a01b0319166001600160a01b0392909216919091179055610084565b60006020828403121561006657600080fd5b81516001600160a01b038116811461007d57600080fd5b9392505050565b610783806100936000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c806307fed6ac14610051578063669a8e341461006b578063b5acc9111461007e578063f20a7cd414610086575b600080fd5b610059610099565b60405190815260200160405180910390f35b6100596100793660046104b0565b6100b7565b610059610267565b6100596100943660046104fa565b6102e0565b60006100a3610267565b6100b2906402540be40061052a565b905090565b6000806100c2610267565b6100d1906402540be40061052a565b6040805160028082526060820183529293506000929091602083019080368337019050509050868160008151811061010b5761010b61056d565b6001600160a01b03928316602091820292909201015260405163ea706d2160e01b8152600481018790529085169063ea706d2190602401602060405180830381865afa15801561015f573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906101839190610583565b816001815181106101965761019661056d565b6001600160a01b03928316602091820292909201015260405163d06ca61f60e01b815260009186169063d06ca61f906101d5908a9086906004016105a7565b600060405180830381865afa1580156101f2573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f1916820160405261021a91908101906105fe565b90506000816001815181106102315761023161056d565b60200260200101519050670de0b6b3a76400008185610250919061052a565b61025a91906106bc565b9998505050505050505050565b6000805460408051633fabe5a360e21b8152905183926001600160a01b03169163feaf968c9160048083019260a09291908290030181865afa1580156102b1573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102d591906106fd565b509195945050505050565b6000806102eb610267565b6102fa906402540be40061052a565b604080516002808252606082018352929350600092909160208301908036833701905050905030816000815181106103345761033461056d565b60200260200101906001600160a01b031690816001600160a01b031681525050836001600160a01b031663ad5c46486040518163ffffffff1660e01b8152600401602060405180830381865afa158015610392573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906103b69190610583565b816001815181106103c9576103c961056d565b6001600160a01b03928316602091820292909201015260405163d06ca61f60e01b815260009186169063d06ca61f9061040890899086906004016105a7565b600060405180830381865afa158015610425573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f1916820160405261044d91908101906105fe565b90506000816001815181106104645761046461056d565b60200260200101519050670de0b6b3a76400008185610483919061052a565b61048d91906106bc565b979650505050505050565b6001600160a01b03811681146104ad57600080fd5b50565b600080600080608085870312156104c657600080fd5b84356104d181610498565b9350602085013592506040850135915060608501356104ef81610498565b939692955090935050565b6000806040838503121561050d57600080fd5b82359150602083013561051f81610498565b809150509250929050565b600081600019048311821515161561055257634e487b7160e01b600052601160045260246000fd5b500290565b634e487b7160e01b600052604160045260246000fd5b634e487b7160e01b600052603260045260246000fd5b60006020828403121561059557600080fd5b81516105a081610498565b9392505050565b6000604082018483526020604081850152818551808452606086019150828701935060005b818110156105f15784516001600160a01b0316835293830193918301916001016105cc565b5090979650505050505050565b6000602080838503121561061157600080fd5b825167ffffffffffffffff8082111561062957600080fd5b818501915085601f83011261063d57600080fd5b81518181111561064f5761064f610557565b8060051b604051601f19603f8301168101818110858211171561067457610674610557565b60405291825284820192508381018501918883111561069257600080fd5b938501935b828510156106b057845184529385019392850192610697565b98975050505050505050565b6000826106d957634e487b7160e01b600052601260045260246000fd5b500490565b805169ffffffffffffffffffff811681146106f857600080fd5b919050565b600080600080600060a0868803121561071557600080fd5b61071e866106de565b9450602086015193506040860151925060608601519150610741608087016106de565b9050929550929590935056fea2646970667358221220bd8ccb4c6941f857b0c6f0dd91e1e3527cc97078f2290e9e251c87b5ab744d1c64736f6c634300080e0033a26469706673582212203f9404e001f96fbee39ce14305c2fa6a683f94a1cb721eec97ebfcecb10d671c64736f6c634300080e0033";

export class MetaStocksFranchiseShareManager__factory extends ContractFactory {
  constructor(
    ...args: [signer: Signer] | ConstructorParameters<typeof ContractFactory>
  ) {
    if (args.length === 1) {
      super(_abi, _bytecode, args[0]);
    } else {
      super(...args);
    }
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<MetaStocksFranchiseShareManager> {
    return super.deploy(
      overrides || {}
    ) as Promise<MetaStocksFranchiseShareManager>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): MetaStocksFranchiseShareManager {
    return super.attach(address) as MetaStocksFranchiseShareManager;
  }
  connect(signer: Signer): MetaStocksFranchiseShareManager__factory {
    return super.connect(signer) as MetaStocksFranchiseShareManager__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MetaStocksFranchiseShareManagerInterface {
    return new utils.Interface(
      _abi
    ) as MetaStocksFranchiseShareManagerInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): MetaStocksFranchiseShareManager {
    return new Contract(
      address,
      _abi,
      signerOrProvider
    ) as MetaStocksFranchiseShareManager;
  }
}