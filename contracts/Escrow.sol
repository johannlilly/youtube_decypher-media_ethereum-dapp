contract Escrow {

	address public buyer;
	address public seller;
	address public arbiter;

	// constructor
	function Escrow(address _seller, address _arbiter) {
		buyer = msg.sender; // assume the buyer is creating this Escrow contract
		seller = _seller; // set the state variable of seller to the argument
		arbiter = _arbiter; // set the state variable of arbiter to the argument
	}

}