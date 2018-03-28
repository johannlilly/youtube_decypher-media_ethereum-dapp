contract Flipper {

	enum GameState {noWager, wagerMade, wagerAccepted}
	// declare variable of type GameState
	GameState public currentState;

	modifier onlyState(GameState expectedState) {
		if(expectedState == currentState) {
			_; // delegate to the function that uses this modifier.
		} 
	}

	function Flipper() {
		currentState = GameState.noWager;
	}

	function transitionGameState(bytes32 targetState) returns (bool) {
		if(targetState == "noWager") {
			currentState = GameState.noWager;
			return true;
		}
		else if (targetState == "wagerMade") {
			currentState = GameState.wagerMade;
			return true;
		}
		else if (targetState == "wagerAccepted") {
			currentState = GameState.wagerAccepted;
			return true;
		}

		return false;
	}

}