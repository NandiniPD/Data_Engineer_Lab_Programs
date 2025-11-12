{{ config(materialized='view') }}

SELECT
    productLine,
    textDescription,
    htmlDescription
FROM SALES_DB.SALES_SCHEMA.PRODUCTLINES
