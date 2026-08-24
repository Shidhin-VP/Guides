# Continuous Data Protection

## Time Travel. 
1. After the data is Drop/Truncated/Updated by accident we can use Time Travel to fetch/query data which is droped according to the Editions timline
2. Time Travel can access Historical data. 

### What is Possible using Time Travel. 
1. Query Deleted or Updated Data. 
2. Restore Table, Schema and Databases that have been dropped. 
3. Create Clones of Tables, Schema and database from previous state. 

### Commands Used. 
1. 
```sql
SELECT * FROM TABLE AT (TIMESTAMP=>timestap);
```
2. 
```sql 
SELECT * FROM TABLE AT (OFFSET=> -10*60) -- for 10 minutes before
```
3. 
```sql 
SELECT * FROM TABLE BEFORE (STATEMENT => query_id)
```

### Recovering
1. 
```sql
UNDROP TABLE TABLENAME;
```
2. 
```sql
UNDROP DATABASE DATABASENAME;
```
3. 
```SQL
UNDROP SCHEMA SCHEMANAME;
```
1. Undrop fails if an object with the same name already exists. 
2. We need **Ownership** Privileges for an object to be restored. 

## Retention Period
1. Numbers of days for which this historical data is preserved and time travel can be applied
2. Can be configurable for, Table, Schema, database and account. 
3. **DATA_RETENTION_TIME_IN_DAYS=2** for all accounts
4. Min will overwrite even if we change the data retention time manually if min is greater than the configuration

## Fail Safe

1. Fail safe can be accessed only by contacting Snowflake Support. 
2. This will be stored after the Time Travel Period. 
3. Fail Safe will have 7 Days Period. 
4. Recovery Beyond Time Travel. 
5. Non-Configurable 
6. Contributes to storage cost.

## Storage Cost.
Use snowflake.account_usage.table_storage_metrics for monitoring the bytes in time travle and fail safe. 

## Table Types

### Types of Tables. 
1. Standard 
2. Temporary
3. Transient