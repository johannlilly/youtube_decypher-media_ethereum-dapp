	> var Web3 = require("web3")

instantiate

	> var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))

confirm: get private keys

	> web3.eth.accounts

get private key of first account

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


## Dive further into transactions and customize them

whenever we call a function in our node console, we can see something being logged in our testRPC console. 

	> balance(acct1)
	95.99832

	eth_getBalance

These methods that get logged (like eth_getBalance) are the actual RPC methods used in the Ethereum protocol. The web3 javascript library defines an interface into those methods that is a few layers of abstraction above the underlying protocol methods. When you call web3.eth.sendTransaction(), this already knows how to interop with out private keys that are created when testRPC is created. We don't need to sign data manually. But, maybe we would want to do that, such as signing offline. We might want to send a transaction offline. We might want to sign the data that we would otherwise pass in to web3.eth.sendTransaction() using our private key, then transfer that to an online computer for better security, then send the transaction.

ethereumjs-tx requires us to pass data structures to it in the form of a javascript buffer instead of a string. We should have access to the Buffer class by default because we are using node.js.

	> web3.eth.accounts[0]
	'0x597787c52e359de807c0f28ba5c771ba35a123e1'
	> var pKey1 = '0x597787c52e359de807c0f28ba5c771ba35a123e1'
	undefined
	> var EthTx = require("ethereumjs-tx")
	undefined
	> var pKey1x = new Buffer(pKey1, 'hex')
	undefined
	> pKey1x
	<Buffer >

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

