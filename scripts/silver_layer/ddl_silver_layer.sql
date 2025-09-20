/*
Created By: Sakhekile Mtyingizane
Created Date: 09/09/2025
Description: The script manages the creation of Silver-layer tables in the silver schema using a drop-and-recreate pattern to maintain schema integrity.

crm_cust_info: Customer master data (IDs, names, marital status, gender, creation date).

crm_prd_info: Product master data (IDs, name, cost, line, lifecycle dates).

crm_sales_details: Transactional sales data (orders, products, customers, sales amounts, quantity, price, order lifecycle dates).

erp_loc_a101: ERP location data (customer/entity ID, country).

erp_cust_az12: ERP customer demographics (ID, birthdate, gender).

erp_px_cat_g1v2: ERP product categorization (ID, category, subcategory, maintenance).

Each table includes a dwh_create_date column with a GETDATE() default to capture creation metadata for auditing and lineage.

These tables form the curated Silver layer, bridging raw system extracts with the Gold layer for advanced analytics, BI dashboards, and machine learning use cases.*/



IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_sex            NVARCHAR(50),
    cst_create_date     DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id       INT,
    cat_id       NVARCHAR(50),
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO

IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO

IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE() --- Adding metadata column to get the date this DDL is/was created.
);
GO
