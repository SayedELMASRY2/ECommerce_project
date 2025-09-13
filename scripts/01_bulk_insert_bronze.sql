/* ============================================================
   Script Name: 01_bulk_insert_bronze.sql
   Description : Truncate & Bulk insert all CRM & ERP CSV files 
                 into the Bronze Layer (Raw Ingestion).
   Author      : Sayed Elmasry
   Date        : 2025-09-13
   ============================================================ */

/* =========================
   CRM Data - Bulk Insert
   ========================= */

-- Customer Sessions
TRUNCATE TABLE bronze.crm_customer_session;
BULK INSERT bronze.crm_customer_session
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customer_sessions.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Customers
TRUNCATE TABLE bronze.crm_customers;
BULK INSERT bronze.crm_customers
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Discounts
TRUNCATE TABLE bronze.crm_discount;
BULK INSERT bronze.crm_discount
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\discounts.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Reviews
TRUNCATE TABLE bronze.crm_reviews;
BULK INSERT bronze.crm_reviews
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\reviews.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Wishlists
TRUNCATE TABLE bronze.crm_wishlists;
BULK INSERT bronze.crm_wishlists
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\wishlists.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


/* =========================
   ERP Data - Bulk Insert
   ========================= */

-- Categories
TRUNCATE TABLE bronze.erp_categories;
BULK INSERT bronze.erp_categories
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\categories.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Inventory Movements
TRUNCATE TABLE bronze.erp_inventory_movements;
BULK INSERT bronze.erp_inventory_movements
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\inventory_movements.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Order Details
TRUNCATE TABLE bronze.erp_order_details;
BULK INSERT bronze.erp_order_details
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\order_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Orders
TRUNCATE TABLE bronze.erp_orders;
BULK INSERT bronze.erp_orders
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Payments
TRUNCATE TABLE bronze.erp_payments;
BULK INSERT bronze.erp_payments
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\payments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Products
TRUNCATE TABLE bronze.erp_products;
BULK INSERT bronze.erp_products
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Returns
TRUNCATE TABLE bronze.erp_returns;
BULK INSERT bronze.erp_returns
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\returns.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Shipping
TRUNCATE TABLE bronze.erp_shipping;
BULK INSERT bronze.erp_shipping
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\shipping.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Suppliers
TRUNCATE TABLE bronze.erp_suppliers;
BULK INSERT bronze.erp_suppliers
FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\suppliers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
