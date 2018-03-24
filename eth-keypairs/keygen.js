// call this file
// pass in a private key
// get a wallet address

// get access to arguments you pass in to a script with process.argv[0]
// console.log(`0:${process.argv[0]}\n1:${process.argv[1]}\n2:${process.argv[2]}`)

var EthUtil = require("ethereumjs-util")

// helper function

var hexToBytes = function(hex) {
	for (var bytes = [], c = 0; c < hex.length; c += 2)
	bytes.push(parseInt(hex.substr(c, 2), 16));
	return bytes;
}

