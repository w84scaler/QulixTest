SET IDENTITY_INSERT [dbo].[Company] ON
INSERT INTO [dbo].[Company]([Id], [Name], [Type])
VALUES
	(1, N'Google', NULL),
	(2, N'Яндекс', N'OAO')
SET IDENTITY_INSERT [dbo].[Company] OFF
