
  create or replace   view SALES_DB.SALES_SCHEMA.stg_offices
  
   as (
    

SELECT
    officeCode,
    city,
    phone,
    addressLine1,
    addressLine2,
    state,
    country,
    postalCode,
    territory
FROM SALES_DB.SALES_SCHEMA.OFFICES
  );

