# Databricks notebook source
from pyspark.sql.functions import sum as spark_sum

# 1. Load the Silver table
df_silver = spark.table("silver_healthcare_orders")

# 2. Total revenue per service_category
df_service_sales = (
    df_silver.groupBy("service_category")
             .agg(spark_sum("total_bill").alias("total_revenue"))
)

df_service_sales.createOrReplaceTempView("tmp_healthcare_service_sales")

spark.sql("""
CREATE OR REPLACE TABLE gold_healthcare_service_sales AS
SELECT * FROM tmp_healthcare_service_sales
""")

# 3. Daily revenue trends
df_daily_sales = (
    df_silver.groupBy("order_date")
             .agg(spark_sum("total_bill").alias("daily_revenue"))
)

df_daily_sales.createOrReplaceTempView("tmp_healthcare_daily_sales")

spark.sql("""
CREATE OR REPLACE TABLE gold_healthcare_daily_sales AS
SELECT * FROM tmp_healthcare_daily_sales
""")

# 4. City-level revenue (optional)
df_city_sales = (
    df_silver.groupBy("city")
             .agg(spark_sum("total_bill").alias("city_revenue"))
)

df_city_sales.createOrReplaceTempView("tmp_healthcare_city_sales")

spark.sql("""
CREATE OR REPLACE TABLE gold_healthcare_city_sales AS
SELECT * FROM tmp_healthcare_city_sales
""")

# ✅ Quick previews
display(spark.table("gold_healthcare_service_sales").limit(10))
display(spark.table("gold_healthcare_daily_sales").limit(10))
display(spark.table("gold_healthcare_city_sales").limit(10))
