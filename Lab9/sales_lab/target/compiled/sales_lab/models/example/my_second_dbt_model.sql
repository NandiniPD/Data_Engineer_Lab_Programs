-- Use the `ref` function to select from other models

select *
from SALES_DB.SALES_SCHEMA.my_first_dbt_model
where id = 1