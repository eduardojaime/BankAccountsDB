DROP PROCEDURE IF EXISTS MoveMoney;
GO

-- Question 1
-- Move 10 dollars from account number #1 to account #2. Assume that account #1 has at least 10 dollars. 
	
-- Question 2 
-- Now how to change the code to ensure that balance will never be < 0 and only transfer if it is possible.
CREATE PROCEDURE MoveMoney
	@SenderAcct INT,
	@ReceiverAcct INT,
	@Amount DECIMAL(5,2)
AS
	BEGIN TRY
	-- Use this to verify if the UPDATE was applied to one record
	-- in case an account does not exist, the UPDATE operation will return 0 rows affected
	DECLARE @SenderUpdated AS INTEGER;
	DECLARE @ReceiverUpdated AS INTEGER;

	-- Question 2) VALIDATE FUNDS
	DECLARE @RemainingAmt AS DECIMAL(5,2);
	SET @RemainingAmt = (SELECT Balance - @Amount FROM Accounts WHERE Number = @SenderAcct);

	-- If new amount will be lower than 0 then print message and exit procedure
	IF (@RemainingAmt < 0)
	BEGIN
		PRINT 'NOT ENOUGH FUNDS'
		RETURN
	END
	
	-- START TRANSACTION 
	-- Both UPDATE operations must be successful for the transfer to be considered OK
	-- NOTE Transactions alone do not guarantee thread safety 
	--		Lost Update concurrency problem
	--		Change transaction isolation level to lock rows until transaction commit
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	BEGIN TRANSACTION;
	
	-- UPDATE SENDER FIRST
	UPDATE Accounts SET Balance = Balance - @Amount WHERE Number = @SenderAcct;
	SET @SenderUpdated = @@ROWCOUNT;
	SELECT * FROM Accounts WHERE Number =  @SenderAcct;


	-- UPDATE RECEIVER
	UPDATE Accounts SET Balance = Balance + @Amount WHERE Number = @ReceiverAcct;
	SET @ReceiverUpdated = @@ROWCOUNT
	SELECT * FROM Accounts WHERE Number =  @ReceiverAcct;
	
	-- SUCCESSFUL UPDATES COMMIT
	-- Both UPDATE operations must have affected 1 row each
	-- a 0 would mean an UPDATE operation applied to an unexistent record
	IF @ReceiverUpdated = 1 AND @SenderUpdated = 1
		BEGIN
			COMMIT TRANSACTION;
		END
	ELSE
		-- EITHER RECIEVER OR SENDER FAILED TO UPDATE > ROWS AFFECTED IS 0
		BEGIN
			ROLLBACK TRANSACTION;
			PRINT 'Verify sender or receiver account non-existent. TRANSACTION rolled back.'
		END

	END TRY
BEGIN CATCH
	-- IN CASE OF ANY ERRORS ROLLBACK
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
	PRINT 'TRANSACTION ERROR'
END CATCH
GO



-- Not enough funds
-- EXEC MoveMoney 137593, 120284, 100

-- Not successful, reciever does not exists
-- EXEC MoveMoney 120284, 120284111, 100

-- Successful
--EXEC MoveMoney 120284, 137593, 100