contract Escrow {

	address buyer; // public ethereum address of type 'address'
	address seller;
	address arbiter;

	// query the value of an address using web3
	function getBuyerAddress() constant returns (address) {
		return buyer;
	}

}