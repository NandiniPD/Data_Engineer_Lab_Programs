

SELECT
    orderNumber AS order_id,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    customerNumber AS customer_id
FROM SALES_DB.SALES_SCHEMA.ORDERS