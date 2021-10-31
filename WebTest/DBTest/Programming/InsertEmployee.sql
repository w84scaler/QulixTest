CREATE PROCEDURE [dbo].[InsertEmployee]
	@Surname NVARCHAR(MAX),
	@Name NVARCHAR(MAX),
	@Patronymic NVARCHAR(MAX) = NULL,
	@EmploymentDate DATE = NULL,
	@Position NVARCHAR(50) = NULL,
	@CompanyId INT = NULL
AS
	INSERT INTO [dbo].[Employee](
		[Surname],
		[Name],
		[Patronymic],
		[EmploymentDate],
		[Position],
		[CompanyId])
	VALUES(
		@Surname,
		@Name,
		@Patronymic,
		@EmploymentDate,
		@Position,
		@CompanyId)
