/* ============================================================
   Script Name : 01_bulk_insert_bronze.sql
   Description : Truncate & Bulk insert all CRM & ERP CSV files 
                 into the Bronze Layer (Raw Ingestion).
   Author      : Sayed Elmasry
   Date        : 2025-09-13
   ============================================================ */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        PRINT '=======================';
        PRINT ' Starting Bronze Load ';
        PRINT '=======================';

        /* =========================
           CRM Data - Bulk Insert
           ========================= */
        PRINT '------------------------------';
        PRINT ' Loading CRM Tables ';
        PRINT '------------------------------';

        -- Customer Sessions
        PRINT '>> Truncating: bronze.crm_customer_session';
        TRUNCATE TABLE bronze.crm_customer_session;

        PRINT '>> Inserting: bronze.crm_customer_session';
        BULK INSERT bronze.crm_customer_session
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customer_sessions.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Customers
        PRINT '>> Truncating: bronze.crm_customers';
        TRUNCATE TABLE bronze.crm_customers;

        PRINT '>> Inserting: bronze.crm_customers';
        BULK INSERT bronze.crm_customers
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customers.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Discounts
        PRINT '>> Truncating: bronze.crm_discount';
        TRUNCATE TABLE bronze.crm_discount;

        PRINT '>> Inserting: bronze.crm_discount';
        BULK INSERT bronze.crm_discount
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\discounts.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Reviews
        PRINT '>> Truncating: bronze.crm_reviews';
        TRUNCATE TABLE bronze.crm_reviews;

        PRINT '>> Inserting: bronze.crm_reviews';
        BULK INSERT bronze.crm_reviews
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\reviews.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Wishlists
        PRINT '>> Truncating: bronze.crm_wishlists';
        TRUNCATE TABLE bronze.crm_wishlists;

        PRINT '>> Inserting: bronze.crm_wishlists';
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
        PRINT '------------------------------';
        PRINT ' Loading ERP Tables ';
        PRINT '------------------------------';

        -- Categories
        PRINT '>> Truncating: bronze.erp_categories';
        TRUNCATE TABLE bronze.erp_categories;

        PRINT '>> Inserting: bronze.erp_categories';
        BULK INSERT bronze.erp_categories
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\categories.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Inventory Movements
        PRINT '>> Truncating: bronze.erp_inventory_movements';
        TRUNCATE TABLE bronze.erp_inventory_movements;

        PRINT '>> Inserting: bronze.erp_inventory_movements';
        BULK INSERT bronze.erp_inventory_movements
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\inventory_movements.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Order Details
        PRINT '>> Truncating: bronze.erp_order_details';
        TRUNCATE TABLE bronze.erp_order_details;

        PRINT '>> Inserting: bronze.erp_order_details';
        BULK INSERT bronze.erp_order_details
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\order_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Orders
        PRINT '>> Truncating: bronze.erp_orders';
        TRUNCATE TABLE bronze.erp_orders;

        PRINT '>> Inserting: bronze.erp_orders';
        BULK INSERT bronze.erp_orders
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\orders.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Payments
        PRINT '>> Truncating: bronze.erp_payments';
        TRUNCATE TABLE bronze.erp_payments;

        PRINT '>> Inserting: bronze.erp_payments';
        BULK INSERT bronze.erp_payments
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\payments.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Products
        PRINT '>> Truncating: bronze.erp_products';
        TRUNCATE TABLE bronze.erp_products;

        PRINT '>> Inserting: bronze.erp_products';
        BULK INSERT bronze.erp_products
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\products.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Returns
        PRINT '>> Truncating: bronze.erp_returns';
        TRUNCATE TABLE bronze.erp_returns;

        PRINT '>> Inserting: bronze.erp_returns';
        BULK INSERT bronze.erp_returns
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\returns.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Shipping
        PRINT '>> Truncating: bronze.erp_shipping';
        TRUNCATE TABLE bronze.erp_shipping;

        PRINT '>> Inserting: bronze.erp_shipping';
        BULK INSERT bronze.erp_shipping
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\shipping.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        -- Suppliers
        PRINT '>> Truncating: bronze.erp_suppliers';
        TRUNCATE TABLE bronze.erp_suppliers;

        PRINT '>> Inserting: bronze.erp_suppliers';
        BULK INSERT bronze.erp_suppliers
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\suppliers.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        PRINT '=======================';
        PRINT ' Bronze Load Completed ';
        PRINT '=======================';
    END TRY
    BEGIN CATCH
        PRINT '!!! Error Occurred During Bronze Load !!!';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
