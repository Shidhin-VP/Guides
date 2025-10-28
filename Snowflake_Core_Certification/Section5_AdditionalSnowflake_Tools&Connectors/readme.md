# Additional Snowflake Tools and Connectors. 

## Connectors, Driver & Partner Connect. 

1. We can use WebUI -> Snowsight. 
2. We can use Command Line -> SnowSQL
3. 

|Connectors| Driver| 
|----------|-------|
|Python|Go|
|Kafka|JDBC|
|Spark|.NET|
||Node.js|
||ODBC|
||PHP PDO|

### Partner Connect. 
1. Create a trial account and integrate them with snowflake.
2. We need to be role of **Admin** 
3. Available to different category. 
    * Data Integration
        * Informatica
        * Talend
        * Matillion 
        * Stitch
        * Qlik
    * ML & Data Science
        * Dataiku
        * Alteryx
        * DataRobot
    * CI/CD
        * SqlDBM
        * DataOps
    * Security & Governance
        * Immuta
        * Hunters
        * Alation
    * Business Intelligence.
        * Sisense. 
        * Domo
        * Sigma

## Snowflake Scripting. 
1. Extention to Snowflake SQL with added support for procedural logic. 
2. Mainly used for **Stored Procedures** 
3. Also used Procedual Code **Outside of Stored Procedures**

### Snowflake Scripting Contains. 
1. Variables. 
2. If/Case Conditions.
3. Loops.
4. Cursors. 
5. Resultsets. 

#### If/Case 
1. If/Else
2. CASE

#### Loops
1. For
2. While
3. Loop 
4. Repeat

### How it is Written? 
1. It is written in Blocks. 
2. Sections. 
    * Declare <Variable and Cursor Declaration>
    * Begin <Scripting and SQL Statement>
    * Exception <Handling Exceptions>
    * End
3. If we define objects in a block we can use those objects outside of the block. 
4. Variables can only be used inside of the blocks. 
5. In classical UI or SnowSQL we need to use the $$ sign. 
    ```sql
    CREATE PROCEDURE CALC_AREA()
        RETURNS FLOAT
        LANGUAGE SQL 
        AS
        $$
        DECLARE
        LENGTH_A FLOAT;
        AREA FLOAT;
        BEGIN TRANSACTION
        LENGTH_A:=4;
        AREA:=LENGTH_A*LENGTH_A;
        RETURN AREA;
        END TRANSACTION;
        $$
    ```
6. When using Snowsight. 
    ```sql
    CREATE PROCEDURE CALC_AREA()
        RETURNS FLOAT
        LANGUAGE SQL 
        AS
        DECLARE
        LENGTH_A FLOAT;
        AREA FLOAT;
        BEGIN
        LENGTH_A:=4;
        AREA:=LENGTH_A*LENGTH_A;
        RETURN AREA;
        END;
    ```

## SnowPark
1. Snowpark API supports 3 programming languages. 
    * Python
    * java 
    * Scala 
eg: 
1. Build application and query data outside the system/snowflake. 
2. Converts to SQL
3. Pusheddown to Snowflake
4. **No Data Needs to move inside of snowflake**

### Benifits
1. Lazy Evaluation <Expression is not evaluated until it is needed>
2. Pushdown <code is pushed down to snowflake and execute there>
3. UDFs Inline <Created functions can be executed in UDFs>