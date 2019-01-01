'use strict'

// 连接区块链节点，初始化web3对象
const web3 = new Web3('https://api.truescan.net/rpc')

// 根据合约接口ABI配置和合约地址，初始化智能合约对象
// 这个合约地址就是我们的地址向这个合约地址发送数据的，其中有gas费用
const contractAddress = '0x6e5E51D7120ddaA0F2d88d51b99029FC32ECfAD5'
const contractObj = new web3.eth.Contract(abi, contractAddress)

// console.log(web3.utils.toWei("1", "ether"))
// 1 eth = 1000000000000000000

// 导入账户，用于支付交易产生的手续费
var privateKey,account;
document.querySelector('#add-button').onclick = function setAdd () {
  privateKey = document.querySelector('#add').value
  account = web3.eth.accounts.privateKeyToAccount(privateKey)
  web3.eth.accounts.wallet.add(account)
  //console.log(web3.eth.accounts.wallet)
}

async function get () {
  // 智能合约的查询方法，不需要指定手续费
  return contractObj.methods.get().call()
}

async function set (input) {
  // 智能合约的查询方法，需要指定发起地址和手续费相关设置
  return contractObj.methods.set(input).send({
    from: account.address,
    gas: 3000000,
    gasPrice: 1
  })
}

document.querySelector('#set-button').onclick = function setValue () {
  const input = document.querySelector('#set').value
  const stateBox = document.querySelector('#set-states')
  stateBox.innerHTML = '发送中...'
  console.log(account.address)
  set(input).then(res => {
    console.log(res)
    stateBox.innerHTML = '上链完成'
  })
}

document.querySelector('#get-button').onclick = function getValue () {
  const getBox = document.querySelector('#get')
  get().then(res => {
    console.log(res)
    getBox.innerHTML = res
  })
}