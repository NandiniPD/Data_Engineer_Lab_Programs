
  create or replace   view SALES_DB.SALES_SCHEMA.stg_products
  
   as (
    

SELECT
    productCode AS product_code,
    productName,
    productLine,
    productScale,
    productVendor,
    quantityInStock,
    buyPrice,
    MSRP
FROM SALES_DB.SALES_SCHEMA.PRODUCTS
  );

