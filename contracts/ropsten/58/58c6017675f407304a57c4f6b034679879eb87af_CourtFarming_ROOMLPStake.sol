/**
 *Submitted for verification at Etherscan.io on 2021-02-24
*/

pragma solidity ^0.5.0;

interface ICourtStake{

    function lockedStake(uint256 amount, uint256 lockTime, address beneficiary) external;

}

interface IMERC20 {
    function mint(address account, uint amount) external;
}


/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);


    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// This contract will have three deployments with different configurations.
// Reward "COURT" farming; from staking of the ROOM token.
// Reward "COURT" farming; from staking of ROOM liquidity pool token (Liquidity pool for ROOM/ETH).
// Reward "COURT" farming; from staking of COURT liquidity pool token (Liquidity pool for COURT/ETH).
contract CourtFarming_ROOMLPStake {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // TODO: set the correct lpToken address
    IERC20 public constant stakedToken = IERC20(0x5113efe86f5a93fc40721497138570406544831c);

    //TODO: set the correct Court Token address
    IMERC20 public constant courtToken = IMERC20(0x6C82B5f4C06B8fB3722C24cDda066eFaaf398e93);

    uint256 private _totalStaked;
    mapping(address => uint256) private _balances;

    // last updated block number
    uint256 private _lastUpdateBlock;

    // normal rewards
    uint256 public finishBlock; // finish rewarding block number
    uint256 private  _rewardPerBlock;   // reward per block
    uint256 private _accRewardPerToken; // accumulative reward per token
    mapping(address => uint256) private _rewards; // rewards balances
    mapping(address => uint256) private _prevAccRewardPerToken; // previous accumulative reward per token (for a user)
    


    // incentive rewards
    uint256 public incvLockTime;
    uint256 public incvFinishBlock; //  finish incentive rewarding block number
    uint256 private _incvRewardPerBlock; // incentive reward per block
    uint256 private _incvAccRewardPerToken; // accumulative reward per token
    mapping(address => uint256) private _incvRewards; // reward balances
    mapping(address => uint256) private _incvPrevAccRewardPerToken;// previous accumulative reward per token (for a user)
    


    address public owner;
    
    enum TransferRewardState {
        Succeeded,
        RewardsStillLocked
    }

    // To minimize the actions required to stake COURT, you just put the address
    // of the contract that holds the governance COURT staking.
    // TODO: Tareq Doufish, testing is required for the function
    // that sets the address and do the actual transfer.
    address public courtStakeAddress;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event ClaimReward(address indexed user, uint256 reward);
    event ClaimIncentiveReward(address indexed user, uint256 reward);
    event StakeRewards(address indexed user, uint256 amount, uint256 lockTime);
    event CourtStakeChanged(address oldAddress, address newAddress);
    event StakeParametersChanged(uint256 rewardPerBlock, uint256 rewardFinishBlock, uint256 incvRewardPerBlock, uint256 incvRewardFinsishBlock, uint256 incvLockTime);

    constructor () public {

        owner = msg.sender;
        
        // TODO: fill this info 
        uint256 totalRewards  = 90000e18;
        uint256 rewardsPeriodInDays = 450;
        uint256 incvTotalRewards = 36000e18;
        uint256 incvRewardsPeriodInDays = 60;
        incvLockTime = 1640995200; // 01/01/2022
        
         _stakeParametrsCalculation(totalRewards, rewardsPeriodInDays, incvTotalRewards, incvRewardsPeriodInDays, incvLockTime);
        
        _lastUpdateBlock = blockNumber();
    }
    
    function _stakeParametrsCalculation(uint256 totalRewards, uint256 rewardsPeriodInDays, uint256 incvTotalRewards, uint256 incvRewardsPeriodInDays, uint256 iLockTime) internal{
        
        
        uint256 rewardBlockCount = rewardsPeriodInDays * 5760;
        uint256 rewardPerBlock = ((totalRewards * 1e18 )/ rewardBlockCount) / 1e18;
        
        uint256 incvRewardBlockCount = incvRewardsPeriodInDays * 5760;
        uint256 incvRewardPerBlock = ((incvTotalRewards * 1e18 )/ incvRewardBlockCount) / 1e18;
        
        _rewardPerBlock = rewardPerBlock * 1e18; // for math precision
        finishBlock = blockNumber().add(rewardBlockCount);
        
        _incvRewardPerBlock = incvRewardPerBlock * 1e18; // for math precision
        incvFinishBlock = blockNumber().add(incvRewardBlockCount);

        incvLockTime = iLockTime;
    }

    function changeStakeParameters(uint256 totalRewards, uint256 rewardsPeriodInDays, uint256 incvTotalRewards, uint256 incvRewardsPeriodInDays, uint256 iLockTime) external {

        require(msg.sender == owner, "can be called by owner only");
        updateReward(address(0));
        
        _stakeParametrsCalculation(totalRewards, rewardsPeriodInDays, incvTotalRewards, incvRewardsPeriodInDays, iLockTime);

        emit StakeParametersChanged(_rewardPerBlock, finishBlock, _incvRewardPerBlock, incvFinishBlock, incvLockTime);
    }

    function updateReward(address account) public {
        // reward algorithm
        // in general: rewards = (reward per token ber block) user balances
        uint256 cnBlock = blockNumber();

        // update accRewardPerToken, in case totalSupply is zero; do not increment accRewardPerToken
        if (_totalStaked > 0) {
            uint256 lastRewardBlock = cnBlock < finishBlock ? cnBlock : finishBlock;
            if (lastRewardBlock > _lastUpdateBlock) {
                _accRewardPerToken = lastRewardBlock.sub(_lastUpdateBlock)
                .mul(_rewardPerBlock).div(_totalStaked)
                .add(_accRewardPerToken);
            }

            uint256 incvlastRewardBlock = cnBlock < incvFinishBlock ? cnBlock : incvFinishBlock;
            if (incvlastRewardBlock > _lastUpdateBlock) {
                _incvAccRewardPerToken = incvlastRewardBlock.sub(_lastUpdateBlock)
                .mul(_incvRewardPerBlock).div(_totalStaked)
                .add(_incvAccRewardPerToken);
            }
        }

        _lastUpdateBlock = cnBlock;

        if (account != address(0)) {

            uint256 accRewardPerTokenForUser = _accRewardPerToken.sub(_prevAccRewardPerToken[account]);

            if (accRewardPerTokenForUser > 0) {
                _rewards[account] =
                _balances[account]
                .mul(accRewardPerTokenForUser)
                .div(1e18)
                .add(_rewards[account]);

                _prevAccRewardPerToken[account] = _accRewardPerToken;
            }

            uint256 incAccRewardPerTokenForUser = _incvAccRewardPerToken.sub(_incvPrevAccRewardPerToken[account]);

            if (incAccRewardPerTokenForUser > 0) {
                _incvRewards[account] =
                _balances[account]
                .mul(incAccRewardPerTokenForUser)
                .div(1e18)
                .add(_incvRewards[account]);

                _incvPrevAccRewardPerToken[account] = _incvAccRewardPerToken;
            }
        }
    }

    function stake(uint256 amount) public {
        updateReward(msg.sender);

        if (amount > 0) {
            _totalStaked = _totalStaked.add(amount);
            _balances[msg.sender] = _balances[msg.sender].add(amount);
            stakedToken.safeTransferFrom(msg.sender, address(this), amount);
            emit Staked(msg.sender, amount);
        }
    }

    function unstake(uint256 amount, bool claim) public {
        updateReward(msg.sender);

        if (amount > 0) {
            _totalStaked = _totalStaked.sub(amount);
            _balances[msg.sender] = _balances[msg.sender].sub(amount);
            stakedToken.safeTransfer(msg.sender, amount);
            emit Unstaked(msg.sender, amount);
        }

        if (claim) {
            uint256 reward = _rewards[msg.sender];
            if (reward > 0) {
                _rewards[msg.sender] = 0;
                courtToken.mint(msg.sender, reward);
                emit ClaimReward(msg.sender, reward);
            }
        }
    }

    function claimReward() public returns (TransferRewardState ){
        updateReward(msg.sender);

        uint256 reward = _rewards[msg.sender];
       
        if (reward > 0) {
            _rewards[msg.sender] = 0;
            courtToken.mint(msg.sender, reward);
            emit ClaimReward(msg.sender, reward);
        }
         return TransferRewardState.Succeeded;
    }

    function claimIncvReward() public returns (TransferRewardState ){
        
        if (block.timestamp < incvLockTime) {
            return TransferRewardState.RewardsStillLocked;
        }

        updateReward(msg.sender);

        uint256 incvReward = _incvRewards[msg.sender];

        if (incvReward > 0) {
            _incvRewards[msg.sender] = 0;
            courtToken.mint(msg.sender, incvReward);
            emit ClaimIncentiveReward(msg.sender, incvReward);
        }

        return TransferRewardState.Succeeded;
    }


    function stakeRewards(uint256 amount) public returns (bool) {
        updateReward(msg.sender);
        uint256 reward = _rewards[msg.sender];


        if (amount > reward || courtStakeAddress == address(0)) {
            return false;
        }

        _rewards[msg.sender] -= amount; // no need to use safe math sub, since there is check for amount > reward
        
        courtToken.mint(address(this), amount);

        ICourtStake courtStake = ICourtStake(courtStakeAddress);
        courtStake.lockedStake(amount, 0, msg.sender);
        emit StakeRewards(msg.sender, amount, 0);

    }

    function stakeIncRewards(uint256 amount) public returns (bool) {
        updateReward(msg.sender);
        uint256 incvReward = _incvRewards[msg.sender];


        if (amount > incvReward || courtStakeAddress == address(0)) {
            return false;
        }

        _incvRewards[msg.sender] -= amount;  // no need to use safe math sub, since there is check for amount > reward
        
        courtToken.mint(address(this), amount);

        ICourtStake courtStake = ICourtStake(courtStakeAddress);
        courtStake.lockedStake(amount, incvLockTime, msg.sender);
        emit StakeRewards(msg.sender, amount, incvLockTime);
    }

    function setCourtStake(address courtStakeAdd) public {
        require(msg.sender == owner, "only contract owner can change");
        
        address oldAddress = courtStakeAddress;
        courtStakeAddress = courtStakeAdd;

        IERC20 courtTokenERC20 = IERC20(address(courtToken));

        courtTokenERC20.approve(courtStakeAdd, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);

        emit CourtStakeChanged(oldAddress, courtStakeAdd);
    }

    function rewards(address account) external view returns (uint256 reward, uint256 incvReward) {
        // read version of update
        uint256 cnBlock = blockNumber();
        uint256 accRewardPerToken = _accRewardPerToken;
        uint256 incvAccRewardPerToken = _incvAccRewardPerToken;

        // update accRewardPerToken, in case totalSupply is zero; do not increment accRewardPerToken
        if (_totalStaked > 0) {
            uint256 lastRewardBlock = cnBlock < finishBlock ? cnBlock : finishBlock;
            if (lastRewardBlock > _lastUpdateBlock) {
                accRewardPerToken = lastRewardBlock.sub(_lastUpdateBlock)
                .mul(_rewardPerBlock).div(_totalStaked)
                .add(accRewardPerToken);
            }

            uint256 incvLastRewardBlock = cnBlock < incvFinishBlock ? cnBlock : incvFinishBlock;
            if (incvLastRewardBlock > _lastUpdateBlock) {
                incvAccRewardPerToken = incvLastRewardBlock.sub(_lastUpdateBlock)
                .mul(_incvRewardPerBlock).div(_totalStaked)
                .add(incvAccRewardPerToken);
            }
        }

        reward = _balances[account]
        .mul(accRewardPerToken.sub(_prevAccRewardPerToken[account]))
        .div(1e18)
        .add(_rewards[account]);

        incvReward = _balances[account]
        .mul(incvAccRewardPerToken.sub(_incvPrevAccRewardPerToken[account]))
        .div(1e18)
        .add(_incvRewards[account]);
    }

    function rewardInfo() external view returns (uint256 cBlockNumber, uint256 rewardPerBlock, uint256 rewardFinishBlock, uint256 rewardFinishTime, uint256 rewardLockTime) {
        cBlockNumber = blockNumber();
        rewardFinishBlock = finishBlock;
        rewardPerBlock = _rewardPerBlock.div(1e18);
        if( cBlockNumber < finishBlock){
            rewardFinishTime = block.timestamp.add(finishBlock.sub(cBlockNumber).mul(15));
        }else{
            rewardFinishTime = block.timestamp.sub(cBlockNumber.sub(finishBlock).mul(15));
        }
        rewardLockTime=0;
    }
    
    function incvRewardInfo() external view returns (uint256 cBlockNumber, uint256 incvRewardPerBlock, uint256 incvRewardFinishBlock, uint256 incvRewardFinishTime, uint256 incvRewardLockTime) {
        cBlockNumber = blockNumber();
        incvRewardFinishBlock = incvFinishBlock;
        incvRewardPerBlock = _incvRewardPerBlock.div(1e18);
        if( cBlockNumber < incvFinishBlock){
            incvRewardFinishTime = block.timestamp.add(incvFinishBlock.sub(cBlockNumber).mul(15));
        }else{
            incvRewardFinishTime = block.timestamp.sub(cBlockNumber.sub(incvFinishBlock).mul(15));
        }
        incvRewardLockTime=incvLockTime;
    }


    // expected reward,
    // please note this is only expectation, because total balance may changed during the day
    function expectedRewardsToday(uint256 amount) external view returns (uint256 reward, uint256 incvReward) {
        // read version of update

        uint256 cnBlock = blockNumber();
        uint256 prevAccRewardPerToken = _accRewardPerToken;
        uint256 prevIncvAccRewardPerToken = _incvAccRewardPerToken;

        uint256 accRewardPerToken = _accRewardPerToken;
        uint256 incvAccRewardPerToken = _incvAccRewardPerToken;
        // update accRewardPerToken, in case totalSupply is zero do; not increment accRewardPerToken

        uint256 lastRewardBlock = cnBlock < finishBlock ? cnBlock : finishBlock;
        if (lastRewardBlock > _lastUpdateBlock) {
            accRewardPerToken = lastRewardBlock.sub(_lastUpdateBlock)
            .mul(_rewardPerBlock).div(_totalStaked.add(amount))
            .add(accRewardPerToken);
        }

        uint256 incvLastRewardBlock = cnBlock < incvFinishBlock ? cnBlock : incvFinishBlock;
        if (incvLastRewardBlock > _lastUpdateBlock) {
            incvAccRewardPerToken = incvLastRewardBlock.sub(_lastUpdateBlock)
            .mul(_incvRewardPerBlock).div(_totalStaked.add(amount))
            .add(incvAccRewardPerToken);
        }


        uint256 rewardsPerBlock = amount
        .mul(accRewardPerToken.sub(prevAccRewardPerToken))
        .div(1e18);

        uint256 incvRewardsPerBlock = amount
        .mul(incvAccRewardPerToken.sub(prevIncvAccRewardPerToken))
        .div(1e18);

        // 5760 blocks per day
        reward = rewardsPerBlock.mul(5760);
        incvReward = incvRewardsPerBlock.mul(5760);
    }
    
    function lastUpdateBlock() external view returns(uint256) {
        return _lastUpdateBlock;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function totalStaked() external view returns (uint256) {
        return _totalStaked;
    }

    function blockNumber() public view returns (uint256) {
        if(timeFrezed){
            return frezedBlock + lockShift;
        }
        return block.number +lockShift;
    }
    
    ///// for demo
    bool public timeFrezed;
    uint256 frezedBlock =0;
    function frezeBlock(bool flag) public{
        timeFrezed = flag;
        frezedBlock = blockNumber().sub(lockShift);
    }
    function isTimeFrerzed() public view returns(bool){
        return timeFrezed;
    }
    uint256 lockShift;
    function increaseBlock(uint256 count) public{
        lockShift+=count;
    }
}