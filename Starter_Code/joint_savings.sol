pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Define variables
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define a function named `withdraw`
    function withdraw(uint amount, address payable recipient) public {

        // Require that the recipient is either accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Require sufficient balance for the withdrawal
        require(contractBalance >= amount, "Insufficient funds!");

        // Update lastToWithdraw if recipient is different
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer funds to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount
        lastWithdrawAmount = amount;

        // Update contractBalance
        contractBalance = address(this).balance;
    }

    // Define a public payable function named `deposit`
    function deposit() public payable {
        // Update contractBalance
        contractBalance = address(this).balance;
    }

    // Define a public function named `setAccounts`
    function setAccounts(address payable account1, address payable account2) public {
        // Set accountOne and accountTwo
        accountOne = account1;
        accountTwo = account2;
    }

    // Default fallback function to accept ether sent from outside the deposit function
    function () external payable {
        // Update contractBalance
        contractBalance = address(this).balance;
    }
}
