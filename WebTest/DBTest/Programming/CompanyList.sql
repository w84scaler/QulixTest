CREATE PROCEDURE [dbo].[CompanyList]
AS
	SELECT [dbo].[Company].[Id],
		[dbo].[Company].[Name],
		[dbo].[Company].[Type],
		Count([dbo].[Employee].[Id]) AS [State]
	FROM [dbo].[Company]
		LEFT JOIN [dbo].[Employee] ON [dbo].[Company].[Id] = [dbo].[Employee].[CompanyId]
	GROUP BY [dbo].[Company].[Id],
		[dbo].[Company].[Name],
		[dbo].[Company].[Type]