1. 
```
Search optimization does not support:

External tables.

Materialized views.

Columns defined with a COLLATE clause.

Column concatenation.

Analytical expressions.

Casts on table columns (except for fixed-point numbers cast to strings).
```
2. 
```
Snowflake saves data on the warehouse's local disk if it can't fit an operation into memory. Data spilling slows down queries because it requires more IO operations, and disk access is slower than memory access. "Bytes spilled to local storage." indicates local spillage. Snowflake will spill data to remote cloud storage if the local disk becomes full, which is even slower storage than the local disk, making this operation even slower. "Bytes spilled to remote storage" in the query profile indicates remote spillage.
```

3. 
```
Snowflake is compliant with the following security and financial standards.

· IRAP Protected

· ITAR

· FedRAMP Moderate

· GxP

· SOC 1 Type II

· SOC 2 Type II

· PCI-DSS

· HITRUST / HIPAA

· ISO/IEC 27001
```

4. 
```
The following strategies may be applied to improve the performance of a virtual warehouse.



1. Reduce queuing

2. Resolve memory spillage.

3. Increase warehouse size.

4. Try query acceleration.

5. Optimize the warehouse cache.

6. Limit concurrently running queries.
```

5. 
```
Only Snowflake support can set the value for the MINS_TO_BYPASS_NETWORK_POLICY property for a user.
```

6. 
```
External tables are a good solution for:

Data is already in a data lake on a cloud platform (e.g., S3, Azure Blob Storage)
The data is not accessed frequently.
Typically only a subset of data is accessed.
```