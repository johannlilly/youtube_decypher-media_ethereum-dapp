# Ultimate Introduction to Ethereum Ðapp Development
by Decypher Media
- [GitHub](https://github.com/AlwaysBCoding)
- [YouTube](https://www.youtube.com/channel/UC8CB0ZkvogP7tnCTDR-zV7g)
- [Twitter](https://twitter.com/AlwaysBCoding)
- [LinkedIn](https://www.linkedin.com/in/alwaysbcoding)

- [Ultimate Introduction to Ethereum Ðapp Development](https://www.youtube.com/playlist?list=PLV1JDFUtrXpFh85G-Ddyy2kLSafaB9biQ) [playlist]
- [Ultimate Intro to Ethereum Ðapp Development [Part 1] - Provisioning the Development Environment](https://youtu.be/rmtsh7Q7sbE)
- [Ultimate Intro to Ethereum Ðapp Development [Part 2] - Creating Ethereum Keypairs](https://youtu.be/YWoBeoTUrYM)
- [Ultimate Intro to Ethereum Ðapp Development [Part 3] - The Halting Problem and Why We Need Gas](https://youtu.be/eyh4g0XPX9Q)
- [Ultimate Intro to Ethereum Ðapp Development [Part 4] - Introduction to Transactions](https://youtu.be/-5LhwoCcjp0)
- [Ultimate Intro to Ethereum Ðapp Development [Part 5] - Sending Transactions with User Interfaces](https://youtu.be/fagSvhbSk1k)
- [Ultimate Intro to Ethereum Ðapp Development [Part 6] - Sending Transactions with Code](https://www.youtube.com/watch?v=BFEzWYFZ7wA&index=6&list=PLV1JDFUtrXpFh85G-Ddyy2kLSafaB9biQ)
- [Ultimate Intro to Ethereum Ðapp Development [Part 7] - Smart Contracts - Hello World](https://youtu.be/cRg2m2A2NGM)
- [Ultimate Intro to Ethereum Ðapp Development [Part 8] - Smart Contracts - Escrow](https://youtu.be/EbWKtDPFPz8)
- [Ultimate Intro to Ethereum Ðapp Development [Part 9] - Smart Contracts - Coin Flipper (1/2)](https://youtu.be/OFPBSKd6us8)
- [Ultimate Intro to Ethereum Ðapp Development [Part 10] - Smart Contracts - Coin Flipper (2/2)](https://youtu.be/dq-gBPvDgrc)

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

## [Part 3] - The Halting Problem and Why We Need Gas

create temp.js

	var condition1 = function() {
		return true
	}
	var condition2 = function() {
		return true
	}
	if(condition1() && condition2()) {
		console.log("The statement is true")
	}

	> node temp.js
	The statement is true

add console.log() to functions and check order of evaluation

	> node temp.js
	Condition 1 is being evaluated
	Condition 2 is being evaluated
	The statement is true

But what if the first condition returns false?

	> node temp.js
	Condition 1 is being evaluated

Condition 2 never gets evaluated. If we know the first condition returns false during evaluation, then there is no need to call the other function. We know the entire condition will be false. 

Create different functions: returnsTrue(), infiniteLoop(), and contradiction(). This is proof by contradiction.

### Ethereum and the halting problem

When Ethereum was first conceived, they had to find a workaround for this halting problem, because the Ethereum Virtual Machine (EVM) allows for arbitrary computation of other people's code. Because it is impossible to statically analyze code and determine whether or not it will terminate in finite time, it led to the very real possibility that the Ethereum network could be DDOS'd very easily by people deploying infinite loops and people wasting computational resources trying to determine if the loops were infinite.

The workaround for this problem is the concept of gas. The code that runs the contracts on the Ethereum network is the bytecode of the Ethereum Virtual Machine. If you're writing contracts in a language like Solidity, its going to compile your contracts down into EVM opcodes.

> The full list of EVM opcodes is defined in the [Ethereum Yellow Paper](https://github.com/ethereum/yellowpaper), or see the [StackExchange list](https://ethereum.stackexchange.com/questions/119/what-opcodes-are-available-for-the-ethereum-evm).

Each opcode has a fixed amount of gas associated with it. Think of it like a fee for each computational step that you execute on the network. For example, taking the SHA3 hash of a string costs 30 gas (as of 2017 November). Generating a transaction, Param GTX, costs 21000 gas. The point is: you pay for your computation. It is the burden of whoever calls the function on the Ethereum network to pay the computational cost of executing that function. This shields the network against DDOS attacks.

### Gas exchange rate

There is a gas exchange rate determined by miners on the network. You can go to [ETHStats](https://ethstats.net) to see a list of statistics about the netowrk in real time, as well as the exchange rate. 

## [Part 4] - Introduction to Transactions

	> var Web3 = require("web3")

instantiate

	> var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))

confirm: get accounts

	> web3.eth.accounts

get wallet address of first account

	> web3.eth.accounts[0]

check the balance

	> web3.eth.getBalance(web3.eth.accounts[0])
	BigNumber { s: 1, e: 20, c: [ 1000000 ] }
	// in ether
	> web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]), 'ether')
	BigNumber { s: 1, e: 2, c: [ 100 ] }
	> web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]), 'ether').toNumber()
	100

create some helper functions to prevent being too verbose

	> var acct1 = web3.eth.accounts[0]
	undefined
	> var acct2 = web3.eth.accounts[1]
	undefined
	> var balance = (acct) => { return web3.fromWei(web3.eth.getBalance(acct), 'ether').toNumber() }
	undefined
	> balance(acct1)
	100

Try sending ETH from one account to the other. value is in Wei.
> sendTransaction(account from, account to, how much wei you want to send, gas limit, gas price you want to pay)
> On the mainnet, you have to set the gas price you are willing to pay to at least the market value: the value the miners have collectively agreed upon. To set the gas price higher, it means your transaction will be mined faster. 

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000})
	'0x0b36c4d9e07222cbb6e3962dc496c811585115f56c11fe8b188ef1f6f1ef737c'
	var txHash = _
	undefined

confirm balance balance of address from

	> balance(acct2)
	101

confirm balance of address to

	> balance(acct1)
	98.99958

the balance is less than -2 because of the gas price. we can reverse-engineer this.

	> parseInt(web3.toWei(balance(acct1)))
	98999580000000000000
	> 21000 * 20000000000
	420000000000000
	> parseInt(web3.toWei(balance(acct1)))
	98999580000000000000
	> 420000000000000 + _
	99000000000000000000	

we can also use the txHash string to get information about the transaction

	> txHash
	'0x0b36c4d9e07222cbb6e3962dc496c811585115f56c11fe8b188ef1f6f1ef737c'
	> web3.eth.getTransaction(txHash)
	{ hash: '0x0b36c4d9e07222cbb6e3962dc496c811585115f56c11fe8b188ef1f6f1ef737c',
	  nonce: 0,
	  blockHash: '0xcb306f29a3d34b4211f49e0c1eb29d028276561afb4a66430981f41a778d6626',
	  blockNumber: 1,
	  transactionIndex: 0,
	  from: '0x597787c52e359de807c0f28ba5c771ba35a123e1',
	  to: '0x32ac9ea47971bc6bc70afe541265b012da7ab404',
	  value: BigNumber { s: 1, e: 18, c: [ 10000 ] },
	  gas: 90000,
	  gasPrice: BigNumber { s: 1, e: 10, c: [ 20000000000 ] },
	  input: '0x0' }

- *blockHash*: the hash of the block the transaction was mined in
- *blockNumber*: the block number in this local blockchain
- *input*: any arbitrary input data given to the transaction
- *nonce*: a mechanism to make sure yu don't send duplicate transactions to the Ethereum blockchain. it is an auto-incrementing number that needs to be unique as it relates to a 'from' address. This way, an address can't send a duplicate transaction. The nonce would conflict.

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000, nonce: 0})
	Error: Error: the tx doesn't have the correct nonce. account has nonce of: 1 tx has nonce of: 0

A transaction with a nonce of 1 is expected next. 

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000})
	'0x97bdb0e4e6fec4f5ee65ba772140c69d59f17c7be70e023b5bc9ae48f251b579'
	> var txHash = _
	undefined
	> txHash
	'0x97bdb0e4e6fec4f5ee65ba772140c69d59f17c7be70e023b5bc9ae48f251b579'
	> web3.eth.getTransaction(txHash)
	{ hash: '0x97bdb0e4e6fec4f5ee65ba772140c69d59f17c7be70e023b5bc9ae48f251b579',
	  nonce: 1,
	  blockHash: '0x88ca25f248049f014daa6060908cd27b9b5d862a181397752f34b6aa176a2403',
	  blockNumber: 2,
	  transactionIndex: 0,
	  from: '0x597787c52e359de807c0f28ba5c771ba35a123e1',
	  to: '0x32ac9ea47971bc6bc70afe541265b012da7ab404',
	  value: BigNumber { s: 1, e: 18, c: [ 10000 ] },
	  gas: 90000,
	  gasPrice: BigNumber { s: 1, e: 10, c: [ 20000000000 ] },
	  input: '0x0' }

set the nonce manually, without conflicting

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000, nonce: 2})
	'0x3b96323ee6f07f5b56bb404b377668a6af25121c7217b797d19dcad19a50e57b'

check number of transactions

	> web3.eth.getTransactionCount(acct1)
	3

we can use this to manually set the nonce

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000, nonce: web3.eth.getTransactionCount(acct1)})
	'0xdc6bc3d99ac1e37ce68dfe797a24d7351e612b79afcbe543fc562d1dae4c7816'
	> web3.eth.getTransactionCount(acct1)
	4

