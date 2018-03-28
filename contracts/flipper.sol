contract Flipper {

	enum GameState {noWager, wagerMade, wagerAccepted}
	// declare variable of type GameState
	GameState public currentState;
	uint public wager;
	address public player1;
	address public player2;
	uint public seedBlockNumber;

	modifier onlyState(GameState expectedState) {if(expectedState == currentState) {_;} else {throw;}}

	function Flipper() {
		currentState = GameState.noWager;
	}

	function makeWager() onlyState(GameState.noWager) payable returns (bool) {
		wager = msg.value;
		player1 = msg.sender;
		currentState = GameState.wagerMade;
		return true;
	}

	function acceptWager() onlyState(GameState.wagerMade) payable returns (bool) {
		if(msg.value == wager) {
			player2 = msg.sender;
			seedBlockNumber = block.number;
			currentState = GameState.wagerAccepted;
			return true;
		} else {
			throw;
		}
	}

	function resolveBet() onlyState(GameState.wagerAccepted) returns (bool) {
		uint256 blockValue = uint256(block.blockhash(seedBlockNumber)); // access seed block hash of the previous block
		uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968; // (2 ^ 256) / 2 => 50/50 chance
		uint256 coinFlip = uint256(uint256(blockValue) / FACTOR); // equally likely change of being 0 or 1

		if(coinFlip == 0) {
			player1.send(this.balance);
			currentState = GameState.noWager;
			return true;
		} else {
			player2.send(this.balance);
			currentState = GameState.noWager;
			return true;
		}

		currentState = GameState.noWager;
		return true;
	}

}