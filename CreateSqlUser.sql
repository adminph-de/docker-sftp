Declare @userName as varchar(50); 
Declare @defaultDataBaseName as varchar(50);
Declare @LoginCreationScript as varchar(max);
Declare @UserCreationScript as varchar(max);
Declare @TempUserCreationScript as varchar(max);
set @defaultDataBaseName = 'data1';
set @userName = 'domain\userName';
set @LoginCreationScript ='CREATE LOGIN [{userName}]
FROM WINDOWS 
WITH DEFAULT_DATABASE ={dataBaseName}'

set @UserCreationScript ='
USE {dataBaseName}
CREATE User [{userName}] for LOGIN [{userName}];
EXEC sp_addrolemember ''db_datareader'', ''{userName}'';
EXEC sp_addrolemember ''db_datawriter'', ''{userName}'';
Grant Execute on Schema :: dbo TO [{userName}];'
/*Login creation*/
set @LoginCreationScript=Replace(Replace(@LoginCreationScript, '{userName}', @userName), '{dataBaseName}', @defaultDataBaseName)
set @UserCreationScript =Replace(@UserCreationScript, '{userName}', @userName)
Execute(@LoginCreationScript)

/*User creation and role assignment*/
set @TempUserCreationScript =Replace(@UserCreationScript, '{dataBaseName}', @defaultDataBaseName)
Execute(@TempUserCreationScript)
set @TempUserCreationScript =Replace(@UserCreationScript, '{dataBaseName}', 'db2')
Execute(@TempUserCreationScript)
set @TempUserCreationScript =Replace(@UserCreationScript, '{dataBaseName}', 'db3')
Execute(@TempUserCreationScript)