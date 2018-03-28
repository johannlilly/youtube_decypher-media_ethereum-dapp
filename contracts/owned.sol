contract owned {

	address public owner;

	function owned() {
		owner = msg.sender;
	}

	modifier onlyOwner() {
		if(msg.sender == owner) {
			_;
		}
	}
}