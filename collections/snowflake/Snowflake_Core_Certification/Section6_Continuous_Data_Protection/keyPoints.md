# Time Travel 
1. Upto 1 day for Standard Edition. 
2. Upto 90 days from Enterprise Editions. 
3. Key Points: 
    * AT OFFSET
    * AT TIMESTAMP
    * BEFORE STATEMENT=>'queryID'
4. Can Undrop Database, Schema, Table, but can't if same exist
5. Recovering: 
    * Undrop Database Name; 
    * Undrop Schema Name; 
    * Undrop Table Name;
6. Need **Ownership** Privileges to restore. 

# Retention Period. 
1. We can customize Retention Period for the time travel
2. DATA_RETENTION_TIME_IN_DAYS is the commands. 
3. MIN_DATA_RETENTION_TIME_IN_DAYS to set min so this will overwrite manuall value if that's less this the min retention value. 

# Fail Safe. 
1. It is not configurable. 
2. This is for 7 days. 
3. This starts Immidetly after the TimeTravel Period. 
4. Can only be accessed by snowflake support
5. contribute to storage cost. 

# Storage Cost. 
1. ON-Demand 
    * Pay as you go
2. Capacity Storage. 
    * Paid Before hand 
    * $23 for 1 TB

# Table Types. 
|Standard Table|Transient Table|Temporary Table|
|--------------|---------------|---------------|
|Time Travle 0-90|Time Travel 0-1|Time Travel 0-1|
|Fail Safe: 7| No Fail Safe| No Fail Safe|
|Need to Drop Table if Needed| Need to drop Table If needed| Automatically Dropped if the session is closed|