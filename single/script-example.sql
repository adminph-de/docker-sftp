CREATE DATABASE [GADATA]
 CONTAINMENT = NONE
 ON PRIMARY
 ( NAME = N'GADATA', FILENAME = N'/var/opt/mssql/data/GADATA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
 ( NAME = N'GADATA', FILENAME = N'/var/opt/mssql/log/GADATA.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 GO


-------

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'GADATA')
    BEGIN
       CREATE DATABASE [GADATA]
        CONTAINMENT = NONE
        ON PRIMARY
            ( NAME = N'GADATA', FILENAME = N'/var/opt/mssql/data/GADATA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
        LOG ON
            ( NAME = N'GADATA', FILENAME = N'/var/opt/mssql/log/GADATA.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
    END;

IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'GADATA')
 CREATE LOGIN [GADATA] WITH PASSWORD=N'AMxx2iQ7,2017', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'GADATA')
BEGIN
 PRINT 'Alter user GADATA'
 USE [GADATA]
 ALTER USER GADATA WITH LOGIN=GADATA
END
GO

-------

CREATE LOGIN AdminLOGIN WITH PASSWORD = 'pass'
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

