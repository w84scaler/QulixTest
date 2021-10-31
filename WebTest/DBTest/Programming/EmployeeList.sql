CREATE PROCEDURE [dbo].[EmployeeList]
AS
	SELECT [dbo].[Employee].[Id],
		[dbo].[Employee].[Surname],
		[dbo].[Employee].[Name],
		[dbo].[Employee].[Patronymic],
		[dbo].[Employee].[EmploymentDate],
		[dbo].[Employee].[Position],
		[dbo].[Company].[Id] AS [CompanyId],
		[dbo].[Company].[Type] AS [CompanyType],
		[dbo].[Company].[Name] AS [CompanyName]
	FROM [dbo].[Employee]
		LEFT JOIN [dbo].[Company] ON [dbo].[Employee].[CompanyId] = [dbo].[Company].[Id]