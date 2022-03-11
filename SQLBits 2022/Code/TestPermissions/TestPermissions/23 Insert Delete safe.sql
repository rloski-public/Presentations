USE Test_Logins;
SELECT SUSER_NAME() LoginName
, USER_NAME() UserName
, IS_SRVROLEMEMBER('sysadmin') IsSysAdmin
, IS_ROLEMEMBER('db_owner') IsDBOwner ;


select 'Before', count(*) from PublicTable;
 

declare @sql nvarchar(max) = N'Delete top (100) PublicTable;';
exec  dbo.[usp_ExecuteSQL_Safe] @sql;
select 'After Delete', count(*) from PublicTable;

SET @sql  = N'INSERT PublicTable values(10000,''Public Table''),(10001,''Public Table''),(10002,''Public Table'');'
exec   dbo.[usp_ExecuteSQL_Safe] @sql
select 'After Insert', count(*) from PublicTable;
