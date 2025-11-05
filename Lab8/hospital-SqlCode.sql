-- 1️ Database and Schema Creation
CREATE OR REPLACE DATABASE HOSPITAL_DB;
USE DATABASE HOSPITAL_DB;

CREATE OR REPLACE SCHEMA PATIENT_SCHEMA;
USE SCHEMA PATIENT_SCHEMA;

-- 2️ Raw table: everything as VARCHAR to accept messy input
CREATE OR REPLACE TABLE RAW_PATIENTS (
  patient_id     VARCHAR,
  name           VARCHAR,
  age            VARCHAR,
  gender         VARCHAR,
  visit_date     VARCHAR,
  diagnosis_code VARCHAR,
  bill_amount    VARCHAR,
  received_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP
);

-- 3️ Clean table: typed columns + processed timestamp
CREATE OR REPLACE TABLE CLEAN_PATIENTS (
  patient_id     INTEGER,
  name           VARCHAR,
  age            INTEGER,
  gender         VARCHAR,
  visit_date     DATE,
  diagnosis_code VARCHAR,
  bill_amount    FLOAT,
  processed_at   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP
);

-- 4️ Create a warehouse if not exists
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH
  WITH WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

-- 5️ Create a stream on RAW_PATIENTS
CREATE OR REPLACE STREAM RAW_PATIENTS_STREAM
ON TABLE RAW_PATIENTS;

-- 6️ Create Data Cleaning Task
CREATE OR REPLACE TASK CLEANING_TASK
WAREHOUSE = COMPUTE_WH
SCHEDULE = '10 MINUTE'
AS
INSERT INTO CLEAN_PATIENTS (patient_id, name, age, gender, visit_date, diagnosis_code, bill_amount)
SELECT
    TRY_TO_NUMBER(patient_id) AS patient_id,
    name,
    COALESCE(TRY_TO_NUMBER(age), 0) AS age,
    gender,
    COALESCE(
        TRY_TO_DATE(visit_date, 'YYYY-MM-DD'),
        TRY_TO_DATE(visit_date, 'DD-MM-YYYY'),
        TRY_TO_DATE(visit_date, 'MM/DD/YYYY'),
        CURRENT_DATE()
    ) AS visit_date,
    diagnosis_code,
    COALESCE(TRY_TO_NUMBER(REPLACE(bill_amount, ',', '')), 0) AS bill_amount
FROM RAW_PATIENTS_STREAM;

-- 7️ Enable the Task
ALTER TASK CLEANING_TASK RESUME;

-- 8️ Insert Sample Messy Data
INSERT INTO RAW_PATIENTS (patient_id, name, age, gender, visit_date, diagnosis_code, bill_amount)
VALUES
('1', 'John Doe', '30', 'Male', '2025-10-21', 'D01', '5,000'),
('2', 'Jane Smith', 'Twenty-Five', 'Female', '21-10-2025', 'D02', '3,200'),
('3', 'Alex Brown', NULL, 'Male', '2025/10/22', 'D03', 'abc'),
('4', 'Mary Lee', '40', NULL, NULL, 'D04', NULL);

-- 9️ Manually run task (optional immediate run)
EXECUTE TASK CLEANING_TASK;

-- 10 Verification Queries
SELECT * FROM CLEAN_PATIENTS ORDER BY patient_id;

SELECT COUNT(*) AS total_raw FROM RAW_PATIENTS;
SELECT COUNT(*) AS total_cleaned FROM CLEAN_PATIENTS;
SELECT * FROM CLEAN_PATIENTS WHERE bill_amount < 0 OR age < 0 OR age > 120;


--------O/P------------
SHOW TASKS;
SHOW STREAMS;
SELECT * FROM CLEAN_PATIENTS;
