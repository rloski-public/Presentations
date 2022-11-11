Create  DATABASE test1;

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'LookupFormat') 
	CREATE EXTERNAL FILE FORMAT [LookupFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = '	',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://loskisynapsefilesystem@loskisynapsedatalake.dfs.core.windows.net'
	)
GO

CREATE EXTERNAL TABLE dbo.DivisionCode (
	[DivisionCode] nchar(1),
	[Division] nvarchar(50)
	)
	WITH (
	LOCATION = 'census/PUMS/1-year/2017/Document/DivisionCode.tab',
	DATA_SOURCE = [loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net],
	FILE_FORMAT = [LookupFormat]
	)
GO
CREATE EXTERNAL TABLE dbo.RegionCode (
	[RegionCode] nchar(1),
	[Region] nvarchar(50)
	)
	WITH (
	LOCATION = 'census/PUMS/1-year/2017/Document/RegionCode.tab',
	DATA_SOURCE = [loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net],
	FILE_FORMAT = [LookupFormat]
	)
GO
CREATE EXTERNAL TABLE dbo.StateCode (
	[StateCode] nchar(2),
	[StateName] nvarchar(30),
	[StateAbbr] nvarchar(5)
	)
	WITH (
	LOCATION = 'census/PUMS/1-year/2017/Document/StateCode.tab',
	DATA_SOURCE = [loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net],
	FILE_FORMAT = [LookupFormat]
	)
GO

SELECT TOP 100 * FROM dbo.StateCode
GO

CREATE EXTERNAL TABLE dbo.HispanicRecode (
	[Code] nchar(2),
	[HispanicDetail] nvarchar(50),
	)
	WITH (
	LOCATION = 'census/PUMS/1-year/2017/Document/HispanicRecode.tab',
	DATA_SOURCE = [loskisynapsefilesystem_loskisynapsedatalake_dfs_core_windows_net],
	FILE_FORMAT = [LookupFormat]
	)
GO

SELECT TOP 100 * FROM dbo.HispanicRecode
GO