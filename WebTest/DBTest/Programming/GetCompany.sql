CREATE PROCEDURE [dbo].[GetCompany]
	@Id INT
AS
	SELECT [Id], [Type], [Name]
	FROM [dbo].[Company]
	WHERE [Id] = @Id