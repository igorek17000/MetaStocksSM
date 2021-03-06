/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  DividendPayingToken,
  DividendPayingTokenInterface,
} from "../DividendPayingToken";

const _abi = [
  {
    inputs: [
      {
        internalType: "string",
        name: "_name",
        type: "string",
      },
      {
        internalType: "string",
        name: "_symbol",
        type: "string",
      },
      {
        internalType: "address",
        name: "_distributionTokenAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
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
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "weiAmount",
        type: "uint256",
      },
    ],
    name: "DividendWithdrawn",
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
        indexed: false,
        internalType: "uint256",
        name: "weiAmount",
        type: "uint256",
      },
    ],
    name: "DividendsDistributed",
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
        name: "_owner",
        type: "address",
      },
    ],
    name: "accumulativeDividendOf",
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
    name: "distributeDividends",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "distributeTokensDividends",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_owner",
        type: "address",
      },
    ],
    name: "dividendOf",
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
    name: "totalDividendsDistributed",
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
    inputs: [],
    name: "withdrawDividend",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_owner",
        type: "address",
      },
    ],
    name: "withdrawableDividendOf",
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
        name: "_owner",
        type: "address",
      },
    ],
    name: "withdrawnDividendOf",
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
    stateMutability: "payable",
    type: "receive",
  },
];

