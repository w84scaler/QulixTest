CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1, 1), 
    [Surname] NVARCHAR(MAX) NOT NULL, 
    [Name] NVARCHAR(MAX) NOT NULL, 
    [Patronymic] NVARCHAR(MAX) NULL, 
    [EmploymentDate] DATE NULL, 
    [Position] NVARCHAR(50) NULL CONSTRAINT [CK_Employee_Position] CHECK ([Position] IN (N'Developer', N'Tester', N'Business Analyst', N'Manager')),
    [CompanyId] INT NULL CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyId]) REFERENCES Company([Id]) ON DELETE SET NULL,
)
