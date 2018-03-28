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

	// send current balance of escrow contract to the seller
	function payourToSeller() {
		// send amount of ETH defined to the account that is calling it
		if(msg.sender == buyer || msg.sender == arbiter) {
			seller.send(this.balance);
		}
	}

	function refundToBuyer() {
		if(msg.sender == seller || msg.sender == arbiter) {
			buyer.send(this.balance);
		}
	}

}