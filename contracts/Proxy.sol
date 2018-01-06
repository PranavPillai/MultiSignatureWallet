import "./MultiSignatureWallet.sol";

contract Proxy {
    
    function submitTransaction(address _wallet, address destination, uint value, bytes data) {
    	MultiSignatureWallet wallet = MultiSignatureWallet(_wallet);
    	wallet.submitTransaction(destination, value, data);
    }

    function confirmTransaction(address _wallet, uint transactionId) public {
    	MultiSignatureWallet wallet = MultiSignatureWallet(_wallet);
    	wallet.confirmTransaction(transactionId);
    }

    function revokeConfirmation(address _wallet, uint transactionId) public {
    	MultiSignatureWallet wallet = MultiSignatureWallet(_wallet);
    	wallet.revokeConfirmation(transactionId);
    }

    /// @dev Allows anyone to execute a confirmed transaction.
    /// @param transactionId Transaction ID.
    function executeTransaction(address _wallet, uint transactionId) public {
    	MultiSignatureWallet wallet = MultiSignatureWallet(_wallet);
    	wallet.executeTransaction(transactionId);
    }	
}