pragma solidity ^0.4.15;

contract MultiSignatureWallet {

    mapping(address => bool) owners;
    uint requiredConfirmers;

    struct Transaction {
      bool isValue;
      bool executed;
      address destination;
      uint value;
      bytes data;
      uint numConfirmed;
      mapping(address => bool) confirmed;
    }

    mapping(uint => Transaction) transactions;

    /// @dev Fallback function, which accepts ether when sent to contract
    function() public payable {}

    /*
     * Public functions
     */
    /// @dev Contract constructor sets initial owners and required number of confirmations.
    /// @param _owners List of initial owners.
    /// @param _required Number of required confirmations.
    function MultiSignatureWallet(address[] _owners, uint _required) public {
        for(uint i = 0; i < _owners.length; i++) {
            owners[_owners[i]] = true;
        }
        requiredConfirmers = _required;
    }

    /// @dev Allows an owner to submit and confirm a transaction.
    /// @param destination Transaction target address.
    /// @param value Transaction ether value.
    /// @param data Transaction data payload.
    /// @return Returns transaction ID.
    function submitTransaction(address destination, uint value, bytes data) public returns (uint transactionId) {
        require(owners[msg.sender]);
        uint newId = uint(sha3(destination, value, data));
        transactions[newId] = Transaction(true, false, destination, value, data, 1);
        transactions[newId].confirmed[msg.sender] = true;
        return newId;
    }

    /// @dev Allows an owner to confirm a transaction.
    /// @param transactionId Transaction ID.
    function confirmTransaction(uint transactionId) public {
        require(owners[msg.sender]);
        require(!transactions[transactionId].confirmed[msg.sender]);
        require(transactions[transactionId].isValue);
        transactions[transactionId].confirmed[msg.sender] = true;
        transactions[transactionId].numConfirmed += 1;
    }

    /// @dev Allows an owner to revoke a confirmation for a transaction.
    /// @param transactionId Transaction ID.
    function revokeConfirmation(uint transactionId) public {
        require(owners[msg.sender]);
        require(transactions[transactionId].confirmed[msg.sender]);
        require(transactions[transactionId].isValue);
        transactions[transactionId].confirmed[msg.sender] = false;
        transactions[transactionId].numConfirmed -= 1;
    }

    /// @dev Allows anyone to execute a confirmed transaction.
    /// @param transactionId Transaction ID.
    function executeTransaction(uint transactionId) public {
        require(transactions[transactionId].numConfirmed >= requiredConfirmers);
        require(this.balance >= transactions[transactionId].value);
        transactions[transactionId].executed = true;
        transactions[transactionId].destination.transfer(transactions[transactionId].value);
    }
}
