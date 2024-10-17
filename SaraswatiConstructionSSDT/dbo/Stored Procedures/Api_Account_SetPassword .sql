CREATE PROCEDURE [dbo].[Api_Account_SetPassword ]
	-- Api_Account_SetPassword 1,'lG/fJd12Xp0xsviPf9C0hw=='
(
@UserId INT, 
@HashPassword NVARCHAR(MAX)
)
AS
BEGIN
	BEGIN TRY
		DECLARE @ResultCode AS NVARCHAR(2) = '0', 
		@ResultDescription AS NVARCHAR(100) = 'Your password has been created successfully.',
		@HPassword NVARCHAR(MAX)

		SELECT @HPassword = HashPassword
		FROM [dbo].[Users]
		WHERE UserID = @UserId;

		IF (@HPassword != '')
		BEGIN
			SET @ResultDescription = 'Your password has been updated successfully.';
		END

		UPDATE [dbo].[Users]
		SET HashPassword = @HashPassword,
		StatusCode = 8
		WHERE UserID = @UserId;

        SELECT @ResultCode AS ResultCode,
               @ResultDescription AS ResultDescription;
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END