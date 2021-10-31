CREATE PROCEDURE [dbo].[InsertCompany]
	@Name NVARCHAR(MAX),
	@Type NVARCHAR(50) = NULL
AS
	INSERT INTO [dbo].[Company](
		[Name],
		[Type])
	VALUES(
		@Name,
		@Type)
