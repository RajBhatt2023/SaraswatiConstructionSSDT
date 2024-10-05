CREATE TABLE [dbo].[UserRoles] (
    [UserID] BIGINT NOT NULL,
    [RoleID] INT    NOT NULL,
    CONSTRAINT [FK_UserRoles_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]),
    CONSTRAINT [FK_UserRoles_UserID] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

