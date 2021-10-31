/*
Скрипт развертывания для DBTest

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DBTest"
:setvar DefaultFilePrefix "DBTest"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[Company]…';


GO
CREATE TABLE [dbo].[Company] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (MAX) NOT NULL,
    [Type] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Employee]…';


GO
CREATE TABLE [dbo].[Employee] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Surname]        NVARCHAR (MAX) NOT NULL,
    [Name]           NVARCHAR (MAX) NOT NULL,
    [Patronymic]     NVARCHAR (MAX) NULL,
    [EmploymentDate] DATE           NULL,
    [Position]       NVARCHAR (50)  NULL,
    [CompanyId]      INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Идет создание Внешний ключ [dbo].[FK_Employee_Company]…';


GO
ALTER TABLE [dbo].[Employee]
    ADD CONSTRAINT [FK_Employee_Company] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Идет создание Проверочное ограничение [dbo].[CK_Employee_Position]…';


GO
ALTER TABLE [dbo].[Employee]
    ADD CONSTRAINT [CK_Employee_Position] CHECK ([Position] IN (N'Developer', N'Tester', N'Business Analyst', N'Manager'));


GO
PRINT N'Идет создание Процедура [dbo].[CompanyList]…';


GO
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
GO
PRINT N'Идет создание Процедура [dbo].[DeleteCompany]…';


GO
CREATE PROCEDURE [dbo].[DeleteCompany]
	@Id INT
AS
	DELETE FROM [dbo].[Company] WHERE [Id] = @Id
GO
PRINT N'Идет создание Процедура [dbo].[DeleteEmployee]…';


GO
CREATE PROCEDURE [dbo].[DeleteEmployee]
	@Id INT
AS
	DELETE FROM [dbo].[Employee] WHERE [Id] = @Id
GO
PRINT N'Идет создание Процедура [dbo].[EditCompany]…';


GO
CREATE PROCEDURE [dbo].[EditCompany]
	@Id INT,
	@Name NVARCHAR(MAX),
	@Type NVARCHAR(50) = NULL
AS
	UPDATE [dbo].[Company]
	SET [Name] = @Name,
		[Type] = @Type
	WHERE [Id] = @Id
GO
PRINT N'Идет создание Процедура [dbo].[EditEmployee]…';


GO
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
GO
PRINT N'Идет создание Процедура [dbo].[EmployeeList]…';


GO
CREATE PROCEDURE [dbo].[EmployeeList]
AS
	SELECT [dbo].[Employee].[Id],
		[dbo].[Employee].[Surname],
		[dbo].[Employee].[Name],
		[dbo].[Employee].[Patronymic],
		[dbo].[Employee].[EmploymentDate],
		[dbo].[Employee].[Position],
		[dbo].[Company].[Id] AS [CompanyId],
		[dbo].[Company].[Type] AS [CompanyType],
		[dbo].[Company].[Name] AS [CompanyName]
	FROM [dbo].[Employee]
		LEFT JOIN [dbo].[Company] ON [dbo].[Employee].[CompanyId] = [dbo].[Company].[Id]
GO
PRINT N'Идет создание Процедура [dbo].[GetCompany]…';


GO
CREATE PROCEDURE [dbo].[GetCompany]
	@Id INT
AS
	SELECT [Id], [Type], [Name]
	FROM [dbo].[Company]
	WHERE [Id] = @Id
GO
PRINT N'Идет создание Процедура [dbo].[GetEmployee]…';


GO
CREATE PROCEDURE [dbo].[GetEmployee]
	@Id INT
AS
	SELECT [dbo].[Employee].[Id],
		[dbo].[Employee].[Surname],
		[dbo].[Employee].[Name],
		[dbo].[Employee].[Patronymic],
		[dbo].[Employee].[EmploymentDate],
		[dbo].[Employee].[Position],
		[dbo].[Company].[Id] AS [CompanyId],
		[dbo].[Company].[Type] AS [CompanyType],
		[dbo].[Company].[Name] AS [CompanyName]
	FROM [dbo].[Employee]
		LEFT JOIN [dbo].[Company] ON [dbo].[Employee].[CompanyId] = [dbo].[Company].[Id]
	WHERE [dbo].[Employee].[Id] = @Id
GO
PRINT N'Идет создание Процедура [dbo].[InsertCompany]…';


GO
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
GO
PRINT N'Идет создание Процедура [dbo].[InsertEmployee]…';


GO
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
GO
SET IDENTITY_INSERT [dbo].[Company] ON
INSERT INTO [dbo].[Company]([Id], [Name], [Type])
VALUES
	(1, N'Google', NULL),
	(2, N'Яндекс', N'OAO')
SET IDENTITY_INSERT [dbo].[Company] OFF

SET IDENTITY_INSERT [dbo].[Employee] ON
INSERT INTO [dbo].[Employee]([Id], [Surname], [Name], [Patronymic], [Position], [CompanyId])
VALUES
	(1, N'Dashkevich', N'Nikita', NULL, N'Developer', 1),
	(2, N'Дашкевич', N'Никита', N'Викторович', N'Developer', 2)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Обновление завершено.';


GO
