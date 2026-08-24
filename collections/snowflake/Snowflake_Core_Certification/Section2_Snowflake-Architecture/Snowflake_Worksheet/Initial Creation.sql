-- Creating a Warehouse, Database, Schema

CREATE OR REPLACE WAREHOUSE SECTION2_DATALOADING_WH;
CREATE OR REPLACE DATABASE SECTION2_DATALOADING_DB;
CREATE OR REPLACE SCHEMA SECTION2_DATALOADING_SH;

-- use these created Warehouse, Database, Schema in the current session. 

USE WAREHOUSE SECTION2_DATALOADING_WH; 
USE DATABASE SECTION2_DATALOADING_DB; 
USE SCHEMA SECTION2_DATALOADING_SH; 

-- create a table

CREATE OR REPLACE TABLE SECTION2_DATALOADING_TABLE(
PassengerID int, 
Survived int, 
Pclass int, 
PassengerName varchar, 
Sex varchar, 
Age float, 
Sibsp int, 
Parch int, 
Ticket varchar, 
Fare float, 
Cabin varchar, 
Embarked varchar
);

CREATE OR REPLACE TABLE SECTION2_DATALOADING_TABLE_JPMORGAN(
    JDate varchar,
    JOpen int, 
    high float, 
    low float, 
    JClose float, 
    adj_close float, 
    JVolume int
);

-- To see the table data

SELECT * FROM section2_dataloading_table;

-- Loading the data from s3 to the table and selecting a specific file from the bucket.

COPY INTO SECTION2_DATALOADING_TABLE_JPMORGAN
    FROM s3://shidhin-snowflakepublicbucket.blocked/
    FILES=('JPMorgan.csv')
    FILE_FORMAT=(type= csv field_delimiter=',' skip_header=1);
    
-- Fetching all the data to verify

SELECT * FROM SECTION2_DATALOADING_TABLE_JPMORGAN;