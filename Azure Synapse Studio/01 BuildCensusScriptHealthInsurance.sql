SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://{StorageAccount}.dfs.core.windows.net/{StorageContainer}/census/PUMS/1-year/2017/Population/psam_pusa.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result];


-- Make the first row the header

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://{StorageAccount}.dfs.core.windows.net/{StorageContainer}/census/PUMS/1-year/2017/Population/psam_pusa.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result];

-- Change the data types and focus on the columns of interest
/*

9 PWGTP       Numeric     5
Person's weight
            00001..09999 .Integer weight of person
More documentation about this value (from https://www.census.gov/content/dam/Census/library/publications/2021/acs/acs_pums_handbook_2021_ch04.pdf)
Selecting Appropriate Weights
Each housing and person record is assigned a weight, 
because the records in the PUMS files represent a sample of the population. The weight is a numeric variable 
expressing the number of housing units or people that 
an individual microdata record represents. The sum of 
the housing unit and person weights for a geographic 
area is equal to the estimate of the total number of 
housing units and people in that area. To generate 
estimates based on the PUMS records, data users must 
correctly apply weights. 
TIP: To generate statistics for housing units or households (for example, data on average household 
income), data users should apply the PUMS household 
weights (WGTP). To generate statistics for individuals 
(such as age or educational attainment), data users 
should apply the PUMS person weights (PWGTP). 

10 AGEP        Numeric     2
Age
            00     .Under 1 year
            01..99 .1 to 99 years (Top-coded)

27 HINS1       Character   1
Insurance through a current or former employer or union
            1    .Yes
            2    .No

28 HINS2       Character   1
Insurance purchased directly from an insurance company
            1    .Yes
            2    .No

29 HINS3       Character   1
Medicare, for people 65 and older, or people with certain disabilities
            1    .Yes
            2    .No

30 HINS4       Character   1
Medicaid, Medical Assistance, or any kind of government-assistance plan for those with low incomes or a disability
            1    .Yes
            2    .No

31 HINS5       Character   1
TRICARE or other military health care
            1    .Yes
            2    .No

32 HINS6       Character   1
VA (including those who have ever used or enrolled for VA health care)
            1    .Yes
            2    .No

33 HINS7       Character   1
Indian Health Service
            1    .Yes
            2    .No
88 HICOV       Character   1
Health insurance coverage recode
            1    .With health insurance coverage
            2    .No health insurance coverage

89 HISP        Character   2
Recoded detailed Hispanic origin
            01     .Not Spanish/Hispanic/Latino
            02     .Mexican
            03     .Puerto Rican
            04     .Cuban
            05     .Dominican
            06     .Costa Rican
            07     .Guatemalan
            08     .Honduran
            09     .Nicaraguan
            10     .Panamanian
            11     .Salvadoran
            12     .Other Central American
            13     .Argentinean
            14     .Bolivian
            15     .Chilean
            16     .Colombian
            17     .Ecuadorian
            18     .Paraguayan
            19     .Peruvian
            20     .Uruguayan
            21     .Venezuelan
            22     .Other South American
            23     .Spaniard
            24     .All Other Spanish/Hispanic/Latino

*/

SELECT TOP 100 
    *
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
    WHERE HispanicDetail != '01'
;

-- Extra
-- You can get information about the file when using a wildcard using the file path function

SELECT  Top 100
    result.filepath() as FullFileName 
    , result.filename() as FileName
    , result.filepath(1) as WildCardValue
    , *
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
    WHERE HispanicDetail != '01'
;

