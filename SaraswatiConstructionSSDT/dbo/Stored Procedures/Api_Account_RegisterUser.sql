CREATE PROCEDURE [dbo].[Api_Account_RegisterUser]
	-- Api_Account_RegisterUser 'Vikas','Chauhan','vikas@yopmail.com'
	(
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(50),
	@HashPassword NVARCHAR(MAX)
	)
AS
BEGIN
	SET NOCOUNT ON;

	-- Start a transaction
	BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @UserID BIGINT,
			@RoleID BIGINT,
			@ResultCode NVARCHAR(1),
			@ResultDescription NVARCHAR(100);

		-- Clean input values
		SET @FirstName = LTRIM(RTRIM(@FirstName));
		SET @LastName = LTRIM(RTRIM(@LastName));
		SET @Email = LTRIM(RTRIM(@Email));

		-- Check if the user already exists
		IF EXISTS (
				SELECT 1
				FROM [dbo].[users]
				WHERE Email = @Email
					AND StatusCode = 2
				)
		BEGIN
			-- Update the existing user's details
			UPDATE [dbo].[users]
			SET FirstName = @FirstName,
				LastName = @LastName,
				HashPassword = @HashPassword,
				CreatedDate = GETUTCDATE()
			WHERE Email = @Email;

			-- Retrieve the existing UserID
			SELECT @UserID = UserID
			FROM [dbo].[users]
			WHERE Email = @Email;

			SET @ResultCode = '0';
			SET @ResultDescription = 'Registration completed successfully.';
		END
		ELSE IF EXISTS (
				SELECT 1
				FROM [dbo].[users]
				WHERE Email = @Email
				)
		BEGIN
			-- Email already exists but not with StatusCode = 2
			SET @ResultCode = '1';
			SET @ResultDescription = 'Email already exists.';
		END
		ELSE
		BEGIN
			-- Insert the new user
			INSERT INTO [dbo].[users] (
				FirstName,
				LastName,
				Email,
				HashPassword,
				CreatedDate
				)
			VALUES (
				@FirstName,
				@LastName,
				@Email,
				@HashPassword,
				GETUTCDATE()
				);

			-- Get the newly inserted UserID
			SET @UserID = SCOPE_IDENTITY();

			-- Assign the CreatedBy to the new UserID
			UPDATE [dbo].[users]
			SET CreatedBy = @UserID
			WHERE UserID = @UserID;

			-- Assign role to the new user
			SELECT TOP 1 @RoleID = RoleID
			FROM [dbo].[roles]
			WHERE RoleName = 'Employee';

			INSERT INTO [dbo].[userroles] (
				UserID,
				RoleID
				)
			VALUES (
				@UserID,
				@RoleID
				);

			SET @ResultCode = '0';
			SET @ResultDescription = 'Registration completed successfully.';
		END

		-- Return the result
		SELECT @UserID UserID,
		       @ResultCode AS ResultCode,
			   @ResultDescription AS ResultDescription;

		-- Commit the transaction
		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		-- Rollback in case of error
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		-- Re-throw the error
		THROW;
	END CATCH
END;