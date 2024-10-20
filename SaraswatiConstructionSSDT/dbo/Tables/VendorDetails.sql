CREATE TABLE [dbo].[VendorDetails] (
    [VendorID]               BIGINT         IDENTITY (1, 1) NOT NULL,
    [VendorName]             NVARCHAR (100) NOT NULL,
    [Email]                  NVARCHAR (255) NOT NULL,
    [PhoneNumberCountryCode] NVARCHAR (5)   CONSTRAINT [DF_VendorDetails_PhoneNumberCountryCode] DEFAULT ('91') NOT NULL,
    [PhoneNumber]            NVARCHAR (20)  CONSTRAINT [DF_VendorDetails_PhoneNumber] DEFAULT ('') NOT NULL,
    [Address]                NVARCHAR (200) CONSTRAINT [DF_VendorDetails_Address] DEFAULT ('') NOT NULL,
    [IsActive]               BIT            CONSTRAINT [DF_VendorDetails_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]              BIGINT         CONSTRAINT [DF_VendorDetails_CreatedBy] DEFAULT ((0)) NOT NULL,
    [CreatedDate]            DATETIME       CONSTRAINT [DF_VendorDetails_CreatedDate] DEFAULT (getutcdate()) NOT NULL,
    [UpdatedBy]              BIGINT         CONSTRAINT [DF_VendorDetails_UpdatedBy] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]            DATETIME       NULL,
    CONSTRAINT [PK_VendorDetails_VendorID] PRIMARY KEY CLUSTERED ([VendorID] ASC)
);

