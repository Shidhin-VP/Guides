# Zero-Copy Cloning & Sharing

## Zero-Copy Cloning
1. In snowflake we can clone a table very easily without any trouble. 
2. We can use this Command/cLONING SYNTAX. 
    ```sql
    CREATE TABLE NEWTALBENAME
    CLONE TABLE_SOURSE;
    ```
3. We can also clone other database objects
    * Database
    * Schema
    * Table
    * Stream
    * File Format
    * Sequence 
    * Task
    * Stage 
    * Pipe
4. With some limitations for **Stage and Pipe**
5. Pipe can only be cloned only if **Pipe** is referencing **External Stages**
6. **Named Internal Stages** are not Cloned in Stage. 
7. Cloning a database or schema will clone **<ins>all contained objects<ins>** with exception of Stage which has named internal stage and pipe referencing external stage. 

### Why it is called Zero-Copy Cloning 

1. we are cloning a table 
    * Original 
    * Copy 
2. This is a **Metadata Operation Only**
3. Executed by cloud service layer. 
4. The clone will still reference the same Micro-Partitions in the cloud provider. 
5. The copy talbe is completly indipendent table, we can query data from there. 
6. Because it is a **Metadata Operation** it is easy to copy and improve **Storage Management**
7. Creating Backups for Development Purposes. 
8. **Combined with Time Travel**
9. **Privileges of the Child objects will be inherited but not for the database itself and also true for schema and done by the administrator**

### What Privileges are needed? 
* Table -> SELECT
* PIPE -> OWNER
* STREAM -> OWNER
* TASK -> OWNER
* ALL OTHER OBJECTS -> USAGE

### Additional Considerations. 
1. Load history meta data is not copied
2. This can be loaded again as metadata is not copied. 

```sql
CREATE TABLE TABLE_NEW
CLONE TABLE_SOURCE
BEFORE (TIMESTAMP=>'timestamp')
```

**Cloning from specific point in time is not possible**

## Data Sharing
1. Usually when we share a data to a customer and if there is a change in the data we need to extract the data and update, and send again to the customer.
2. Now we can share the data without making a copy of the data. 
3. And we can let the consumers use there own resourses. 
4. Data is always up-to-date. 
5. Available to all of the snowflake editions

6. ***Account1 (Provider) -> Data is Synchronized -> Account2 (Consumer)  ***
7. Data cannot be modified. 
8. This is only a **Metadata Operations Only**
9. It is also possible to be a consumer and a provider at the same time. 
10. This is an account operations. 

### Setting Up Share. 
1. Create Share -> We need **AccountAdmin role** or **Create Share Privileges** 
```sql
CREATE SHARE MY_SHARE;
```
2. This above one is just a container in which we can grant priviliges. 
    ```sql
    GRANT USAGE ON DATABASE MY_DB TO SHARE MY_SHARE;
    GRANT USAGE ON SCHEMA MY_SCHEMA TO SHARE MY_SHARE; 
    GRANT SELECT ON TABLE MY_TABLE TO SHARE MY_SHARE;
    ```
3. Add Consumers Account
    ```sql
    ALTER SHARE MY_SHARE ADD ACCOUNT *****;
    ```
4. Import Share
    **AccountAdmin role or Import Share/Create Database** Privileges required
    ```sql
    CREATE DATABASE MY_DB FROM SHARE MY_SHARE;
    ```
5. If needed we can grant additional privileges as the privileges are not shared.

### What can be Shared. 
1. Tables. 
2. External Tables. 
3. Secure Views. 
4. Secure Materialized Views. 
5. Secure UDFs. 


## Data sharing with Non-Snowflake Users
1. Done by using Reader Account

## Database Replication
1. It is possible to share data outside of the region and cloud provider and it is possible by DAtabase Replication
2. This replicates a database between accounts within the same organization.  
3. Also called as **Cross-Region Sharing**
4. Data and Objects are synchronized periodically

* The database that we want to share is called **Primary Database** and the one which is reading is called **Secondary Database(Replica)**
* Read only database
* Must be enabled on **Account Level**

### How to replicate
1. Enable replication for source account with ORGADMIN role. 
    ```sql
    SHOW ORGANIZATION ACCOUNTS; 
    SELECT SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER('<organization_name>.<account_name>','ENABLE_ACCOUNT_DATABASE_REPLICATION','true')
    ```

2. Pormote local Databaset to Primary Database with **AccountAdmin** role. 
    ```sql
    ALTER DATABASE MY_DB1 ENABLE REPLICATION TO ACCOUNTS myorg.account2, myorg.account3;
    ```
3. Create replica in Consumer account
    ```sql
    CREATE DATABASE MY_DB1 AS REPLICA OF myorg.account1.my_db1;
    ```
4. Refresh Database -> We need **Ownership** Privileges
    ```sql
    ALTER DATABASE MY_DB1 REFRESH;
    ```
