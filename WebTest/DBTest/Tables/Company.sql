CREATE TABLE [dbo].[Company]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1, 1), 
    [Name] NVARCHAR(MAX) NOT NULL,
    [Type] NVARCHAR(50) NULL 
)
