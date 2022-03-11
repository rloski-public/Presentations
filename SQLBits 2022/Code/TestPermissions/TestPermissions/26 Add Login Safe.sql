USE Test_Logins;
SELECT SUSER_NAME() LoginName
, USER_NAME() UserName
, IS_SRVROLEMEMBER('sysadmin') IsSysAdmin
, IS_ROLEMEMBER('db_owner') IsDBOwner ;

declare @sql nvarchar(max) = N'Use Master; CREATE LOGIN testEvil1  with password = N''Password*''
, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
ALTER SERVER ROLE [sysadmin] ADD MEMBER [testEvil1];';
 
exec  dbo.[usp_ExecuteSQL_Safe] @sql;

 


execute as login = N'testEvil1';

select * from sys.login_token


revert

drop login testEvil1;