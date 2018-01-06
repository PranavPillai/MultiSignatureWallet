pragma solidity ^0.4.15;

contract MultiSignatureWallet {

    uint nonce;

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


    /// @dev Allows a transaction to be sent from this multi-sig
    /// @param sigV Array of r inputs for ECDSA signatures from owners
    /// @param sigR Array of r inputs for ECDSA signatures from owners
    /// @param sigS Array of s inputs for ECDSA signatures from owners
    /// @param destination Transaction target address.
    /// @param value Transaction ether value.
    /// @param data Transaction data payload.
    function execute(uint8[] sigV, bytes32[] sigR, bytes32[] sigS, address destination, uint value, bytes data) {
      // NOTE: addresses recovered from signatures must be strictly increasing
    }
}
