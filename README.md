# youtube_decypher-media_ethereum-dapp_1
Ultimate Intro to Ethereum Ðapp Development [Part 1] - Provisioning the Development Environment by Decypher Media

## part 1

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
