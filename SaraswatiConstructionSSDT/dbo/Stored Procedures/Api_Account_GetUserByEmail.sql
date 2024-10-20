CREATE PROCEDURE [dbo].[Api_Account_GetUserByEmail]
-- Api_Account_GetUserByEmail 'vikas@yopmail.com'  
(
@Email NVARCHAR(50)
)
AS
BEGIN
	SET @Email = LTRIM(RTRIM(@Email));
	IF EXISTS (
			SELECT 1
			FROM [dbo].[Users]
			WHERE Email = @Email
			)
	BEGIN
		IF EXISTS (
				SELECT 1
				FROM [dbo].[Users]
				WHERE Email = @Email
					AND IsActive = 1
				)
		BEGIN
			SELECT '0' AS ResultCode, 'Email is valid.' AS ResultDescription,
			UserID,
			Email, 
			HashPassword
			FROM [dbo].[Users]
			WHERE Email = @Email
		END
		ELSE
		BEGIN
			SELECT '1' AS ResultCode, 'Your account has been deactivated. Please contact support for assistance.' AS ResultDescription
		END
	END
	ELSE
	BEGIN
		SELECT '1' AS ResultCode, 'Invalid credentials.' AS ResultDescription
	END
END;