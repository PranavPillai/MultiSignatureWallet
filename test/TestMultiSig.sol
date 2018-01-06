pragma solidity ^0.4.15;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MultiSignatureWallet.sol";
import "../contracts/Proxy.sol";

contract TestMultiSig {
	//deploy MultiSignature Wallet contract and Proxy Contracct
	MultiSignatureWallet multisig = MultiSignatureWallet(DeployedAddresses.MultiSignatureWallet());
	Proxy proxy = new Proxy();
	//set up array to proxies to be used as owners of the MultiSignatureWallet
	address[] proxies = new address[](1);
	proxies[0] = address(proxy);
	multisig.MultiSignatureWallet(proxies, 1);
	//test 
}