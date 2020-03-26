# BankAccountsDB
 
## Problem statement

Design a simple database to hold information about People and their Bank Accounts.

- In this example, any one account can only belong to one person
- Balances cannot be lesser than zero

##  Transfering Funds

The database must support transfering funds between accounts.

### Problem 1
Move 10 dollars from account number #1 to account #2. Assume that account #1 has at least 10 dollars. 
	
### Problem 2 
Now, how to change the code to ensure that balance will never be < 0 and only transfer if it is possible.

## Solution

Accounts.sql and Person.sql are the corresponding scripts for creating the tables in the database, and inserting 10 people and 10 accounts.

Considerations:
- A 1 to Many relationship exists between People and Accounts

PROCEDURE MoveMoney.sql contains the STORED PROCEDURE for Money Transfering given two accounts and one amount.

Considerations:
- A transfer is considered to be two UPDATE operations.
    - One updates the sender account by substracting the desired amount from the current balance.
    - Another one updates the receiver account by adding the desired amount to the current balance.
- This is implemented using a TRANSACTION which is COMMITED if successful or ROLLEDBACK if any of the following happens:
    - An error is thrown at any point. Detected by TRY CATCH strategy.
    - One of the two accounts does not exist in the database. Resulting in a ROWCOUNT of 0 after either of the UPDATE operations.

Store procedure examples are provided at the end of the PROCEDURE MoveMoney.sql file.


## Extra question - How to make it thread safe?

BEGIN TRANSACTION does not guarantee thread safety by itself. The transaction isolation level must be set to REPEATABLE READ.

**REPEATABLE READ** 

When you set the REPEATABLE READ isolation level, you ensure that any data read by
one transaction is not changed by another transaction. That way, the transaction can repeat a
query and get identical results each time. In this case, the data is protected by shared (S) locks. <sup>[1](#note1)</sup> 

## Foot notes

<a name="mnote1">1</a>: 70-762 Developing SQL Databases: Chapter 03 Managing Concurrency, page 278.