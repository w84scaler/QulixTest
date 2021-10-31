CREATE PROCEDURE [dbo].[DeleteCompany]
	@Id INT
AS
	DELETE FROM [dbo].[Company] WHERE [Id] = @Id