# Query Profile. 
1. Where can we find? 
    * **Query History** Tab under the **Activity Section**
2. Different Components for Graphical Representation
    * Main: 
        * Operator Tree. 
        * Nodes. 
        * Operator Type. 
            * Aspects of Query Processing and Execution. 
        * Data Flow. 
            * Records Processed between those different nodes. 
        * Precentage. 
    * Side: 
        * Overview. 
        * Statistics. 
            * Byte Scanned.
            * Scanned from Cache. 
            * Data Spilling. 
3. Data Spilling.  
    ```mermaid
        graph TD;
            Query_Processing-->Local_Storage_Spill; 
            Local_Storage_Spill-->Remote_Cloud_Storage_Spill;
    ```
    * Memory is the Key, if Spilled, will reduce the performance. 
4. How to avoid Spilling. 
    * Reduce Parallel Data Processing. 
    * Reduce the # of Data Processed by Changing Query. 
    * If sustained, **Increase Warehouse**. 
5. Ways to access the Query History. 
    * Query History Tab in Activity Session. 
    * Query_History table function in Information_Schema. 
    * Query_History view in Account_Usage. 

# Caching. 
1. Types of Caching. 
    * Query Result Caching. 
        * Saves the Result of the Query of User Processed. 
        * Syntax, Metadata, Updation and more should not be Processed. 
        * Cannot contain UDFs or External Functions. 
        * Can be DISABLED using : **USE_CACHED_RESULT** parameter.
        * Retention Period: 
            * If Query is not Queried again, it will **Purged** after **24 Hours**
            * If Query is Queried again and again, the data retention Period will be up to **31 Days**
    * MetaData Caching. 
        * The above two are in **Cloud Server Layer**
        * This also includes properties of **Query Optimization and Processing**
        * Caches: 
            * Statistics. 
            * Analytical data of the Micro-Partitions, Table and more. 
            * Can use Count, Max, Min Commands. 
            * This can also use **Show and DESCRIBE Commands** + **System Defined Functions**
        * Sometimes called **Metadata Store**
        * Dedicated Metadata for Virtual Private Edition.
    * Data Caching (Local Disk I/O)
        * Local SSD Warehous Cache
        * Also, called **Virtual Warehouse Cache**
        * Is in the **Query Processing Layer**
        * Retention Period: 
            * When the Warehouse is **Suspended** or **Resized**
        * Size Depends on Warehouse Size.
    - Remote Disk
        * This is not a Cache, but we can pull data from here, which is in the **Data Storage Layer**

# Micro-Partitions. 
1. Columnar Format. 
2. Managed by Snowflake. 
3. Load Metadata will be upto 64 Days. 
4. 50-500MB of **Uncompressed Data**. 
5. Datas are compressed automatically by snowflake by selecting a compression algorithm according to the column. 
6. Eliminates unnecessary partitions when querying. 
7. Can have millions and billions of partitions. 
8. Micro-Partitions are **Immutable** 
9. Data as stored as it is given. 
10. By adding clustering Key we can add influence on performance. 
11. Metadata in Partitions: 
    * Count of Distinct Values. 
    * Range of Values
    * Additional Properties for Query Optimization. 

# Clustering. 
1. Will order similar data together. 
2. **Serverless Computation** 
3. Fully Managed by Snowflake. 
4. Optimized Partition Pruning. 
5. Metatdata Stored: 
    * Number or Micro-Partitions in a Table. 
    * Overlapping MicroPartitions. 
    * Clustering Depth. 
6. Overlapping MP
    * MP that overlapps 
    * We need to make the table Ideal to get the Constant State, which will have the better Clustering Table to Prune.
    * Higher Constant Partition would be great.
7. Clustering Depth. 
    * Average Depth of overlapping MP for specif **Column**
    * Should have **Lower Average Depth**
    * Average Depth: 1, would be great. 

# Defining Clustering Key. 
1. Select Column that will be queried most of the time
2. Go from **Low Cardinality** to **High Cardinality** columns when adding **Clustering Key** to a table. 
3. Don't keep **Too Low Cardinality** 
4. Don't keep **High Cardinality**
5. Use Command: 
    ```sql
    ALTER TABLE TABLE1 CLUSTER BY(COLUMN1, COLUMN2);
    DROP TABLE TABLE1 CLUSTER KEY; 
    ```
6. Old partitions are delted. 
7. This will cost Storage Cost until the Time Travel and Fail Safe Period ends. 
8. Clustering is not good for every table. 
9. Tradoffs. 
    * Performance <=> Cost. 
10. Benifits from Clustering Key are: 
    * Very Large Tables. 
    * Multiple Terrabytes of Data. 
    * Where, JOIN, and ORDER BY (Order by not more than Where and JOIN)
    * Low Cardinality => No Effective Pruning
    * High Cardinality => No Efficient Grouping 
11. System Functions on Clustering. 
    * ```SYSTEM$CLUSTERING_INFORMATION('TABLENAME','COLUMNNAME')```
    * ```SYSTEM$CLUSTERING_DEPTH('TABLENAME','COLUMNNAME')```

# Search Optimization Service. 
1. This is used for performance for Specif Query like types of **Lookup** and **Analytical Queries**
2. Will add **Search Access Path** to a table or column. 
3. Queries Benifited: 
    * Selective Point Look-Up
    * EQUALITY(*) Predicates and IN Predicates
    * Substrings or Regular Expressions
    * Selective GeoSpatial Functions. 
4. These features are mainted by snowflake. 
5. Privileges needed: 
    * OWNERSHIP for Object. 
    * ADD Schema Optimization Privileges for Schema Level. 
6. Additional Storage for **Maintaining** Search Access Path. 

# Materialized View. 
1. The Base table should be a Standard Table, not any views. 
2. This is auto-sync. 
3. Managed by Snowflake. 
4. Serverless
5. Data's are pre-computed and physically stored. 
6. Refering Command: 
    ```sql
    SELECT * FROM TABLE(INFORMATION_SCHEMA.MATERIALIZED_VIEW_REFRESH_HISTORY());
    ```
7. We can make a Materialized View on an External Table.
8. Limitations. 
    * only one query from 1 Table. 
    * Cannot Use: 
        * Windows Functions. 
        * UDFs
        * HAVING Clause. 
        * ORDER BY. 
        * JOINS
        * Few Aggregation Functions. 
9. Even if we suspend we are only Delying the Cost, because when we resume the Materialized View, there will be some kind of Maintance where we will spend cost ranther than saving. 

# Warehouse Considerations. 
1. Scale Out-> If Concurrent Users. 
2. Scale Up-> If Complex Queries. 
3. Resizing -> Only affect the upcomming Queries. 
4. Dedicated Warehouse -> 
    * For Seperating Users.
    * For Specific Workloads. 
5. Can also be Auto-Suspend and Auto-Resume. 