the transaction is also rejected if the nonce is not incremented by 1

	> web3.eth.sendTransaction({from: acct1, to: acct2, value: web3.toWei(1, 'ether'), gasLimit: 21000, gasPrice: 20000000000, nonce: 12})
	Error: Error: the tx doesn't have the correct nonce. account has nonce of: 4 tx has nonce of: 12 

Every transaction that gets put on the blockchain must have the correct sequential nonce


### Dive further into transactions and customize them

whenever we call a function in our node console, we can see something being logged in our testRPC console. 

	> balance(acct1)
	95.99832

	eth_getBalance

These methods that get logged (like eth_getBalance) are the actual RPC methods used in the Ethereum protocol. The web3 javascript library defines an interface into those methods that is a few layers of abstraction above the underlying protocol methods. When you call web3.eth.sendTransaction(), this already knows how to interop with out private keys that are created when testRPC is created. We don't need to sign data manually. But, maybe we would want to do that, such as signing offline. We might want to send a transaction offline. We might want to sign the data that we would otherwise pass in to web3.eth.sendTransaction() using our private key, then transfer that to an online computer for better security, then send the transaction.

ethereumjs-tx requires us to pass data structures to it in the form of a javascript buffer instead of a string. We should have access to the Buffer class by default because we are using node.js. Use the private key of the first account from testRPC.

	> var pKey1 = '5fa61fe5ed86b6ae9e5d55439d9a78a7c7b21a71a513e73724eeec742427c3a4'
	undefined
	> var EthTx = require("ethereumjs-tx")
	undefined
	> var pKey1x = new Buffer(pKey1, 'hex')
	undefined
	> pKey1x
	<Buffer 5f a6 1f e5 ed 86 b6 ae 9e 5d 55 43 9d 9a 78 a7 c7 b2 1a 71 a5 13 e7 37 24 ee ec 74 24 27 c3 a4>


