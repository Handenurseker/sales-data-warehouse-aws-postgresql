# Sales Data Warehouse with AWS, PostgreSQL and Apache Hop

## Project Overview
This project demonstrates an end-to-end Data Warehouse architecture built using Apache Hop, PostgreSQL, and AWS.

The project includes:
- ETL orchestration using Apache Hop workflows
- Full refresh loading strategy for product and sales data
- Incremental (delta) loading strategy for sales transaction data
- Staging and core warehouse layers
- Fact and dimension table modeling
- Data transformation and calculation processes

The PostgreSQL warehouse environment was hosted on AWS and connected to Apache Hop pipelines for ETL processing

## Tools & Technologies
- AWS
- PostgreSQL
- DBeaver
- Apache Hop
- SQL
- ETL
- Data Warehousing
- Dimensional Modeling
- Star Schema

## Database Architecture
The project uses three schemas:

### Public Schema
Stores raw source data.
Tables:
- products
- sales
- date_dim

### Staging Schema
Stores temporarily transformed data.
Tables:
- stg_products
- sales

### Core Schema
Stores analytical warehouse tables.
Tables:
- dim_products
- dim_payment
- sales (fact table)

## ETL Process
The ETL process was developed using Apache Hop.
Main transformations:
- Product brand splitting into product_name and brand_name
- Data cleaning and trimming unnecessary spaces
- Handling missing payment values with default cash payment
- Loading cleaned data into dimension tables
- Creating fact table relationships

## Data Model
Dimension Tables:
- dim_products
- dim_payment
- date_dim

Fact Table:
- core.sales

The fact table stores transactional sales data and references dimension tables using foreign keys.

## ETL Workflow Screenshots

### Complete ETL Workflow
![Complete ETL Workflow](screenshots/01_complete_etl_process.PNG)

### Staging Workflow
![Staging Workflow](screenshots/02_staging_workflow.PNG)

### Core Workflow
![Core Workflow](screenshots/03_core_workflow.PNG)

### Fact Sales Pipeline
![Fact Sales Pipeline](screenshots/10_fact_sales_preview.PNG)
