CREATE PROCEDURE [dbo].[Api_Account_VerifyOTP]
-- Api_Account_VerifyOTP 3,417849      
(
@OtpID BIGINT,
@Otp INT
)
AS
BEGIN
	DECLARE @Email NVARCHAR(100);

	SELECT @Email = Email
	FROM [dbo].[OTPStorage]
	WHERE OTPStorageId = @OtpID
		AND OTP = @Otp;

	IF @Email IS NOT NULL
	BEGIN
		IF EXISTS (
				SELECT 1
				FROM [dbo].[OTPStorage]
				WHERE OTPStorageId = @OtpID
					AND OTP = @Otp
					AND ExpirationDate >= GETUTCDATE()
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM [dbo].[OTPStorage]
					WHERE OTPStorageId = @OtpID
						AND OTP = @Otp
						AND IsUsed = 0
					)
			BEGIN
				SELECT '0' AS ResultCode,
					'OTP is verified.' AS ResultDescription,
					U.UserID
				FROM [dbo].[Users] U
				WHERE U.Email = @Email;

				UPDATE [dbo].[OTPStorage]
				SET IsUsed = 1
				WHERE OTPStorageId = @OtpID
					AND OTP = @Otp;
			END
			ELSE
			BEGIN
				SELECT '1' AS ResultCode,
					'OTP is used!' AS ResultDescription;
			END
		END
		ELSE
		BEGIN
			SELECT '2' AS ResultCode,
				'OTP is expired!' AS ResultDescription;
		END
	END
	ELSE
	BEGIN
		SELECT '2' AS ResultCode,
			'OTP is invalid!' AS ResultDescription;
	END
END