### Create a raw transaction data structure and sign it with our private key

Next, we need to create a raw transaction data structure and sign it with our private key. A *raw transaction data structure* is a JavaScript object with key-value pairs, but we need to encode each integer of that key-value pair into hexidecimal before we sign it.

	> var rawTx = {
	... nonce: web3.toHex(web3.eth.getTransactionCount(acct1)),
	... to: acct2,
	... gasPrice: web3.toHex(20000000000),
	... gasLimit: web3.toHex(21000),
	... value: web3.toHex(web3.toWei(23, 'ether')),
	... data: ""
	... }
	undefined
	> rawTx
	{ nonce: '0x4',
	  to: '0x32ac9ea47971bc6bc70afe541265b012da7ab404',
	  gasPrice: '0x4a817c800',
	  gasLimit: '0x5208',
	  value: '0x13f306a2409fc0000',
	  data: '' }

next, we need to sign this. 

	> var tx = new EthTx(rawTx)
	undefined
	> tx.sign(pKey1x)
	undefined
	> tx.serialize().toString('hex')
	'f86d048504a817c8008252089432ac9ea47971bc6bc70afe541265b012da7ab40489013f306a2409fc0000801ca05295fb07b5a68ddcd1e623eb79e1a9ce51c57eb3c563de27e442b7fb5185bb2ca05b0fd6381266fcb22558f2e9d389d0f2ea390eadf692ef5a10940ffc3ecd9a5d'

That final string -- that signed transaction -- we can pass that around securely. It contains the transaction data. You can create it offline then take it to an online computer to send the transaction. The transaction you use to send the signed transaction is not sendTransaction(), but sendRawTransaction(). You don't pass the serialized transaction string, you send it with 0x in front of it. You get a function as a callback that includes either an error or data from the network. 

	> web3.eth.sendRawTransaction(`0x${tx.serialize().toString('hex')}`, (error, data) => {
	... if(!error) {console.log(data) }
	... })
	undefined
	> 0x6751ae5f2baef8e23b6d3cc9fd51eb5ef1ebd1a61fe3f5d54b28b12974c8cf10

