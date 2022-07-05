/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { ethers } from "ethers";
import {
  FactoryOptions,
  HardhatEthersHelpers as HardhatEthersHelpersBase,
} from "@nomiclabs/hardhat-ethers/types";

import * as Contracts from ".";

declare module "hardhat/types/runtime" {
  interface HardhatEthersHelpers extends HardhatEthersHelpersBase {
    getContractFactory(
      name: "AggregatorV3Interface",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.AggregatorV3Interface__factory>;
    getContractFactory(
      name: "VRFCoordinatorV2Interface",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.VRFCoordinatorV2Interface__factory>;
    getContractFactory(
      name: "OwnableUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.OwnableUpgradeable__factory>;
    getContractFactory(
      name: "Initializable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Initializable__factory>;
    getContractFactory(
      name: "PausableUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PausableUpgradeable__factory>;
    getContractFactory(
      name: "ERC1155Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC1155Upgradeable__factory>;
    getContractFactory(
      name: "ERC1155BurnableUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC1155BurnableUpgradeable__factory>;
    getContractFactory(
      name: "ERC1155SupplyUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC1155SupplyUpgradeable__factory>;
    getContractFactory(
      name: "IERC1155MetadataURIUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC1155MetadataURIUpgradeable__factory>;
    getContractFactory(
      name: "IERC1155ReceiverUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC1155ReceiverUpgradeable__factory>;
    getContractFactory(
      name: "IERC1155Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC1155Upgradeable__factory>;
    getContractFactory(
      name: "ERC20Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC20Upgradeable__factory>;
    getContractFactory(
      name: "IERC20MetadataUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20MetadataUpgradeable__factory>;
    getContractFactory(
      name: "IERC20Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20Upgradeable__factory>;
    getContractFactory(
      name: "ERC721Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC721Upgradeable__factory>;
    getContractFactory(
      name: "ERC721URIStorageUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC721URIStorageUpgradeable__factory>;
    getContractFactory(
      name: "IERC721MetadataUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721MetadataUpgradeable__factory>;
    getContractFactory(
      name: "IERC721ReceiverUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721ReceiverUpgradeable__factory>;
    getContractFactory(
      name: "IERC721Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721Upgradeable__factory>;
    getContractFactory(
      name: "ContextUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ContextUpgradeable__factory>;
    getContractFactory(
      name: "ERC165Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC165Upgradeable__factory>;
    getContractFactory(
      name: "IERC165Upgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC165Upgradeable__factory>;
    getContractFactory(
      name: "Ownable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Ownable__factory>;
    getContractFactory(
      name: "IERC1155Receiver",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC1155Receiver__factory>;
    getContractFactory(
      name: "ERC1155Holder",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC1155Holder__factory>;
    getContractFactory(
      name: "ERC1155Receiver",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC1155Receiver__factory>;
    getContractFactory(
      name: "ERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC20__factory>;
    getContractFactory(
      name: "IERC20Metadata",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20Metadata__factory>;
    getContractFactory(
      name: "IERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20__factory>;
    getContractFactory(
      name: "ERC165",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC165__factory>;
    getContractFactory(
      name: "IERC165",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC165__factory>;
    getContractFactory(
      name: "IUniswapV2Factory",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IUniswapV2Factory__factory>;
    getContractFactory(
      name: "IUniswapV2Router01",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IUniswapV2Router01__factory>;
    getContractFactory(
      name: "IUniswapV2Router02",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IUniswapV2Router02__factory>;
    getContractFactory(
      name: "BEP20Token",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.BEP20Token__factory>;
    getContractFactory(
      name: "Context",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Context__factory>;
    getContractFactory(
      name: "IBEP20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IBEP20__factory>;
    getContractFactory(
      name: "Ownable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Ownable__factory>;
    getContractFactory(
      name: "IERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20__factory>;
    getContractFactory(
      name: "IPancakeCallee",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeCallee__factory>;
    getContractFactory(
      name: "IPancakeERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeERC20__factory>;
    getContractFactory(
      name: "IPancakeFactory",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeFactory__factory>;
    getContractFactory(
      name: "IPancakePair",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakePair__factory>;
    getContractFactory(
      name: "PancakeERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PancakeERC20__factory>;
    getContractFactory(
      name: "PancakeFactory",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PancakeFactory__factory>;
    getContractFactory(
      name: "PancakePair",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PancakePair__factory>;
    getContractFactory(
      name: "IERC20",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC20__factory>;
    getContractFactory(
      name: "IPancakeFactory",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeFactory__factory>;
    getContractFactory(
      name: "IPancakePair",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakePair__factory>;
    getContractFactory(
      name: "IPancakeRouter01",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeRouter01__factory>;
    getContractFactory(
      name: "IPancakeRouter02",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPancakeRouter02__factory>;
    getContractFactory(
      name: "IWETH",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IWETH__factory>;
    getContractFactory(
      name: "PancakeRouter",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PancakeRouter__factory>;
    getContractFactory(
      name: "WBNB",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.WBNB__factory>;
    getContractFactory(
      name: "IAutoLiquidityInjecter",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IAutoLiquidityInjecter__factory>;
    getContractFactory(
      name: "IJoeRouter01",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IJoeRouter01__factory>;
    getContractFactory(
      name: "IJoeRouter02",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IJoeRouter02__factory>;
    getContractFactory(
      name: "IPangolinRouter",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IPangolinRouter__factory>;
    getContractFactory(
      name: "IMetaStocksBaseManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksBaseManager__factory>;
    getContractFactory(
      name: "IMetaStocksCompany",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksCompany__factory>;
    getContractFactory(
      name: "IMetaStocksCompanyInfo",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksCompanyInfo__factory>;
    getContractFactory(
      name: "IMetaStocksCompanyManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksCompanyManager__factory>;
    getContractFactory(
      name: "IMetaStocksFranchise",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksFranchise__factory>;
    getContractFactory(
      name: "IMetaStocksFranchiseManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksFranchiseManager__factory>;
    getContractFactory(
      name: "IMetaStocksFranchiseShare",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksFranchiseShare__factory>;
    getContractFactory(
      name: "IMetaStocksFranchiseShareManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMetaStocksFranchiseShareManager__factory>;
    getContractFactory(
      name: "IMidasManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMidasManager__factory>;
    getContractFactory(
      name: "IMidasManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMidasManager__factory>;
    getContractFactory(
      name: "IMidasMultiNetworkRouter",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IMidasMultiNetworkRouter__factory>;
    getContractFactory(
      name: "MidasMultiNetworkRouterManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MidasMultiNetworkRouterManager__factory>;
    getContractFactory(
      name: "ChainlinkDataFeedsManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ChainlinkDataFeedsManager__factory>;
    getContractFactory(
      name: "ChainlinkVRFManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ChainlinkVRFManager__factory>;
    getContractFactory(
      name: "MetaStocksAchievementsManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksAchievementsManager__factory>;
    getContractFactory(
      name: "MetaStocksCompanyManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksCompanyManager__factory>;
    getContractFactory(
      name: "MetaStocksFranchiseManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksFranchiseManager__factory>;
    getContractFactory(
      name: "MetaStocksFranchiseMarketplaceManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksFranchiseMarketplaceManager__factory>;
    getContractFactory(
      name: "MetaStocksFranchiseShareManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksFranchiseShareManager__factory>;
    getContractFactory(
      name: "MidasMultinetworkRouterManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MidasMultinetworkRouterManager__factory>;
    getContractFactory(
      name: "TransactionFeesManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.TransactionFeesManager__factory>;
    getContractFactory(
      name: "DividendPayingToken",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.DividendPayingToken__factory>;
    getContractFactory(
      name: "HermesDividendTracker",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.HermesDividendTracker__factory>;
    getContractFactory(
      name: "IDividendPayingToken",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IDividendPayingToken__factory>;
    getContractFactory(
      name: "IDividendPayingTokenOptional",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IDividendPayingTokenOptional__factory>;
    getContractFactory(
      name: "HermesMerkleAirdropDistributor",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.HermesMerkleAirdropDistributor__factory>;
    getContractFactory(
      name: "IAutoLiquidityInjecter",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IAutoLiquidityInjecter__factory>;
    getContractFactory(
      name: "ITykheFortuneDistributor",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ITykheFortuneDistributor__factory>;
    getContractFactory(
      name: "TykheFortuneDistributor",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.TykheFortuneDistributor__factory>;
    getContractFactory(
      name: "MetaStocksCompany",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksCompany__factory>;
    getContractFactory(
      name: "MetaStocksFranchise",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksFranchise__factory>;
    getContractFactory(
      name: "MetaStocksFranchiseShare",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksFranchiseShare__factory>;
    getContractFactory(
      name: "MetaStocksToken",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksToken__factory>;
    getContractFactory(
      name: "MyToken",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MyToken__factory>;
    getContractFactory(
      name: "MetaStocksERC1155Upgradable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksERC1155Upgradable__factory>;
    getContractFactory(
      name: "MetaStocksERC20Upgradable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksERC20Upgradable__factory>;
    getContractFactory(
      name: "MetaStocksIERC1155ReceiverHolder",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksIERC1155ReceiverHolder__factory>;
    getContractFactory(
      name: "MetaStocksIER721ReceiverHolder",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksIER721ReceiverHolder__factory>;
    getContractFactory(
      name: "MetaStocksSBT",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.MetaStocksSBT__factory>;

    getContractAt(
      name: "AggregatorV3Interface",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.AggregatorV3Interface>;
    getContractAt(
      name: "VRFCoordinatorV2Interface",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.VRFCoordinatorV2Interface>;
    getContractAt(
      name: "OwnableUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.OwnableUpgradeable>;
    getContractAt(
      name: "Initializable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Initializable>;
    getContractAt(
      name: "PausableUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PausableUpgradeable>;
    getContractAt(
      name: "ERC1155Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC1155Upgradeable>;
    getContractAt(
      name: "ERC1155BurnableUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC1155BurnableUpgradeable>;
    getContractAt(
      name: "ERC1155SupplyUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC1155SupplyUpgradeable>;
    getContractAt(
      name: "IERC1155MetadataURIUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC1155MetadataURIUpgradeable>;
    getContractAt(
      name: "IERC1155ReceiverUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC1155ReceiverUpgradeable>;
    getContractAt(
      name: "IERC1155Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC1155Upgradeable>;
    getContractAt(
      name: "ERC20Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC20Upgradeable>;
    getContractAt(
      name: "IERC20MetadataUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20MetadataUpgradeable>;
    getContractAt(
      name: "IERC20Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20Upgradeable>;
    getContractAt(
      name: "ERC721Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC721Upgradeable>;
    getContractAt(
      name: "ERC721URIStorageUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC721URIStorageUpgradeable>;
    getContractAt(
      name: "IERC721MetadataUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721MetadataUpgradeable>;
    getContractAt(
      name: "IERC721ReceiverUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721ReceiverUpgradeable>;
    getContractAt(
      name: "IERC721Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721Upgradeable>;
    getContractAt(
      name: "ContextUpgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ContextUpgradeable>;
    getContractAt(
      name: "ERC165Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC165Upgradeable>;
    getContractAt(
      name: "IERC165Upgradeable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC165Upgradeable>;
    getContractAt(
      name: "Ownable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Ownable>;
    getContractAt(
      name: "IERC1155Receiver",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC1155Receiver>;
    getContractAt(
      name: "ERC1155Holder",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC1155Holder>;
    getContractAt(
      name: "ERC1155Receiver",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC1155Receiver>;
    getContractAt(
      name: "ERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC20>;
    getContractAt(
      name: "IERC20Metadata",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20Metadata>;
    getContractAt(
      name: "IERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20>;
    getContractAt(
      name: "ERC165",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC165>;
    getContractAt(
      name: "IERC165",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC165>;
    getContractAt(
      name: "IUniswapV2Factory",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IUniswapV2Factory>;
    getContractAt(
      name: "IUniswapV2Router01",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IUniswapV2Router01>;
    getContractAt(
      name: "IUniswapV2Router02",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IUniswapV2Router02>;
    getContractAt(
      name: "BEP20Token",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.BEP20Token>;
    getContractAt(
      name: "Context",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Context>;
    getContractAt(
      name: "IBEP20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IBEP20>;
    getContractAt(
      name: "Ownable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Ownable>;
    getContractAt(
      name: "IERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20>;
    getContractAt(
      name: "IPancakeCallee",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeCallee>;
    getContractAt(
      name: "IPancakeERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeERC20>;
    getContractAt(
      name: "IPancakeFactory",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeFactory>;
    getContractAt(
      name: "IPancakePair",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakePair>;
    getContractAt(
      name: "PancakeERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PancakeERC20>;
    getContractAt(
      name: "PancakeFactory",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PancakeFactory>;
    getContractAt(
      name: "PancakePair",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PancakePair>;
    getContractAt(
      name: "IERC20",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC20>;
    getContractAt(
      name: "IPancakeFactory",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeFactory>;
    getContractAt(
      name: "IPancakePair",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakePair>;
    getContractAt(
      name: "IPancakeRouter01",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeRouter01>;
    getContractAt(
      name: "IPancakeRouter02",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPancakeRouter02>;
    getContractAt(
      name: "IWETH",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IWETH>;
    getContractAt(
      name: "PancakeRouter",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PancakeRouter>;
    getContractAt(
      name: "WBNB",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.WBNB>;
    getContractAt(
      name: "IAutoLiquidityInjecter",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IAutoLiquidityInjecter>;
    getContractAt(
      name: "IJoeRouter01",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IJoeRouter01>;
    getContractAt(
      name: "IJoeRouter02",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IJoeRouter02>;
    getContractAt(
      name: "IPangolinRouter",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IPangolinRouter>;
    getContractAt(
      name: "IMetaStocksBaseManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksBaseManager>;
    getContractAt(
      name: "IMetaStocksCompany",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksCompany>;
    getContractAt(
      name: "IMetaStocksCompanyInfo",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksCompanyInfo>;
    getContractAt(
      name: "IMetaStocksCompanyManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksCompanyManager>;
    getContractAt(
      name: "IMetaStocksFranchise",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksFranchise>;
    getContractAt(
      name: "IMetaStocksFranchiseManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksFranchiseManager>;
    getContractAt(
      name: "IMetaStocksFranchiseShare",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksFranchiseShare>;
    getContractAt(
      name: "IMetaStocksFranchiseShareManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMetaStocksFranchiseShareManager>;
    getContractAt(
      name: "IMidasManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMidasManager>;
    getContractAt(
      name: "IMidasManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMidasManager>;
    getContractAt(
      name: "IMidasMultiNetworkRouter",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IMidasMultiNetworkRouter>;
    getContractAt(
      name: "MidasMultiNetworkRouterManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MidasMultiNetworkRouterManager>;
    getContractAt(
      name: "ChainlinkDataFeedsManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ChainlinkDataFeedsManager>;
    getContractAt(
      name: "ChainlinkVRFManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ChainlinkVRFManager>;
    getContractAt(
      name: "MetaStocksAchievementsManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksAchievementsManager>;
    getContractAt(
      name: "MetaStocksCompanyManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksCompanyManager>;
    getContractAt(
      name: "MetaStocksFranchiseManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksFranchiseManager>;
    getContractAt(
      name: "MetaStocksFranchiseMarketplaceManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksFranchiseMarketplaceManager>;
    getContractAt(
      name: "MetaStocksFranchiseShareManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksFranchiseShareManager>;
    getContractAt(
      name: "MidasMultinetworkRouterManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MidasMultinetworkRouterManager>;
    getContractAt(
      name: "TransactionFeesManager",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.TransactionFeesManager>;
    getContractAt(
      name: "DividendPayingToken",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.DividendPayingToken>;
    getContractAt(
      name: "HermesDividendTracker",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.HermesDividendTracker>;
    getContractAt(
      name: "IDividendPayingToken",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IDividendPayingToken>;
    getContractAt(
      name: "IDividendPayingTokenOptional",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IDividendPayingTokenOptional>;
    getContractAt(
      name: "HermesMerkleAirdropDistributor",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.HermesMerkleAirdropDistributor>;
    getContractAt(
      name: "IAutoLiquidityInjecter",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IAutoLiquidityInjecter>;
    getContractAt(
      name: "ITykheFortuneDistributor",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ITykheFortuneDistributor>;
    getContractAt(
      name: "TykheFortuneDistributor",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.TykheFortuneDistributor>;
    getContractAt(
      name: "MetaStocksCompany",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksCompany>;
    getContractAt(
      name: "MetaStocksFranchise",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksFranchise>;
    getContractAt(
      name: "MetaStocksFranchiseShare",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksFranchiseShare>;
    getContractAt(
      name: "MetaStocksToken",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksToken>;
    getContractAt(
      name: "MyToken",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MyToken>;
    getContractAt(
      name: "MetaStocksERC1155Upgradable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksERC1155Upgradable>;
    getContractAt(
      name: "MetaStocksERC20Upgradable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksERC20Upgradable>;
    getContractAt(
      name: "MetaStocksIERC1155ReceiverHolder",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksIERC1155ReceiverHolder>;
    getContractAt(
      name: "MetaStocksIER721ReceiverHolder",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksIER721ReceiverHolder>;
    getContractAt(
      name: "MetaStocksSBT",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.MetaStocksSBT>;

    // default types
    getContractFactory(
      name: string,
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<ethers.ContractFactory>;
    getContractFactory(
      abi: any[],
      bytecode: ethers.utils.BytesLike,
      signer?: ethers.Signer
    ): Promise<ethers.ContractFactory>;
    getContractAt(
      nameOrAbi: string | any[],
      address: string,
      signer?: ethers.Signer
    ): Promise<ethers.Contract>;
  }
}
