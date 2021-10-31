CREATE PROCEDURE [dbo].[EditCompany]
	@Id INT,
	@Name NVARCHAR(MAX),
	@Type NVARCHAR(50) = NULL
AS
	UPDATE [dbo].[Company]
	SET [Name] = @Name,
		[Type] = @Type
	WHERE [Id] = @Id
