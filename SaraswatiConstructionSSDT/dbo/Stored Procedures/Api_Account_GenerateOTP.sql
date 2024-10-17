CREATE PROCEDURE [dbo].[Api_Account_GenerateOTP]
-- Api_Account_GenerateOTP 'vikas@gmail.com','9857641250'
(
@Email NVARCHAR(50),
@MobileNumber NVARCHAR(20) = ''
)
AS
BEGIN
	BEGIN TRY
		DECLARE @OTP INT,
			@CreatedDate AS DATETIME = GETUTCDATE(),
			@ExpirationDate AS DATETIME = DATEADD(minute, 2, GETUTCDATE()),
			@OTPStorageId BIGINT

		IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
		BEGIN
			SELECT '1' AS ResultCode,
			@Email + ' eamil does not exists!' AS ResultDescription;
          RETURN;
		END

		-- Generate a random 6-digit OTP
		SET @OTP = LEFT(CAST(RAND() * 1000000000 AS INT), 6);
		SET @Email = LTRIM(RTRIM(@Email));
		INSERT INTO [dbo].[OTPStorage] (
			Email,
			PhoneNumber,
			OTP,
			CreatedDate,
			ExpirationDate,
			IsUsed
			)
		VALUES (
			@Email,
			@MobileNumber,
			@OTP,
			@CreatedDate,
			@ExpirationDate,
			0
			);

		SET @OTPStorageId = SCOPE_IDENTITY();

		SELECT '0' AS ResultCode,
			'6 digit OTP has been sent to your registered email.' AS ResultDescription,
			A.OTP,
			A.OTPStorageId AS OtpId,
			A.Email,
			A.PhoneNumber
		FROM [dbo].[OTPStorage] A
		WHERE A.OTPStorageId = @OTPStorageId
			AND A.OTP = @OTP
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH
END;