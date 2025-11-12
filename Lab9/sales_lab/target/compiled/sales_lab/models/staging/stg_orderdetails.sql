

SELECT
    orderNumber AS order_id,
    productCode AS product_code,
    quantityOrdered AS quantity,
    priceEach AS unit_price,
    orderLineNumber AS line_number
FROM SALES_DB.SALES_SCHEMA.ORDERDETAILS