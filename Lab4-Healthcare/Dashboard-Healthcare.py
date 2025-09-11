# Databricks notebook source
# ------------------------------------
# Dashboard: Healthcare Orders Analysis
# ------------------------------------

# Cell 1: Imports
import io
import base64
import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime

# Helper to convert matplotlib figure → base64 HTML <img>
def fig_to_base64(fig, fmt="png"):
    buf = io.BytesIO()
    fig.savefig(buf, format=fmt, bbox_inches="tight")
    buf.seek(0)
    img_b64 = base64.b64encode(buf.read()).decode("utf-8")
    buf.close()
    plt.close(fig)
    return f"data:image/{fmt};base64,{img_b64}"

# ------------------------------------
# Cell 2: Load Gold Tables
# ------------------------------------
df_service = spark.table("gold_healthcare_service_sales").toPandas()
df_daily = spark.table("gold_healthcare_daily_sales").toPandas()

# Ensure proper types
if "order_date" in df_daily.columns:
    df_daily["order_date"] = pd.to_datetime(df_daily["order_date"])

# ------------------------------------
# Cell 3: Create Charts
# ------------------------------------

# Chart 1: Bar chart → Revenue by Service Category
fig1, ax1 = plt.subplots(figsize=(7,4))
ax1.bar(df_service["service_category"].astype(str), df_service["total_revenue"], color="skyblue")
ax1.set_title("Revenue by Service Category")
ax1.set_xlabel("Service Category")
ax1.set_ylabel("Total Revenue")
ax1.tick_params(axis='x', rotation=30)
fig1_b64 = fig_to_base64(fig1)

# Chart 2: Line chart → Daily Revenue Trend
fig2, ax2 = plt.subplots(figsize=(8,4))
ax2.plot(df_daily["order_date"], df_daily["daily_revenue"], marker="o", color="green")
ax2.set_title("Daily Revenue Trend")
ax2.set_xlabel("Order Date")
ax2.set_ylabel("Daily Revenue")
fig2.autofmt_xdate()
fig2_b64 = fig_to_base64(fig2)

# ------------------------------------
# Cell 4: KPIs
# ------------------------------------
total_revenue = df_service["total_revenue"].sum() if not df_service.empty else 0
top_service = (
    df_service.sort_values("total_revenue", ascending=False).iloc[0]["service_category"]
    if not df_service.empty else "N/A"
)
last_update = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# ------------------------------------
# Cell 5: Render Dashboard
# ------------------------------------
html_template = f"""
<div style="font-family:Arial; padding:16px;">
  <h2>Healthcare Orders Dashboard</h2>
  <div style="color:#666; margin-bottom:12px;">Last Updated: {last_update}</div>

  <!-- KPI cards -->
  <div style="display:flex; gap:20px; margin-bottom:20px;">
    <div style="flex:1; background:#f9f9f9; padding:12px; border-radius:8px; box-shadow:0 1px 3px rgba(0,0,0,0.1);">
      <div style="font-size:12px; color:#777;">Total Revenue</div>
      <div style="font-size:22px; font-weight:700;">₹ {total_revenue:,.2f}</div>
    </div>
    <div style="flex:1; background:#f9f9f9; padding:12px; border-radius:8px; box-shadow:0 1px 3px rgba(0,0,0,0.1);">
      <div style="font-size:12px; color:#777;">Top Service Category</div>
      <div style="font-size:22px; font-weight:700;">{top_service}</div>
    </div>
  </div>

  <!-- Charts -->
  <div style="display:flex; gap:20px;">
    <div style="flex:1;">
      <h4>Revenue by Service Category</h4>
      <img src="{fig1_b64}" style="width:100%; border-radius:6px;"/>
    </div>
    <div style="flex:1;">
      <h4>Daily Revenue Trend</h4>
      <img src="{fig2_b64}" style="width:100%; border-radius:6px;"/>
    </div>
  </div>
</div>
"""

displayHTML(html_template)
