

SELECT DISTINCT
    c.customerNumber      AS customer_id,
    c.customerName        AS customer_name,
    c.contactFirstName    AS contact_first,
    c.contactLastName     AS contact_last,
    c.phone,
    c.city,
    c.state,
    c.country,
    c.salesRepEmployeeNumber AS sales_rep_id
FROM SALES_DB.SALES_SCHEMA.CUSTOMERS c