check RPC to see if transaction went through

	eth_sendRawTransaction

	  Transaction: 0x6751ae5f2baef8e23b6d3cc9fd51eb5ef1ebd1a61fe3f5d54b28b12974c8cf10
	  Gas usage: 21000
	  Block Number: 5
	  Block Time: Sun Mar 25 2018 14:48:14 GMT+0200 (CEST)

Now, lets inspect the returned data. It is just as we encoded.

> web3.eth.getTransaction('0x6751ae5f2baef8e23b6d3cc9fd51eb5ef1ebd1a61fe3f5d54b28b12974c8cf10')
{ hash: '0x6751ae5f2baef8e23b6d3cc9fd51eb5ef1ebd1a61fe3f5d54b28b12974c8cf10',
  nonce: 4,
  blockHash: '0xb4ad5599aa4f5700b6f1c4f9af0afea4db5ac22aee5c806846141bf8e1a262bd',
  blockNumber: 5,
  transactionIndex: 0,
  from: '0x597787c52e359de807c0f28ba5c771ba35a123e1',
  to: '0x32ac9ea47971bc6bc70afe541265b012da7ab404',
  value: BigNumber { s: 1, e: 19, c: [ 230000 ] },
  gas: 21000,
  gasPrice: BigNumber { s: 1, e: 10, c: [ 20000000000 ] },
  input: '0x0' }

Check the balances

	> balance(acct1)
	72.9979
	> balance(acct2)
	127

## [Part 5] - Sending Transactions with User Interfaces

https://www.myetherwallet.com/

https://ropsten.etherscan.io/

https://metamask.io

## [Part 6] - Sending Transactions with Code

