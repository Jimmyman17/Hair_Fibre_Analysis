# Hair_Fibre_Analysis
# 📦 ReXI Fiber Inventory Forecasting Project

## 🧩 Project Overview

This project builds an end-to-end SQL-based analytics pipeline to forecast ReXI fiber bundle requirements for manufacturing final products. By combining product sales data and fiber usage patterns, the solution forecasts the fiber demand assuming 10,000 units are to be produced, helping inform inventory planning and resource allocation.

---

## 🎯 Business Objective

To determine how much of each ReXI fiber type will be required if 10,000 product units are to be manufactured. This ensures:

- Efficient inventory control.
- Better supply chain planning.
- Cost optimization through demand forecasting.

---

## 🧾 Data Sources

Two CSV files are used as input:

1. **Products Sold**
   - File: `Case Study_ Inventory Forecast - Products Sold.csv`
   - Fields:
     - `Order ID` – Unique identifier for each sale.
     - `Final Product Name` – Product sold.

2. **ReXI Fiber Bundles Required**
   - File: `Case Study_ Inventory Forecast - ReXI Bundles Required.csv`
   - Fields:
     - `Final Product` – Product type.
     - `ReXI Fiber Required To Make Final Product` – Fiber type.
     - `Quantity of ReXI Fiber Bundles Required To Make Final Product` – Fiber quantity per product.

---

## 🗂️ Database Structure

Database: `Fibre`

### Tables

#### 🔸 Product_Sold
| Column | Type | Description |
|--------|------|-------------|
| Order ID | `NVARCHAR(50)` | Unique order reference |
| Final Product Name | `NVARCHAR(200)` | Name of product sold |

#### 🔸 ReXI_Bundles_Required
| Column | Type | Description |
|--------|------|-------------|
| Final Product | `NVARCHAR(200)` | Product name |
| ReXI Fiber Required To Make Final Product | `NVARCHAR(200)` | Fiber type |
| Quantity of ReXI Fiber Bundles Required To Make Final Product | `NVARCHAR(200)` | Fiber bundles per product |

---

## ⚙️ SQL Pipeline Breakdown

### 1. **Database & Table Initialization**

-- Creates Fibre database and required tables
-- Drops if already existing

## 📄  Bulk Data Import

-- Loads CSV data into tables using BULK INSERT
-- Truncates existing data before import


## 📄  Fiber Forecasting Logic
-- Joins product sales with fiber requirements
-- Computes each product's share of total fiber usage
-- Forecasts fiber need assuming 10,000 units will be sold


📁 ReXI_Forecasting_Project/
│
├── 📄 1_Create_Database_And_Tables.sql
├── 📄 2_Bulk_Import_Data.sql
├── 📄 3_Forecast_Fiber_Demand.sql
├── 📊 Data Files:
│   ├── Case Study_ Inventory Forecast - Products Sold.csv
│   └── Case Study_ Inventory Forecast - ReXI Bundles Required.csv
└── 📘 README.md  ← (this file)