const _bytecode =
  "0x60806040523480156200001157600080fd5b506040516200110038038062001100833981016040819052620000349162000203565b8251839083906200004d90600390602085019062000090565b5080516200006390600490602084019062000090565b5050600780546001600160a01b0319166001600160a01b03939093169290921790915550620002cc915050565b8280546200009e9062000290565b90600052602060002090601f016020900481019282620000c257600085556200010d565b82601f10620000dd57805160ff19168380011785556200010d565b828001600101855582156200010d579182015b828111156200010d578251825591602001919060010190620000f0565b506200011b9291506200011f565b5090565b5b808211156200011b576000815560010162000120565b634e487b7160e01b600052604160045260246000fd5b600082601f8301126200015e57600080fd5b81516001600160401b03808211156200017b576200017b62000136565b604051601f8301601f19908116603f01168101908282118183101715620001a657620001a662000136565b81604052838152602092508683858801011115620001c357600080fd5b600091505b83821015620001e75785820183015181830184015290820190620001c8565b83821115620001f95760008385830101525b9695505050505050565b6000806000606084860312156200021957600080fd5b83516001600160401b03808211156200023157600080fd5b6200023f878388016200014c565b945060208601519150808211156200025657600080fd5b5062000265868287016200014c565b604086015190935090506001600160a01b03811681146200028557600080fd5b809150509250925092565b600181811c90821680620002a557607f821691505b602082108103620002c657634e487b7160e01b600052602260045260246000fd5b50919050565b610e2480620002dc6000396000f3fe6080604052600436106101085760003560e01c806370a08231116100a0578063a8b9d24011610064578063a8b9d240146102ca578063a9059cbb146102ea578063aafd847a1461030a578063d16f7e1414610340578063dd62ed3e1461036057600080fd5b806370a082311461022957806385a6b3ae1461025f57806391b89fba1461027557806395d89b4114610295578063a457c2d7146102aa57600080fd5b806303c833021461011457806306fdde031461011e578063095ea7b31461014957806318160ddd1461017957806323b872dd1461019857806327ce0147146101b8578063313ce567146101d857806339509351146101f45780636a4740021461021457600080fd5b3661010f57005b600080fd5b61011c610380565b005b34801561012a57600080fd5b50610133610413565b6040516101409190610b8d565b60405180910390f35b34801561015557600080fd5b50610169610164366004610bfe565b6104a5565b6040519015158152602001610140565b34801561018557600080fd5b506002545b604051908152602001610140565b3480156101a457600080fd5b506101696101b3366004610c28565b6104bf565b3480156101c457600080fd5b5061018a6101d3366004610c64565b6104e0565b3480156101e457600080fd5b5060405160128152602001610140565b34801561020057600080fd5b5061016961020f366004610bfe565b61053c565b34801561022057600080fd5b5061011c61055e565b34801561023557600080fd5b5061018a610244366004610c64565b6001600160a01b031660009081526020819052604090205490565b34801561026b57600080fd5b5061018a600a5481565b34801561028157600080fd5b5061018a610290366004610c64565b61056a565b3480156102a157600080fd5b50610133610575565b3480156102b657600080fd5b506101696102c5366004610bfe565b610584565b3480156102d657600080fd5b5061018a6102e5366004610c64565b610604565b3480156102f657600080fd5b50610169610305366004610bfe565b610630565b34801561031657600080fd5b5061018a610325366004610c64565b6001600160a01b031660009081526009602052604090205490565b34801561034c57600080fd5b5061011c61035b366004610c7f565b61063a565b34801561036c57600080fd5b5061018a61037b366004610c98565b6106ba565b600061038b60025490565b1161039557600080fd5b3415610411576103c86103a760025490565b6103b534600160801b6106e5565b6103bf9190610ce1565b6005549061076e565b60055560405134815233907fa493a9229478c3fcd73f66d2cdeb7f94fd0f341da924d1054236d784541165119060200160405180910390a2600a5461040d903461076e565b600a555b565b60606003805461042290610d03565b80601f016020809104026020016040519081016040528092919081815260200182805461044e90610d03565b801561049b5780601f106104705761010080835404028352916020019161049b565b820191906000526020600020905b81548152906001019060200180831161047e57829003601f168201915b5050505050905090565b6000336104b38185856107cd565b60019150505b92915050565b6000336104cd8582856108f1565b6104d5600080fd5b506001949350505050565b6001600160a01b03811660009081526008602090815260408083205491839052822054600554600160801b926105329261052d926105279161052291906106e5565b61096b565b9061097b565b6109b9565b6104b99190610ce1565b6000336104b381858561054f83836106ba565b6105599190610d3d565b6107cd565b610567336109cc565b50565b60006104b982610604565b60606004805461042290610d03565b6000338161059282866106ba565b9050838110156105f75760405162461bcd60e51b815260206004820152602560248201527f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f77604482015264207a65726f60d81b60648201526084015b60405180910390fd5b6104d582868684036107cd565b6001600160a01b0381166000908152600960205260408120546104b99061062a846104e0565b90610b31565b6000336104b38280fd5b600061064560025490565b1161064f57600080fd5b80156105675761066f61066160025490565b6103b583600160801b6106e5565b60055560405181815233907fa493a9229478c3fcd73f66d2cdeb7f94fd0f341da924d1054236d784541165119060200160405180910390a2600a546106b4908261076e565b600a5550565b6001600160a01b03918216600090815260016020908152604080832093909416825291909152205490565b6000826000036106f7575060006104b9565b60006107038385610d55565b9050826107108583610ce1565b146107675760405162461bcd60e51b815260206004820152602160248201527f536166654d6174683a206d756c7469706c69636174696f6e206f766572666c6f6044820152607760f81b60648201526084016105ee565b9392505050565b60008061077b8385610d3d565b9050838110156107675760405162461bcd60e51b815260206004820152601b60248201527f536166654d6174683a206164646974696f6e206f766572666c6f77000000000060448201526064016105ee565b6001600160a01b03831661082f5760405162461bcd60e51b8152602060048201526024808201527f45524332303a20617070726f76652066726f6d20746865207a65726f206164646044820152637265737360e01b60648201526084016105ee565b6001600160a01b0382166108905760405162461bcd60e51b815260206004820152602260248201527f45524332303a20617070726f766520746f20746865207a65726f206164647265604482015261737360f01b60648201526084016105ee565b6001600160a01b0383811660008181526001602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b60006108fd84846106ba565b9050600019811461096557818110156109585760405162461bcd60e51b815260206004820152601d60248201527f45524332303a20696e73756666696369656e7420616c6c6f77616e636500000060448201526064016105ee565b61096584848484036107cd565b50505050565b600081818112156104b957600080fd5b6000806109888385610d74565b90506000831215801561099b5750838112155b806109b057506000831280156109b057508381125b61076757600080fd5b6000808212156109c857600080fd5b5090565b6000806109d883610604565b90508015610b28576001600160a01b038316600090815260096020526040902054610a03908261076e565b6001600160a01b038416600081815260096020526040908190209290925590517fee503bee2bb6a87e57bc57db795f98137327401a0e7b7ce42e37926cc1a9ca4d90610a529084815260200190565b60405180910390a260075460405163a9059cbb60e01b81526001600160a01b03858116600483015260248201849052600092169063a9059cbb906044016020604051808303816000875af1158015610aae573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610ad29190610db5565b905080610b21576001600160a01b038416600090815260096020526040902054610afc9083610b31565b6001600160a01b03909416600090815260096020526040812094909455509192915050565b5092915050565b50600092915050565b600082821115610b835760405162461bcd60e51b815260206004820152601e60248201527f536166654d6174683a207375627472616374696f6e206f766572666c6f77000060448201526064016105ee565b6107678284610dd7565b600060208083528351808285015260005b81811015610bba57858101830151858201604001528201610b9e565b81811115610bcc576000604083870101525b50601f01601f1916929092016040019392505050565b80356001600160a01b0381168114610bf957600080fd5b919050565b60008060408385031215610c1157600080fd5b610c1a83610be2565b946020939093013593505050565b600080600060608486031215610c3d57600080fd5b610c4684610be2565b9250610c5460208501610be2565b9150604084013590509250925092565b600060208284031215610c7657600080fd5b61076782610be2565b600060208284031215610c9157600080fd5b5035919050565b60008060408385031215610cab57600080fd5b610cb483610be2565b9150610cc260208401610be2565b90509250929050565b634e487b7160e01b600052601160045260246000fd5b600082610cfe57634e487b7160e01b600052601260045260246000fd5b500490565b600181811c90821680610d1757607f821691505b602082108103610d3757634e487b7160e01b600052602260045260246000fd5b50919050565b60008219821115610d5057610d50610ccb565b500190565b6000816000190483118215151615610d6f57610d6f610ccb565b500290565b600080821280156001600160ff1b0384900385131615610d9657610d96610ccb565b600160ff1b8390038412811615610daf57610daf610ccb565b50500190565b600060208284031215610dc757600080fd5b8151801515811461076757600080fd5b600082821015610de957610de9610ccb565b50039056fea26469706673582212205ed2e05b305e138e13956e76441533019243714248735d75ca696fdf3187dcee64736f6c634300080e0033";

export class DividendPayingToken__factory extends ContractFactory {
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
    _name: string,
    _symbol: string,
    _distributionTokenAddress: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<DividendPayingToken> {
    return super.deploy(
      _name,
      _symbol,
      _distributionTokenAddress,
      overrides || {}
    ) as Promise<DividendPayingToken>;
  }
  getDeployTransaction(
    _name: string,
    _symbol: string,
    _distributionTokenAddress: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(
      _name,
      _symbol,
      _distributionTokenAddress,
      overrides || {}
    );
  }
  attach(address: string): DividendPayingToken {
    return super.attach(address) as DividendPayingToken;
  }
  connect(signer: Signer): DividendPayingToken__factory {
    return super.connect(signer) as DividendPayingToken__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): DividendPayingTokenInterface {
    return new utils.Interface(_abi) as DividendPayingTokenInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): DividendPayingToken {
    return new Contract(address, _abi, signerOrProvider) as DividendPayingToken;
  }
}
