
  
    

        create or replace transient table SALES_DB.SALES_SCHEMA.dim_employees
         as
        (

SELECT DISTINCT
    e.employeeNumber AS employee_id,
    e.firstName,
    e.lastName,
    e.email,
    e.officeCode     AS office_code,
    e.jobTitle
FROM SALES_DB.SALES_SCHEMA.EMPLOYEES e
        );
      
  