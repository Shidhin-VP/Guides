# Data Transformation & Functions
1. 
    |Supports|Not Supports|
    |--------|------------|
    |Column Reordering|Aggregation Function|
    |Remove Columns|Faltten Function|
    |TruncateColumns|Group By|
    |Concatinate columns|Filter by With|
    |subset of SQL Function|JOINs|
    |Cast Data Types||
2. Functions. 
    * Scalar Functions. 
    * Aggregate Functions. 
    * Windows Functions. 
    * Table Functions. 
    * System Functions. 
    * UDFs & External Function. 
3. Estimation Functions: 
    * Distinct Values
        * Function: HLL()
        * Algorithm: HyperLogLog
        * Cardinality Estimation Function
    * Frequent Values
        * Function: Approx_Top_K()
        * Algorithm: Space-Saving 
        * Return K Frequent Values with Frequency 
        * Mention K and Counter
    * Percentile
        * Function: Approx_percentile()
        * Algorithm: t-Digest
        * Orders and returns the percentile Value
    * Similarity of two or more datasets 
        * Function: Approximate_Similarity(Minhash UnionAll Minhash)

# User Defined Function
1. Supported Languages: 
    * SQL
    * Python
    * Java 
    * Javascript
2. Will Return a Value

# Stored Procedures
1. Supported Language
    * Snowflake Scripting
    * Snowpark API 
        * Python
        * Java 
        * Scala
    * JavaScript
2. WE can use arguments
    * We need to use it with :variable name
3. We can also use Identifiers
4. Can access Objecs and perform Database Operation.
5. Doesn't need to return anything 
6. can either run as Caller or Owner 
7. Default is Owner
8. Execute as Caller/Owner 

# External Functions. 
1. Reference External Function outside of snowflake 
2. Not Sharable. 