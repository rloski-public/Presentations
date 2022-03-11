use Master;

ALTER SERVER ROLE [sysadmin] ADD MEMBER [testSysadmin];

USE [Test_Logins]
GO
CREATE USER [testLimited] FOR LOGIN [testLimited]
GO
CREATE USER [testDBOwner] FOR LOGIN [testDBOwner]
GO
CREATE USER [testNone] FOR LOGIN [testNone]
GO


ALTER ROLE [db_owner] ADD MEMBER [testDBOwner];

GRANT EXECUTE ON dbo.[usp_ExecuteSQL_Safe] TO [testLimited];
GRANT EXECUTE ON dbo.[usp_ExecuteSQL_Safe] TO [testNone];

GRANT SELECT ON dbo.PublicTable TO [testLimited];
GRANT SELECT ON dbo.Drop1 TO [testLimited];

GRANT SELECT ON dbo.PublicTable TO LimitedPermission;

