
  create or replace   view SALES_DB.SALES_SCHEMA.stg_productlines
  
   as (
    

SELECT
    productLine,
    textDescription,
    htmlDescription
FROM SALES_DB.SALES_SCHEMA.PRODUCTLINES
  );

