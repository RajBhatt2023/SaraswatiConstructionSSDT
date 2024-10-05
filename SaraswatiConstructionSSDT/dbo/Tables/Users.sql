﻿CREATE TABLE [dbo].[Users] (
    [UserID]                 BIGINT         IDENTITY (1, 1) NOT NULL,
    [FirstName]              NVARCHAR (100) NOT NULL,
    [MiddleName]             NVARCHAR (100) CONSTRAINT [DF_Users_MiddleName] DEFAULT ('') NOT NULL,
    [LastName]               NVARCHAR (100) NOT NULL,
    [Username]               NVARCHAR (100) CONSTRAINT [DF_Users_Username] DEFAULT ('') NOT NULL,
    [Gender]                 NVARCHAR (20)  CONSTRAINT [DF_Users_Gender] DEFAULT ('') NOT NULL,
    [DOB]                    DATETIME       NULL,
    [Email]                  NVARCHAR (100) NOT NULL,
    [PhoneNumberCountryCode] NVARCHAR (5)   CONSTRAINT [DF_Users_PhoneNumberCountryCode] DEFAULT ('91') NOT NULL,
    [PhoneNumber]            NVARCHAR (20)  CONSTRAINT [DF_Users_PhoneNumber] DEFAULT ('') NOT NULL,
    [HashPassword]           NVARCHAR (MAX) CONSTRAINT [DF_Users_HashPassword] DEFAULT ('') NOT NULL,
    [Address]                NVARCHAR (200) CONSTRAINT [DF_Users_Address] DEFAULT ('') NOT NULL,
    [City]                   NVARCHAR (100) CONSTRAINT [DF_Users_City] DEFAULT ('') NOT NULL,
    [PinCode]                NVARCHAR (50)  CONSTRAINT [DF_Users_ZipCode] DEFAULT ('') NOT NULL,
    [State]                  NVARCHAR (100) CONSTRAINT [DF_Users_State] DEFAULT ('') NOT NULL,
    [Country]                NVARCHAR (100) CONSTRAINT [DF_Users_Country] DEFAULT ('') NOT NULL,
    [CountryCode]            NVARCHAR (5)   CONSTRAINT [DF_Users_CountryCode] DEFAULT ('in') NOT NULL,
    [ImageUrl]               NVARCHAR (MAX) CONSTRAINT [DF_Users_ImageUrl] DEFAULT ('') NOT NULL,
    [StatusCode]             INT            CONSTRAINT [DF_Users_StatusCode] DEFAULT ((2)) NOT NULL,
    [IsActive]               BIT            CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]              BIGINT         CONSTRAINT [DF_Users_CreatedBy] DEFAULT ((0)) NOT NULL,
    [CreatedDate]            DATETIME       CONSTRAINT [DF_Users_CreatedDate] DEFAULT (getutcdate()) NOT NULL,
    [UpdatedBy]              BIGINT         CONSTRAINT [DF_Users_UpdatedBy] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]            DATETIME       NULL,
    [EmailConfirmed]         BIT            CONSTRAINT [DF_Users_EmailConfirmed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Users_UserID] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [UC_Users_Email] UNIQUE NONCLUSTERED ([Email] ASC)
);

