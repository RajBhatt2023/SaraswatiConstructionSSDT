CREATE PROCEDURE [dbo].[Api_Account_VerifyEmail]
-- Api_Account_VerifyEmail 2
(
@UserId INT
)
AS
BEGIN
	BEGIN TRY
		UPDATE [dbo].[Users]
		SET EmailConfirmed = 1
		WHERE UserID = @UserId;

		SELECT '0' AS ResultCode, 
		       'Email Verified successfully.' AS ResultDescription;
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH
END