CREATE PROCEDURE [dbo].[EditEmployee]
	@Id INT,
	@Surname NVARCHAR(MAX),
	@Name NVARCHAR(MAX),
	@Patronymic NVARCHAR(MAX) = NULL,
	@EmploymentDate DATE = NULL,
	@Position NVARCHAR(50) = NULL,
	@CompanyId INT = NULL
AS
	UPDATE [dbo].[Employee]
	SET [Surname] = Surname,
		[Name] = @Name,
		[Patronymic] = @Patronymic,
		[EmploymentDate] = @EmploymentDate,
		[Position] = @Position,
		[CompanyId] = @CompanyId
	WHERE [Id] = @Id
