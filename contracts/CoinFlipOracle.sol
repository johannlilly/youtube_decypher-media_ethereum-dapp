import "./OraclizeI.sol";

contract CoinFlipOracle is usingOraclize {

	string public result;
	bytes32 public oraclizeID;

	// send some ETH to oraclize to get an ID
	function flipCoin() payable {
		oraclizeID = oraclize_query("WolframAlpha","flip a coin");
	}

	// this is the function oraclize will call on our contract
	function __callback(bytes32 _oracleID, string _result) {
		result = _result;
	} 

}