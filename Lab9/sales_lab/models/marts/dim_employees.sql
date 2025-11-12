{{ config(materialized='table') }}

SELECT DISTINCT
    e.employeeNumber AS employee_id,
    e.firstName,
    e.lastName,
    e.email,
    e.officeCode     AS office_code,
    e.jobTitle
FROM {{ source('raw', 'EMPLOYEES') }} e
