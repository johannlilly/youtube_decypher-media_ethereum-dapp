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