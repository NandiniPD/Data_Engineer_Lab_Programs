{{ config(materialized='table') }}

SELECT DISTINCT
    p.productCode        AS product_id,
    p.productName        AS product_name,
    p.productLine        AS product_line,
    p.productVendor      AS product_vendor,
    p.quantityInStock    AS quantity_in_stock,
    p.buyPrice           AS buy_price,
    p.MSRP               AS msrp
FROM {{ source('raw', 'PRODUCTS') }} p
