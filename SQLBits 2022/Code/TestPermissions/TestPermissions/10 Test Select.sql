use Test_Logins;
SELECT SUSER_NAME() LoginName
, USER_NAME() UserName
, IS_SRVROLEMEMBER('sysadmin') IsSysAdmin
, IS_ROLEMEMBER('db_owner') IsDBOwner 

declare @sql nvarchar(max) = N'SELECT * FROM PublicTable;';

exec  sys.sp_executesql @sql;

GO


declare @sql nvarchar(max) = N'SELECT * FROM PrivateTable;';


exec  sys.sp_executesql @sql;