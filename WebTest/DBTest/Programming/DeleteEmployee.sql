CREATE PROCEDURE [dbo].[DeleteEmployee]
	@Id INT
AS
	DELETE FROM [dbo].[Employee] WHERE [Id] = @Id
