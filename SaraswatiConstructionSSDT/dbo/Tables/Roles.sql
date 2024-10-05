CREATE TABLE [dbo].[Roles] (
    [RoleID]          INT            IDENTITY (1, 1) NOT NULL,
    [RoleRank]        INT            CONSTRAINT [DF_Roles_RoleRank] DEFAULT ((3)) NOT NULL,
    [RoleName]        NVARCHAR (50)  NOT NULL,
    [RoleDescription] NVARCHAR (250) CONSTRAINT [DF_Roles_RoleDescription] DEFAULT ('') NOT NULL,
    [IsActive]        BIT            CONSTRAINT [DF_Roles_IsActive] DEFAULT ((0)) NOT NULL,
    [CreatedBy]       BIGINT         CONSTRAINT [DF_Roles_CreatedBy] DEFAULT ((0)) NOT NULL,
    [CreatedDate]     DATETIME       CONSTRAINT [DF_Roles_CreatedDate] DEFAULT (getutcdate()) NOT NULL,
    [UpdatedBy]       BIGINT         CONSTRAINT [DF_Roles_UpdatedBy] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]     DATETIME       NULL,
    CONSTRAINT [PK_Roles_RoleID] PRIMARY KEY CLUSTERED ([RoleID] ASC)
);

