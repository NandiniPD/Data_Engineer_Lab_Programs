
# Lab 5 – On-Premise Data Lake Setup using MinIO, Hive Metastore, and Trino

## Objective
The goal of this lab is to deploy an open-source data lake environment locally and interact with it using SQL queries. The setup uses:  
- **MinIO** → Object storage (S3 compatible)  
- **Hive Metastore** → Stores metadata (schemas, partitions, file locations)  
- **Trino** → Distributed SQL query engine  
- **DBeaver** → Client tool for running SQL queries  

---

## Requirements
Before beginning, make sure you have:  
## 🔧 Prerequisites
- Windows 10/11 with **Docker Desktop** installed  
  👉 [Install Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)  
- Docker Compose installed  
- **DBeaver Community Edition** installed  
  👉 [Download DBeaver](https://dbeaver.io/download/)  
---

## Step-by-Step Setup

### 1. Run Containers with Docker
- Open a terminal and go to the folder containing your `docker-compose.yml`.  
- Execute the command:  
  ```bash
  docker-compose up
  ```  
- This will launch the containers for MinIO, Trino, and Hive Metastore.  

---

### 2. Using the MinIO Dashboard
- Go to [http://localhost:9001](http://localhost:9001) in your browser.  
- Log in with the following:  
  - **Access Key:** `minio_access_key`  
  - **Secret Key:** `minio_secret_key`  

---

### 3. Access the Trino Coordinator
- Open [http://localhost:8086](http://localhost:8086).  
- Login with user: `trino`.  
- Here, you can monitor and manage queries submitted to Trino.  

---

### 4. Configure DBeaver for Trino
- Launch **DBeaver** and create a new connection.  
- Select **Trino** as the driver.  
- Connection details:  
  - Host: `localhost`  
  - Port: `8086`  
  - User: `trino`  
- Test and save the connection.  

---

### 5. Define Schema in Hive
Run this SQL command inside DBeaver:  
```sql
CREATE SCHEMA IF NOT EXISTS hive.sales
WITH (location = 's3a://sales/');
```  

---

### 6. Create a Sales Table in MinIO
Execute the following:  
```sql
CREATE TABLE IF NOT EXISTS minio.sales.sales_tz (
    productcategoryname     VARCHAR,
    productsubcategoryname  VARCHAR,
    productname             VARCHAR,
    country                 VARCHAR,
    salesamount             DOUBLE,
    orderdate               TIMESTAMP
)
WITH (
    external_location = 's3a://sales/',
    format = 'PARQUET'
);
```  

---

### 7. Query Sample Data
Verify the setup by running:  
```sql
SELECT * FROM minio.sales.sales_tz LIMIT 10;
```  
You should see rows returned from the `sales_tz` table.  

---

