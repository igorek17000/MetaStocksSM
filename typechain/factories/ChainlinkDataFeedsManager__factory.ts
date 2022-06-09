/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  ChainlinkDataFeedsManager,
  ChainlinkDataFeedsManagerInterface,
} from "../ChainlinkDataFeedsManager";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_priceFeedAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
      {
        internalType: "contract IUniswapV2Router02",
        name: "dexRouter",
        type: "address",
      },
    ],
    name: "getAmountOutUSD",
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
    name: "getAvaxPriceInUsd",
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
    name: "getLatestPriceFromChainlink",
    outputs: [
      {
        internalType: "int256",
        name: "",
        type: "int256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_tokenAddress",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
      {
        internalType: "contract IUniswapV2Router02",
        name: "dexRouter",
        type: "address",
      },
    ],
    name: "getTokensValueInUSD",
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
];

const _bytecode =
  "0x608060405234801561001057600080fd5b5060405161080b38038061080b83398101604081905261002f91610054565b600080546001600160a01b0319166001600160a01b0392909216919091179055610084565b60006020828403121561006657600080fd5b81516001600160a01b038116811461007d57600080fd5b9392505050565b610778806100936000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c8063750c907d14610051578063b5acc91114610076578063e3c51fd71461007e578063f20a7cd414610086575b600080fd5b61006461005f3660046104b9565b610099565b60405190815260200160405180910390f35b610064610252565b6100646102cb565b6100646100943660046104fb565b6102e9565b6000806100a4610252565b6100b3906402540be40061052b565b604080516002808252606082018352929350600092909160208301908036833701905050905085816000815181106100ed576100ed61056e565b60200260200101906001600160a01b031690816001600160a01b031681525050836001600160a01b031663ad5c46486040518163ffffffff1660e01b8152600401602060405180830381865afa15801561014b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061016f9190610584565b816001815181106101825761018261056e565b6001600160a01b03928316602091820292909201015260405163d06ca61f60e01b815260009186169063d06ca61f906101c190899086906004016105a8565b600060405180830381865afa1580156101de573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f1916820160405261020691908101906105ff565b905060008160018151811061021d5761021d61056e565b60200260200101519050670de0b6b3a7640000818561023c919061052b565b61024691906106b1565b98975050505050505050565b6000805460408051633fabe5a360e21b8152905183926001600160a01b03169163feaf968c9160048083019260a09291908290030181865afa15801561029c573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102c091906106f2565b509195945050505050565b60006102d5610252565b6102e4906402540be40061052b565b905090565b6000806102f4610252565b610303906402540be40061052b565b6040805160028082526060820183529293506000929091602083019080368337019050509050308160008151811061033d5761033d61056e565b60200260200101906001600160a01b031690816001600160a01b031681525050836001600160a01b031663ad5c46486040518163ffffffff1660e01b8152600401602060405180830381865afa15801561039b573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906103bf9190610584565b816001815181106103d2576103d261056e565b6001600160a01b03928316602091820292909201015260405163d06ca61f60e01b815260009186169063d06ca61f9061041190899086906004016105a8565b600060405180830381865afa15801561042e573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f1916820160405261045691908101906105ff565b905060008160018151811061046d5761046d61056e565b60200260200101519050670de0b6b3a7640000818561048c919061052b565b61049691906106b1565b979650505050505050565b6001600160a01b03811681146104b657600080fd5b50565b6000806000606084860312156104ce57600080fd5b83356104d9816104a1565b92506020840135915060408401356104f0816104a1565b809150509250925092565b6000806040838503121561050e57600080fd5b823591506020830135610520816104a1565b809150509250929050565b600081600019048311821515161561055357634e487b7160e01b600052601160045260246000fd5b500290565b634e487b7160e01b600052604160045260246000fd5b634e487b7160e01b600052603260045260246000fd5b60006020828403121561059657600080fd5b81516105a1816104a1565b9392505050565b6000604082018483526020604081850152818551808452606086019150828701935060005b818110156105f25784516001600160a01b0316835293830193918301916001016105cd565b5090979650505050505050565b6000602080838503121561061257600080fd5b825167ffffffffffffffff8082111561062a57600080fd5b818501915085601f83011261063e57600080fd5b81518181111561065057610650610558565b8060051b604051601f19603f8301168101818110858211171561067557610675610558565b60405291825284820192508381018501918883111561069357600080fd5b938501935b8285101561024657845184529385019392850192610698565b6000826106ce57634e487b7160e01b600052601260045260246000fd5b500490565b805169ffffffffffffffffffff811681146106ed57600080fd5b919050565b600080600080600060a0868803121561070a57600080fd5b610713866106d3565b9450602086015193506040860151925060608601519150610736608087016106d3565b9050929550929590935056fea26469706673582212208c0b194c64819a2610e21059bf2f66e6ff778f03b2539b20d2065173e3a3e3e164736f6c634300080e0033";

export class ChainlinkDataFeedsManager__factory extends ContractFactory {
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
    _priceFeedAddress: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ChainlinkDataFeedsManager> {
    return super.deploy(
      _priceFeedAddress,
      overrides || {}
    ) as Promise<ChainlinkDataFeedsManager>;
  }
  getDeployTransaction(
    _priceFeedAddress: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(_priceFeedAddress, overrides || {});
  }
  attach(address: string): ChainlinkDataFeedsManager {
    return super.attach(address) as ChainlinkDataFeedsManager;
  }
  connect(signer: Signer): ChainlinkDataFeedsManager__factory {
    return super.connect(signer) as ChainlinkDataFeedsManager__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ChainlinkDataFeedsManagerInterface {
    return new utils.Interface(_abi) as ChainlinkDataFeedsManagerInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ChainlinkDataFeedsManager {
    return new Contract(
      address,
      _abi,
      signerOrProvider
    ) as ChainlinkDataFeedsManager;
  }
}