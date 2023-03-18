-- drop DATABASE test1;
create database test1;

-- Run the first command then the second
Use test1;
CREATE VIEW PopulationHealthInsurance 
AS
SELECT  
    *
    , result.filepath(1) as FileName
 FROM
    OPENROWSET(
        BULK 'https://{StorageAccount}.dfs.core.windows.net/{StorageContainer}/census/PUMS/1-year/2017/Population/*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
        , FIRSTROW = 2
    ) 
    WITH (
        SerialNumber NVARCHAR(13) 2,
        DivisionCode NVARCHAR(1) 3,
        RegionCode NVARCHAR(1) 6,
        StateCode NVARCHAR(2) 7,
        PopulationWeight INT 9, -- PWGTP
        Age Int 10,    -- AGEP
        HealthInsuranceEmployer INT 27, -- HINS1
        HealthInsuranceDirect INT 28,  -- HINS2
        HealthInsuranceMedicare INT 29, -- HINS3
        HealthInsuranceMedicaid INT 30,  -- HINS4
        HealthInsuranceMilitary INT 31,  -- HINS5
        HealthInsuranceVA INT 32,      --- HINS6
        HealthInsuranceIndian INT 33,   -- HINS7
        HasHealthInsurance INT 88,    -- HICOV
        HispanicDetail nchar(2) 89   -- HISP
        ) AS [result]
;

select H.RegionCode
  , H.HispanicDetail
  , HealthInsuranceEmployer
  , HealthInsuranceDirect
  , HealthInsuranceMedicare
  , HealthInsuranceMedicaid
  , HealthInsuranceMilitary
  , HealthInsuranceVA
  , HealthInsuranceIndian
  , HasHealthInsurance
  , SUM(PopulationWeight) AS Population
  , Count(*) as NumRows
FROM PopulationHealthInsurance as h 
WHERE h.HispanicDetail != '01'

group by H.RegionCode
  , H.HispanicDetail
  , HealthInsuranceEmployer
  , HealthInsuranceDirect
  , HealthInsuranceMedicare
  , HealthInsuranceMedicaid
  , HealthInsuranceMilitary
  , HealthInsuranceVA
  , HealthInsuranceIndian
  , HasHealthInsurance
;

-- Summarize for whole
select 
 CASE HasHealthInsurance WHEN 1 THEN 'True' WHEN 2 THEN 'False' END as HasHealthInsurance 
  , SUM(PopulationWeight) AS Population
  , Count(*) as NumRows
FROM PopulationHealthInsurance as h 
WHERE H.HispanicDetail != N'01'
AND h.Age < 65
group by  CASE HasHealthInsurance WHEN 1 THEN 'True' WHEN 2 THEN 'False' END
;

 