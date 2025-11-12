

SELECT DISTINCT
    o.orderDate AS date_key,
    EXTRACT(DAY FROM o.orderDate) AS day,
    EXTRACT(MONTH FROM o.orderDate) AS month,
    EXTRACT(YEAR FROM o.orderDate) AS year,
    CASE
        WHEN EXTRACT(MONTH FROM o.orderDate) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN EXTRACT(MONTH FROM o.orderDate) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN EXTRACT(MONTH FROM o.orderDate) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS quarter
FROM SALES_DB.SALES_SCHEMA.ORDERS o
WHERE o.orderDate IS NOT NULL