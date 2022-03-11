USE Test_Logins;
SELECT SUSER_NAME() LoginName
, USER_NAME() UserName
, IS_SRVROLEMEMBER('sysadmin') IsSysAdmin
, IS_ROLEMEMBER('db_owner') IsDBOwner ;


declare @sql nvarchar(max) = N'Drop table Drop1;';
 
exec  dbo.[usp_ExecuteSQL_Safe] @sql;

 
if OBJECT_ID('Drop1') is  null
begin
create table Drop1 (id int identity(1,1) primary key, val int);
end 