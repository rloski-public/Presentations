USE test1;
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://<ADLSAccountName>.dfs.core.windows.net/<ADLSContainer>/census/PUMS/1-year/2017/Housing/psam_husa.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result];


-- Make the first row the header

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://<ADLSAccountName>.dfs.core.windows.net/<ADLSContainer>/census/PUMS/1-year/2017/Housing/psam_husa.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result];

-- Change the data types

SELECT  
    *
    , result.filepath(1) as FileName
 FROM
    OPENROWSET(
        BULK 'https://<ADLSAccountName>.dfs.core.windows.net/<ADLSContainer>/census/PUMS/1-year/2017/Housing/*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
        , FIRSTROW = 2
    ) 
    WITH (
        SerialNumber NVARCHAR(13) 2,
        DivisionCode NVARCHAR(1) 3,
        RegionCode NVARCHAR(1) 5,
        StateCode NVARCHAR(2) 6,
        NumberOfPersons int 10,
        NumberOfBedrooms int 16,
        NumberOfRooms int 38,
        FamilyIncome int 57
    ) AS [result]
;

CREATE VIEW HousingBedrooms AS
SELECT  
    *
    , result.filepath(1) as FileName
 FROM
    OPENROWSET(
        BULK 'https://<ADLSAccountName>.dfs.core.windows.net/<ADLSContainer>/census/PUMS/1-year/2017/Housing/*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
        , FIRSTROW = 2
    ) 
    WITH (
        SerialNumber NVARCHAR(13) 2,
        DivisionCode NVARCHAR(1) 3,
        RegionCode NVARCHAR(1) 5,
        StateCode NVARCHAR(2) 6,
        NumberOfPersons int 10,
        NumberOfBedrooms int 16,
        NumberOfRooms int 38,
        FamilyIncome BIGINT 57
    ) AS [result]
;

select r.Region, Count(*) as NumRows, SUM(h.FamilyIncome) as TotalIncome
FROM HousingBedrooms as h 
inner join RegionCode as r 
on h.RegionCode = r.RegionCode
group by r.Region
