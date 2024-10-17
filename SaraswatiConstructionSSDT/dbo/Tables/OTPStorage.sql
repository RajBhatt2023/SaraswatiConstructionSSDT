CREATE TABLE [dbo].[OTPStorage] (
    [OTPStorageID]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [Email]                  NVARCHAR (50) NOT NULL,
    [PhoneNumberCountryCode] NVARCHAR (5)  CONSTRAINT [DF_OTPStorage_PhoneNumberCountryCode] DEFAULT ('') NOT NULL,
    [PhoneNumber]            NVARCHAR (20) CONSTRAINT [DF_OTPStorage_PhoneNumber] DEFAULT ('') NOT NULL,
    [OTP]                    NVARCHAR (10) NOT NULL,
    [CreatedDate]            DATETIME      CONSTRAINT [DF_OTPStorage_CreatedDate] DEFAULT (getutcdate()) NOT NULL,
    [ExpirationDate]         DATETIME      NOT NULL,
    [IsUsed]                 BIT           CONSTRAINT [DF_OTPStorage_IsUsed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_OTPStorage_OTPStorageID] PRIMARY KEY CLUSTERED ([OTPStorageID] DESC)
);

