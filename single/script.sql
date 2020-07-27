DECLARE @output INT
EXEC master.dbo.xp_fileexist '/var/opt/mssql/data/GADATA.mdf', @output OUT
PRINT @output

USE [master]
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'GADATA')
BEGIN
    CREATE LOGIN [GADATA] WITH PASSWORD=N'2343JFEkdwe', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
    ALTER LOGIN [GADATA] ENABLE
END
GO

IF @output = 0
BEGIN
  PRINT 'File Donot exists'
  CREATE DATABASE [GADATA] 
    ON (NAME = N'GADATA', FILENAME = N'/var/opt/mssql/data/GADATA.mdf', SIZE = 1024MB, FILEGROWTH = 256MB)
LOG ON (NAME = N'GADATA_LOG', FILENAME = N'/var/opt/mssql/log/GADATA_LOG.ldf', SIZE = 512MB, FILEGROWTH = 125MB)
END
GO
IF @output = 1
 BEGIN
  PRINT 'File exists'
  IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'GADATA')
   BEGIN
    USE [master]
    CREATE DATABASE [GADATA] ON 
     ( FILENAME = N'/var/opt/sql/msdata/GADATA.mdf' ),
     ( FILENAME = N'/var/opt/sql/mslog/GADATA_LOG.ldf' )
    FOR ATTACH
   END
END
GO

Use MyDatabase;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'AdminLOGIN')
BEGIN
    CREATE USER [AdminLOGIN] FOR LOGIN [AdminLOGIN]
    EXEC sp_addrolemember N'db_owner', N'AdminLOGIN'
    EXEC master..sp_addsrvrolemember @loginame = N'adminlogin', @rolename = N'sysadmin'
END;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = N'GADATA')
BEGIN
 PRINT 'Alter user GADATA'
 USE [GADATA]
 ALTER USER [GADATA] WITH LOGIN=[GADATA]
END
GO