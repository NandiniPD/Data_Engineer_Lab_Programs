

SELECT
    customerNumber AS customer_id,
    customerName AS customer_name,
    contactFirstName,
    contactLastName,
    phone,
    city,
    country,
    salesRepEmployeeNumber AS sales_rep_id
FROM SALES_DB.SALES_SCHEMA.CUSTOMERS