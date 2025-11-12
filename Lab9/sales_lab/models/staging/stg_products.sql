{{ config(materialized='view') }}

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