Easily exchange one digital currency for another: [https://shapeshift.io](https://shapeshift.io)

Interact with the EVM using a Chrome extension: [https://metamask.io/](https://metamask.io/)

Interact directly with the EVM using a website interface / GUI: [https://www.myetherwallet.com](https://www.myetherwallet.com)

Ethereum transactions and balances: [https://etherscan.io](https://etherscan.io)

Ethereum - Ropsten - Faucet
http://faucet.ropsten.be:3001/

Jaxx: Our digital asset wallet, Jaxx, was created in 2014 by Ethereum co-founder Anthony Diiorio. We now have dozens of blockchain tokens available and a wallet that runs on iOS, Android, Windows, Mac, and other platforms: [https://jaxx.io/](https://jaxx.io/).

INFURA: Our easy to use API and developer tools provide secure, reliable, and scalable access to Ethereum and IPFS (InterPlanetary File System). We provide the infrastructure for your decentralized applications so you can focus on the features. Connect to the Ethereum main net with node: [https://infura.io/](https://infura.io/)

BlockCypher: APIs for interacting with both Ethereum and Bitcoin blockchain. It gives us more in-depth ways of interacting with the Ethereum network than webRTC. You can use it to send ETH transactions from your command line using the curl command: [https://www.blockcypher.com/](https://www.blockcypher.com/)

## [Part 7] - Smart Contracts - Hello World

	> var Web3 = require("web3")
	undefined
	> var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
	undefined
	> var solc = require("solc")
	undefined

	> var source = `contract HelloWorld {
	...     function displayMessage() constant returns (string) {
	.....         return "Hello from a smart contract";
	.....     }
	... }
	... `
	undefined
	> source
	'contract HelloWorld {\n    function displayMessage() constant returns (string) {\n        return "Hello from a smart contract";\n    }\n}\n'
	> var compiled = solc.compile(source)
	undefined
	> compiled
	{ contracts:
	   { ':HelloWorld':
	      { assembly: [Object],
	        bytecode: '6060604052341561000f57600080fd5b6101578061001e6000396000f300606060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632d59dc1214610046575b600080fd5b341561005157600080fd5b6100596100d4565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561009957808201518184015260208101905061007e565b50505050905090810190601f1680156100c65780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6100dc610117565b6040805190810160405280601b81526020017f48656c6c6f2066726f6d206120736d61727420636f6e74726163740000000000815250905090565b6020604051908101604052806000815250905600a165627a7a723058206d42a190f07f11596be998f1aa57d279dc34a2ed937b37ae1a8ca76a4f986fd20029',
	        functionHashes: [Object],
	        gasEstimates: [Object],
	        interface: '[{"constant":true,"inputs":[],"name":"displayMessage","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]',
	        metadata: '{"compiler":{"version":"0.4.21+commit.dfe3193c"},"language":"Solidity","output":{"abi":[{"constant":true,"inputs":[],"name":"displayMessage","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}],"devdoc":{"methods":{}},"userdoc":{"methods":{}}},"settings":{"compilationTarget":{"":"HelloWorld"},"evmVersion":"byzantium","libraries":{},"optimizer":{"enabled":false,"runs":200},"remappings":[]},"sources":{"":{"keccak256":"0x200c97b5a8d0d5aa1ac075ad1e9b052b605c23d356cd6ee292365ed72f6b8805","urls":["bzzr://d1c84f8748c0b04a85d8544aa3130f025ff1760f76163cb9a148ef819c229000"]}},"version":1}',
	        opcodes: 'PUSH1 0x60 PUSH1 0x40 MSTORE CALLVALUE ISZERO PUSH2 0xF JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST PUSH2 0x157 DUP1 PUSH2 0x1E PUSH1 0x0 CODECOPY PUSH1 0x0 RETURN STOP PUSH1 0x60 PUSH1 0x40 MSTORE PUSH1 0x4 CALLDATASIZE LT PUSH2 0x41 JUMPI PUSH1 0x0 CALLDATALOAD PUSH29 0x100000000000000000000000000000000000000000000000000000000 SWAP1 DIV PUSH4 0xFFFFFFFF AND DUP1 PUSH4 0x2D59DC12 EQ PUSH2 0x46 JUMPI JUMPDEST PUSH1 0x0 DUP1 REVERT JUMPDEST CALLVALUE ISZERO PUSH2 0x51 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST PUSH2 0x59 PUSH2 0xD4 JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 DUP1 PUSH1 0x20 ADD DUP3 DUP2 SUB DUP3 MSTORE DUP4 DUP2 DUP2 MLOAD DUP2 MSTORE PUSH1 0x20 ADD SWAP2 POP DUP1 MLOAD SWAP1 PUSH1 0x20 ADD SWAP1 DUP1 DUP4 DUP4 PUSH1 0x0 JUMPDEST DUP4 DUP2 LT ISZERO PUSH2 0x99 JUMPI DUP1 DUP3 ADD MLOAD DUP2 DUP5 ADD MSTORE PUSH1 0x20 DUP2 ADD SWAP1 POP PUSH2 0x7E JUMP JUMPDEST POP POP POP POP SWAP1 POP SWAP1 DUP2 ADD SWAP1 PUSH1 0x1F AND DUP1 ISZERO PUSH2 0xC6 JUMPI DUP1 DUP3 SUB DUP1 MLOAD PUSH1 0x1 DUP4 PUSH1 0x20 SUB PUSH2 0x100 EXP SUB NOT AND DUP2 MSTORE PUSH1 0x20 ADD SWAP2 POP JUMPDEST POP SWAP3 POP POP POP PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST PUSH2 0xDC PUSH2 0x117 JUMP JUMPDEST PUSH1 0x40 DUP1 MLOAD SWAP1 DUP2 ADD PUSH1 0x40 MSTORE DUP1 PUSH1 0x1B DUP2 MSTORE PUSH1 0x20 ADD PUSH32 0x48656C6C6F2066726F6D206120736D61727420636F6E74726163740000000000 DUP2 MSTORE POP SWAP1 POP SWAP1 JUMP JUMPDEST PUSH1 0x20 PUSH1 0x40 MLOAD SWAP1 DUP2 ADD PUSH1 0x40 MSTORE DUP1 PUSH1 0x0 DUP2 MSTORE POP SWAP1 JUMP STOP LOG1 PUSH6 0x627A7A723058 KECCAK256 PUSH14 0x42A190F07F11596BE998F1AA57D2 PUSH26 0xDC34A2ED937B37AE1A8CA76A4F986FD200290000000000000000 ',
	        runtimeBytecode: '606060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632d59dc1214610046575b600080fd5b341561005157600080fd5b6100596100d4565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561009957808201518184015260208101905061007e565b50505050905090810190601f1680156100c65780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6100dc610117565b6040805190810160405280601b81526020017f48656c6c6f2066726f6d206120736d61727420636f6e74726163740000000000815250905090565b6020604051908101604052806000815250905600a165627a7a723058206d42a190f07f11596be998f1aa57d279dc34a2ed937b37ae1a8ca76a4f986fd20029',
	        srcmap: '0:133:0:-;;;;;;;;;;;;;;;;;',
	        srcmapRuntime: '0:133:0:-;;;;;;;;;;;;;;;;;;;;;;;;26:105;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;23:1:-1;8:100;33:3;30:1;27:10;8:100;;;99:1;94:3;90:11;84:18;80:1;75:3;71:11;64:39;52:2;49:1;45:10;40:15;;8:100;;;12:14;26:105:0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;70:6;;:::i;:::-;88:36;;;;;;;;;;;;;;;;;;;;26:105;:::o;0:133::-;;;;;;;;;;;;;;;:::o' } },
	  errors:
	   [ ':2:5: Warning: No visibility specified. Defaulting to "public".\n    function displayMessage() constant returns (string) {\n    ^ (Relevant source part starts here and spans across multiple lines).\n',
	     ':1:1: Warning: Source file does not specify required compiler version!Consider adding "pragma solidity ^0.4.21;"\ncontract HelloWorld {\n^ (Relevant source part starts here and spans across multiple lines).\n',
	     ':2:5: Warning: Function state mutability can be restricted to pure\n    function displayMessage() constant returns (string) {\n    ^ (Relevant source part starts here and spans across multiple lines).\n' ],
	  sourceList: [ '' ],
	  sources: { '': { AST: [Object] } } }

	  > compiled.contracts.HelloWorld.bytecode
	  > compiled.contracts.HelloWorld.opcodes
	  > compiled.contracts.HellowWorld.interface
	  > var abi = JSON.parse(compiled.contracts.HelloWorld.interface)
	  undefined
	  abi
	  [ { constant: true,
	  	  inputs: [],
	  	  name: 'displayMessage',
	  	  outputs: [ [Object ] ],
	  	  payable: false,
	  	  type: 'function' } ]

Use [Remix - Solidity IDE](https://remix.ethereum.org) to get an estimate of how much gas you will need.

	> var helloWorldContract = web3.eth.contract(abi)
	undefined
	var deployed = helloWorldContract.new({
	... from: web3.eth.accounts[0],
	... data: compiled.contracts.HelloWorld.bytecode,
	... gas: 4700000,
	... gasPrice: 5,
		}, (error, contract) => {})
	undefined

If you check TestRPC. you will see a transaction ID as well as a contract address. Contracts have their own addresses, just like wallets.

	// input bytecode of the transaction
	> web3.eth.getTransaction(transactionID)

Now the deployed object (var deployed = ...) returned from the contract creation call is a reference to the deployed contract on a network.

	> deployed.address
	// returns address of the contract

	// in case you didn't capture that oject before, instantiate a new reference to it:
	> helloWorldContract.at(address)

Once you have the reference to the deployed contract, you can call functions on it that are publicly exposed. 

	> deployed.displayMessage.call()
	'Hello from a smart contract'

here is the contract file:

	contract HelloWorld {
		function displayMessage() constant returns (string) {
			return "Hello from a smart contract";
		}
	}

*constant* indicates that the function will not modify state on the Ethereum network in any way, no matter how many times it is called. Everyone else's contracts won't be affected at all. When you call the function deployed.displayMessage.call(), the message "Hello from a smart contract" is returned to you in realtime without having to query the network. It can cache this locally. 

	> deployed.displayMessage.call()
	'Hello from a smart contract'


## [Part 8] - Smart Contracts - Escrow

Contracts can have state that they store inside the contract and persist in the blockchain.

### public keyword

By using 'public,'' you are creating an accessor method that anybody who knows the address of the contract address can query for the state of that variable at any time.

### Constructor

A constructor is a function that has the same name as name of contract. It runs once and only once: upon creation of the contract, and never again. This is where you deal with initialization. 

#### constructor arguments

The constructor can take statically-typed arguments. These variables are defined upon creation of the contract. In our example, set the state and arbiter variables to the arguments passed to the constructor. 

### msg object

msg object contains information about the transaction that is calling into the current contract. In the case of a constructor function, the transaction calling into is also the transaction that is creating the function.

#### msg.sender

Access the address of whoever is calling the contract 

### compile

	> var Web3 = require("web3")
	undefined
	> var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
	undefined
	> var solc = require("solc")
	undefined
	> var source = `
	... contract Escrow {
	...
	...     address public buyer;
	...     address public seller;
	...     address public arbiter;
	...
	...     // constructor
	...     function Escrow(address _seller, address _arbiter) {
	...         buyer = msg.sender; // assume the buyer is creating this Escrow contract
	...         seller = _seller; // set the state variable of seller to the argument
	...         arbiter = _arbiter; // set the state variable of arbiter to the argument
	...     }
	...
	... }
	... `
	undefined
	> var buyer = web3.eth.accounts[0] ; var seller = web3.eth.accounts[1] ; var arbiter = web3.eth.accounts[2]
	undefined

	> var compiled = solc.compile(source)
	undefined
	> var bytecode = compiled.contracts[":Escrow"].bytecode
	undefined
	> var abi = JSON.parse(compiled.contracts.Escrow.interface)
	TypeError: Cannot read property 'interface' of undefined
	> var abi = JSON.parse(compiled.contracts[":Escrow"].interface)
	undefined
	> abi
	[ { constant: true,
	    inputs: [],
	    name: 'seller',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { constant: true,
	    inputs: [],
	    name: 'buyer',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { constant: true,
	    inputs: [],
	    name: 'arbiter',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { inputs: [ [Object], [Object] ],
	    payable: false,
	    stateMutability: 'nonpayable',
	    type: 'constructor' } ]
	>

In the abi object, we have functions created with the same names as the public variables previously declared. These are the GETter functions for those variables. We also have a constructor function.

	> var escrowContract = web3.eth.contract(abi)
	undefined

deploy contract, but don't pass in a data structure. We want the constructor to take in two parameters, so we pass them in first, then pass in the data structure.

	> var deployed = escrowContract.new(seller, arbiter, {
	... from: buyer,
	... data: bytecode,
	... gas: 4700000,
	... gasPrice: 5,
	... }, (error, contract) => {})
	undefined

Check for a contract address (meaning the transaction was mined)

	> deployed.address
	'0x674ededca93f8b5bbfd829d3120aedf6d1af2143'

Query this for publicly accessible methods, then confirm by checking the buyer object value.

	> deployed.buyer.call()
	'0xbba627fba18f285597e89a2eec3a4274c1d033ce'
	> buyer
	'0xbba627fba18f285597e89a2eec3a4274c1d033ce'
	> deployed.seller.call()
	'0x4b4d1f8fad9d546f2979831a3e527489bb52f24a'
	> seller
	'0x4b4d1f8fad9d546f2979831a3e527489bb52f24a'
	> deployed.arbiter.call()
	'0x3eecacbefe89fef4d6dbd9fe0bdcd39e5895f58b'
	> arbiter
	'0x3eecacbefe89fef4d6dbd9fe0bdcd39e5895f58b'

### Implement contract logic

A contract address can store a balance in ether the same way that a normal Ethereum address can. Add back in a shorthand function to check the balance of an account.

	> var balance = (acct) => { return web3.fromWei(web3.eth.getBalance(acct), 'ether').toNumber() }
	undefined

check balance of contract

	> balance(buyer)
	83.02901999999867
	> balance(deployed.address)
	0

send ether to deployed address the same way you would send to a normal ethereum address.

	// send current balance of escrow contract to the seller
	function payourToSeller() {
		// send amount of ETH defined to the account that is calling it
		seller.send(this.balance);
	}

	function refundToBuyer() {
		buyer.send(this.balance);
	}

As it is, anybody with the abi can access these functions. 

#### secure who can access functions

		if(msg.sender == buyer || msg.sender == arbiter) {}

### compile

	> var source = `
	... contract Escrow {
	...
	...     address public buyer;
	...     address public seller;
	...     address public arbiter;
	...
	...     // constructor
	...     function Escrow(address _seller, address _arbiter) {
	...         buyer = msg.sender; // assume the buyer is creating this Escrow contract
	...         seller = _seller; // set the state variable of seller to the argument
	...         arbiter = _arbiter; // set the state variable of arbiter to the argument
	...     }
	...
	...     // send current balance of escrow contract to the seller
	...     function payourToSeller() {
	...         // send amount of ETH defined to the account that is calling it
	...         if(msg.sender == buyer || msg.sender == arbiter) {
	.....             seller.send(this.balance);
	.....         }
	...     }
	...
	...     function refundToBuyer() {
	...         if(msg.sender == seller || msg.sender == arbiter) {
	.....             buyer.send(this.balance);
	.....         }
	...     }
	...
	...     // accessor function
	...     function getBalance() constant returns (uint) {
	...         return this.balance;
	...     }
	...
	... }
	... `
	undefined
	> var compiled = solc.compile(source)
	undefined
	> var bytecode = compiled.contracts[":Escrow"].bytecode
	undefined
	> var abi = JSON.parse(compiled.contracts[":Escrow"].interface)
	undefined

	> var escrowContract = web3.eth.contract(abi)
	undefined
	> abi
	[ { constant: true,
	    inputs: [],
	    name: 'seller',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { constant: true,
	    inputs: [],
	    name: 'getBalance',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { constant: false,
	    inputs: [],
	    name: 'payourToSeller',
	    outputs: [],
	    payable: false,
	    stateMutability: 'nonpayable',
	    type: 'function' },
	  { constant: false,
	    inputs: [],
	    name: 'refundToBuyer',
	    outputs: [],
	    payable: false,
	    stateMutability: 'nonpayable',
	    type: 'function' },
	  { constant: true,
	    inputs: [],
	    name: 'buyer',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { constant: true,
	    inputs: [],
	    name: 'arbiter',
	    outputs: [ [Object] ],
	    payable: false,
	    stateMutability: 'view',
	    type: 'function' },
	  { inputs: [ [Object], [Object] ],
	    payable: false,
	    stateMutability: 'nonpayable',
	    type: 'constructor' } ]
	

#### create new 'deployed' var, add a value field.

The value field is the amount of ETH we want to send to the contract upon creation. If we put it in the constructor of the contract, this will send ETH to the contract on creation.

	> var deployed = escrowContract.new(seller, arbiter, {
	... from: buyer,
	... data: bytecode,
	... gas: 4700000,
	... gasPrice: 5,
	... value: web3.toWei(5, 'ether')
	... }, (error, contract) => {})
	undefined

	> balance(deployed.address)
	5
	deployed.payoutToSeller({from: buyer})
	// tx hash
	> balance(seller)
	105
	balance(deployed.address)
	0



## [Part 9] - Smart Contracts - Coin Flipper (1/2)

enum is a fixed set of values that a variable can have. Any other value that a variable of type GameState has will be invalid.

> Be careful when passing a string as an argument in Solidity. You declare it as datatype bytes32. 

	> var deployed = decypher.deployContract("flipper")
	undefined
	> deployed.address
	'0x225fb4af9b8876466617020e5bf2f0672686bca9'
	> deployed.currentState.call()
	BigNumber { s: 1, e: 0, c: [ 0 ] }

c: [0] represents a state of index 0 in the GameState, which is 'noWager.'

	> deployed.transitionGameState("wagerMade", {from: acct1})
	'0x0640b73ab9a3b8b4e6b2f020d1269da56c8487efab912f7b26f4c19715ecc208'

call invalid game state: still in state 1 (as in, wagerMade)

	> deployed.transitionGameState("xyz", {from: acct1})
	'0x144787f48050531daff7d8a7a95629549e6c37886b465b2b3fd53216ab776d3e'
	> deployed.currentState.call()
	BigNumber { s: 1, e: 0, c: [ 1 ] }


valid GameState:

	> deployed.transitionGameState("wagerAccepted", {from: acct1})
	'0xb0dd931a9ffbd128d08207cdff995e1c6a91d6ba5b67da8facc95754d53d7b4d'
	> deployed.currentState.call()
	BigNumber { s: 1, e: 0, c: [ 2 ] }

### state order using modifiers

We don't want to change state out of order, or when certain conditions haven't yet been met. Use a modifier. A *modifier* is a way for you to put reusable code into function definitions that can ensure some sort of data is valid before proceeding with the function.

When writing the code for a modifier, when you include *_;* in a code block, you are saying to delegate to the function that uses this modifier. Think, replace *_;* with the definition of the function. 

#### throw

All state transitions (from a transaction) are atomic. Everything within a code block must be true for the block to work. You can't have a partial update. It all succeeds or fails together. *Throw* drains the transaction of all of its gas so that none of the state transitions are valid, so the entire thing is as if it never happened. 

### attempt changing state

	> var deployed = decypher.deployContract("flipper")
	undefined
	> deployed.currentState.call()
	BigNumber { s: 1, e: 0, c: [ 0 ] }
	> deployed.makeWager({from: acct1})
	'0x79005ec9864fd6187c45f4ab999b7e9dba632a226811195570f44076e236e081'
	> deployed.currentState.call()
	BigNumber { s: 1, e: 0, c: [ 1 ] }

make a jump you are not allowed to make:

	> deployed.resolveBet({from: acct1})
	Error: VM Exception while processing transaction: revert

## [Part 10] - Smart Contracts - Coin Flipper (2/2)

