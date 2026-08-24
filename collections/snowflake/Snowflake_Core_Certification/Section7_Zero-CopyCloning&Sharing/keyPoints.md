# Zero-Copy Cloning. 
1. This is a Metadata Operation. 
2. Only add new Micro-Partions if the table is Updated, or Cloning updated.
3. If the cloning table updates the Table won't be updated.
4. All the privileges of the child will be inhereted
5. Source Privileges won't be inhereted. 
6. We can Only Clone: 
    * Database. 
    * Schema
    * Table
    * Task
    * Stream
    * File Format
    * Sequences
    * Stage
    * Pipe
7. Limitations:     
    * Stage -> Cannot use Internal Named Stage
    * Pipe -> Can only use External Stage
8. Privileges: 
    Usage-> All other Objects. 
    Select-> Table
    Ownership-> Task, Stream, Pipe
9. Load History Metadata is not copied
10. This will load again as metadata is not copied. 
11. Can combine with TimeTravel.

# Data Sharing
1. Can Share: 
    * Secure UDFs
    * Secure Materialized View
    * Secure Views
    * External Table.
    * Tables. 
2. There is a Provider and Consumer
3. We need AccountAdmin Role to create Sharing
4. Consumer only reads the Data and pays for the compute resource of consumers account
5. As normal the Provider only will pay for Storage as it is already there. 
6. At a same time the accounts can be a Provider and Consumer. 
7. Available for all Snowflake Editions. 
8. Setting Up Share. 
    * Create Share Shell
    * Grant Privileges. 
    * Add Consumer Accounts. 
    * Import Share
9. Data Sharing with Non-Snowflake User. 
    * Setup Readers Account. 

# Database Replications 
1. Same like before, but now Sharing between Account to account within different cloud provider and region. 
2. NOw the data is physically stored in the consumer account. 
3. Cannot be modified. 
4. Read Only
5. Will have: 
    * Primary Database
    * Replica/ Secondary Database
6. Also, Called as **Cross-Region Sharing**
7. Must be enabled on Account Level. 
8. We need OWNERSHIP privileges to **Refresh** Database