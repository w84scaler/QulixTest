SET IDENTITY_INSERT [dbo].[Employee] ON
INSERT INTO [dbo].[Employee]([Id], [Surname], [Name], [Patronymic], [Position], [CompanyId])
VALUES
	(1, N'Dashkevich', N'Nikita', NULL, N'Developer', 1),
	(2, N'Дашкевич', N'Никита', N'Викторович', N'Developer', 2)
SET IDENTITY_INSERT [dbo].[Employee] OFF