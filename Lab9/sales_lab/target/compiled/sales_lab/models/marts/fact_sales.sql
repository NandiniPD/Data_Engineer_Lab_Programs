

SELECT
    od.orderNumber       AS order_id,
    o.orderDate          AS order_date,
    o.customerNumber     AS customer_id,
    od.productCode       AS product_id,
    c.salesRepEmployeeNumber AS employee_id,
    od.quantityOrdered   AS quantity,
    od.priceEach         AS price_each,
    (od.quantityOrdered * od.priceEach) AS total_revenue
FROM SALES_DB.SALES_SCHEMA.ORDERDETAILS od
JOIN SALES_DB.SALES_SCHEMA.ORDERS o
  ON od.orderNumber = o.orderNumber
LEFT JOIN SALES_DB.SALES_SCHEMA.CUSTOMERS c
  ON o.customerNumber = c.customerNumber