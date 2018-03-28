contract helloworld is owned {

	string public message;

	function setMessage(string _message) onlyOwner() {
		message = _message;
	}

}