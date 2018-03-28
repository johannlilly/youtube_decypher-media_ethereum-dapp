contract Escrow {

	address public buyer;
	address public seller;
	address public arbiter;

	// constructor
	function Escrow() {
		buyer = msg.sender; // assume the buyer is creating this Escrow contract
	}

}