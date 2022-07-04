/*
TYKHE (Tyche) was the goddess of fortune, chance, providence and fate.
She was usually honoured in a more favourable light as Eutykhia (Eutychia),
goddess of good fortune, luck, success and prosperity.

she will help us to calculate and distribute the profits
fairly among all those who participated according
to the help they gave when we had nothing.

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

struct FeeReceiver {
    address receiver;
    uint256 percentage;
}

contract TykheFortuneDistributor is Initializable {
    address private sendFeeTokenAddress;
    mapping(uint256 => FeeReceiver) private feeReceivers;
    uint256 private fortune;
    uint256 private membersCounter;
    uint256 private masterTaxDivisor;
    address private owner;
    address LIMBO_DOOR;
    mapping(address => bool) private _isExcludedFromFee;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function initialize() public initializer {
        owner = msg.sender;
        membersCounter = 0;
        fortune = 0;
        masterTaxDivisor = 10000;
        sendFeeTokenAddress = address(0);
        LIMBO_DOOR = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account ('newOwner').
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function getMembersCounter() internal virtual returns (uint256) {
        return membersCounter;
    }

    function getFortune() internal virtual returns (uint256) {
        return fortune;
    }

    function setSendFeeTokenAddress(address newAddress)
        internal
        virtual
        onlyOwner
    {
        sendFeeTokenAddress = newAddress;
    }

    function getSendFeeTokenAddress() internal virtual returns (address) {
        return sendFeeTokenAddress;
    }

    function getFortuneReceiver(address _feesReceiverAddress)
        internal
        virtual
        returns (address)
    {
        for (uint256 index = 0; index < membersCounter; index++) {
            if (feeReceivers[index].receiver == _feesReceiverAddress) {
                return _feesReceiverAddress;
            }
        }
        return address(0);
    }

    function setExcludedFromFee(address account, bool val) external virtual {
        _isExcludedFromFee[account] = val;
    }

    function isExcludedFromFee(address account)
        external
        view
        virtual
        returns (bool)
    {
        return _isExcludedFromFee[account];
    }

    function getFortuneReceiverIndex(address _feesReceiverAddress)
        internal
        virtual
        returns (uint256)
    {
        for (uint256 index = 0; index < membersCounter; index++) {
            if (feeReceivers[index].receiver == _feesReceiverAddress) {
                return index;
            }
        }
        return 0;
    }

    function addFortuneReceiver(address receiver, uint256 percentage)
        internal
        virtual
        onlyOwner
    {
        feeReceivers[membersCounter + 1] = FeeReceiver(receiver, percentage);
    }

    function updateFortuneReceiverPercentage(
        address receiver,
        uint256 percentage
    ) internal virtual onlyOwner {
        uint256 index = getFortuneReceiverIndex(receiver);
        feeReceivers[index].percentage = percentage;
    }

    function removeFortuneReceiver(address receiver)
        internal
        virtual
        onlyOwner
    {
        uint256 index = getFortuneReceiverIndex(receiver);
        feeReceivers[index] = FeeReceiver(LIMBO_DOOR, 0);
        membersCounter--;
    }

    function sendFortune() external virtual {
        require(fortune > 0, "no fortune to send");
        require(membersCounter > 0, "no fortune receivers");
        for (uint256 index = 0; index < membersCounter; index++) {
            FeeReceiver memory feeReceiver = feeReceivers[index];
            if (feeReceiver.receiver != LIMBO_DOOR) {
                IERC20(sendFeeTokenAddress).transferFrom(
                    address(this),
                    feeReceiver.receiver,
                    (fortune * feeReceiver.percentage) / masterTaxDivisor
                );
            }
        }
    }
}
