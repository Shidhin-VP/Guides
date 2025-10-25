# Full Details about Section 2: Snowflake Architecture

# Multi-Cluster Shared Disk

## Traditional Architectures

1. Shared-Disk 
2. Shared-Nothing

### Shared-Disk 
Storage is common to all the nodes 

### Advantages
1. Simplicity
2. Shared Storage (Data Management)

### Disadvantages
1. Network Bottleneck
2. Single Point of Failure
3. Limited Scalability

### Shared-Nothing
Each node is independant and have it's own storage

### Advantages
1. Scalability
2. High Availability 

### Disadvantages
1. Expensive
2. More Complex Management. 

## Snowflake Took What? 
Snowflake took the Advantages of these 2 Architecture and made one.   
This is also called as **Multi-Cluster Shared Architecture**.   

***Took***:
1. Central Data Repository. 
2. Massive Parallel Processing Compute Cluster (MMP). - Also, Each Node stores a portion of the data locally. 

# Three Distinct Layer. 

The Three Distinct Layers are: 
1. Database Storage (Lower Layer)
2. Compute Processing/ Query Processing (Middle Layer)
3. Cloud Services (Top Layer)

## Database Storage.

1. It is Decoupled from Compute. 
2. It is called **Hybrid/Compressed Columnar Storage** 
3. It is Called ***Compressed Columnar Storage**, because, the datas are compressed and are stored in block. 
4. These blocks are stored in an external cloud provider. 
5. Snowflake manages all the aspect about storage. 
6. Optimized for OPAL/ Analytical purposes. 

## Compute Layer. 

1. Here is where the query's are computed or processed. 
2. It have Virtual Warehouse or also called just "WareHouse".
3. This is called the **Muscle of the System**.
4. This Layer provides resources like: CPU, Memory, and Temporary Storage.

## Cloud Services. 

1. It is the top layer and it manages different services. 
2. It is called the **Brain of the System**
3. Collection of services to coordinate & manage the components. 
4. Also, run on compute instances of cloud provider.
5. Services Includes: 
    * Authentication. 
    * Access Control. 
    * Query Parsing and Optimization. 
    * Metadata Management. 
    * Infrastructure Management. 

# Hands-On: First Data Loading. 

## You can follow these below steps to load a sample dataset into AWS. (Optional but recommended for first time learners (Either Snowflake or AWS))

1. Visit: https://aws.amazon.com/console/
2. Click: **Sign in to Console**
3. Either Create or Login to AWS Console
    * This [Video](https://youtu.be/Nzv-tzU-UAw?si=JR7VXyc7VB5RB5IT&t=70) can help you to start if this is your first time using AWS (Just the Creation Part (Till 2:19)). 
4. Navigate to S3 Bucket.   
    * ***Reference Image*** <img width="645" height="632" alt="image" src="https://github.com/user-attachments/assets/fa0fd9d9-5e6b-4f82-91d2-f8cd739b4f75" />


# Snowflake Editions.
