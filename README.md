# Ultimate Introduction to Ethereum Ðapp Development
by Decypher Media
- [GitHub](https://github.com/AlwaysBCoding)
- [YouTube](https://www.youtube.com/channel/UC8CB0ZkvogP7tnCTDR-zV7g)
- [Twitter](https://twitter.com/AlwaysBCoding)
- [LinkedIn](https://www.linkedin.com/in/alwaysbcoding)

- [Ultimate Introduction to Ethereum Ðapp Development](https://www.youtube.com/playlist?list=PLV1JDFUtrXpFh85G-Ddyy2kLSafaB9biQ) [playlist]
- [Ultimate Intro to Ethereum Ðapp Development [Part 1] - Provisioning the Development Environment](https://youtu.be/rmtsh7Q7sbE)
- [Ultimate Intro to Ethereum Ðapp Development [Part 2] - Creating Ethereum Keypairs](https://youtu.be/YWoBeoTUrYM)

Ultimate Intro to Ethereum Ðapp Development [Part 2] - Creating Ethereum Keypairs

## [Part 1] - Provisioning the Development Environment  

	> Web3
	{ [Function: Web3]
	  providers: 
	   { HttpProvider: [Function: HttpProvider],
	     IpcProvider: [Function: IpcProvider] } }
	// generate web3 instance
	> var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
	undefined
	> web3.eth.accounts
	(public keys)

## [Part 2] - Creating Ethereum Keypairs

	> var Web3 = require("web3")
	undefined
	> var web3 = new Web3
	undefined
	> web3
	// your web3 object

ETH private key is a 64-character string. 64-character key is a valid Ethereum private key, with a few exceptions (like 64 0's). When you generate private keys, capitalization does not matter.

With a private key, there is a deterministic function that maps a private key to a public key. The same private key maps to the same public key every time. The wallett address is shorter than the private key. It is referred to as a wallet address, not a public key. When generating a public key from a private key, you take the last 40 digits, then that is the wallet address. You may see "0x" in front of it, but that is not part of the data. It is a data declaration, declaring that the string that follows is in the hexidecimal format. You can not go from private address back to public key. It is mathematically unknown.

Any 40-digit hexidecimal string is a valid ethereum address. You can send Ether to any address.

### How do you pick a strong private key? SHA.

SHA can hash any arbitrary string into another string of exactly 64 characters.

	> web3.sha3("copper explain ill-fated truck neat unite branch educated tenuous hum")
	'0xb9337f10e3a54b13e5700f9c9e8a29b867a96c8fe9173e492d566b4d7bc539e5'

	> web3.sha3("password")
	'0xb68fe43f0d1a0d7aef123722670be50268e15365401c442f8806ef83b612976b'

> Note: there are better ways of generating entropy than SHA of SHA. For example, using the keythereum library, which has better cryptographic functions. Another is the bip-0032 algorithm, which generates the 12 word phrases. 

No matter how many times you hash the string, the same result will be generated. If you change even one character, you will get a completely different string.

SHA has an interesting use-case for fingerprinting documents. You can generate the SHA hash of a file, then if somebody changes even one character in that string, you will know that somebody altered the file because the SHA hash will be different.

Another thing you can do is take a word that you have memorized, then SHA hash it into a 64-digit string and use that as a private key. You don't have to limit to a single word. It can be many words in combination with numbers and other characters. You can also perform a "double SHA," where you perform the SHA of the SHA of a string.

	> web3.sha3(web3.sha3("copper explain ill-fated truck neat unite branch educated tenuous hum"))
	'0x9b586a2588ae1c054f294ea22afe8776893de0a39323714cfe4280d351fff99d'

Using words that you can remember is called a brain wallet. You remember some term, some algorithm that you used to generate the private key from that term deterministically, and that's what you use as your secure private key.

### How do you generate a wallet address from a private key?

Use ethereumjs-util library. 

	> node ./keygen.js
	0:/usr/local/bin/node
	1:/Users/user/Documents/GitHub/youtube_decypher-media_ethereum-dapp/eth-keypairs/keygen.js
	2:undefined

0: path to node.js executable
1: path to where file is stored
2: whatever we pass in

	> node ./keygen.js hello
	0:/usr/local/bin/node
	1:/Users/user/Documents/GitHub/youtube_decypher-media_ethereum-dapp/eth-keypairs/keygen.js
	2:hello

See keygen.js file. Pass as argument the private key (don't include 0x)

	> node ./keygen b68fe43f0d1a0d7aef123722670be50268e15365401c442f8806ef83b612976b
	0x9d39856f91822ff0bdc2e234bb0d40124a201677

### Other functions using your keypairs

- You can sign arbitrary strings of data with your private key, then verify that it was signed with your private key using the public key. 