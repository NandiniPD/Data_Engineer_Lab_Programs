
  create or replace   view SALES_DB.SALES_SCHEMA.stg_employees
  
   as (
    

SELECT
    employeeNumber AS employee_id,
    lastName,
    firstName,
    jobTitle,
    officeCode,
    reportsTo
FROM SALES_DB.SALES_SCHEMA.EMPLOYEES
  );

