USE Test_Logins;
SELECT SUSER_NAME() LoginName
, USER_NAME() UserName
, IS_SRVROLEMEMBER('sysadmin') IsSysAdmin
, IS_ROLEMEMBER('db_owner') IsDBOwner ;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Drop1';

declare @sql nvarchar(max) = N'Revert; Drop table Drop1;';
 
exec  dbo.[usp_ExecuteSQL_Safe] @sql;

 
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Drop1';

if OBJECT_ID('Drop1') is  null
begin
create table Drop1 (id int identity(1,1) primary key, val int);
end 