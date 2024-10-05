CREATE TABLE [dbo].[Status] (
    [StatusCode] INT            NOT NULL,
    [Status]     NVARCHAR (100) NOT NULL,
    CONSTRAINT [UC_Status_StatusCode] UNIQUE NONCLUSTERED ([StatusCode] ASC)
);

