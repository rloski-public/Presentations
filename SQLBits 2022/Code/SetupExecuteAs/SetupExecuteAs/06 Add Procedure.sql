Use Test_Logins;

 
/****** Object:  StoredProcedure [dynamic].[usp_ExecuteSQL]    Script Date: 1/18/2022 4:40:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create a simple stored procedure to run whatever sql is passed in

create procedure dbo.[usp_ExecuteSQL_Safe]
  @sql nvarchar(max)
WITH EXECUTE AS 'LimitedPermission'
AS
BEGIN
print 'Current User:  ' + user_name();
exec sys.sp_executesql @sql;
END
GO

