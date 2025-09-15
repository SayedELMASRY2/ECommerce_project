/* ============================================================
   Script Name : 01_bulk_insert_bronze.sql
   Description : Truncate & Bulk insert all CRM & ERP CSV files 
                 into the Bronze Layer (Raw Ingestion).
   Author      : Sayed Elmasry
   Date        : 2025-09-13

   Usage       : EXEC bronze.load_bronze;
   ============================================================ */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @proc_start DATETIME2 = SYSDATETIME();
    DECLARE @table_start DATETIME2, @table_end DATETIME2;
    DECLARE @duration_ms BIGINT;

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

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.crm_customer_session
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customer_sessions.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Customers
        PRINT '>> Truncating: bronze.crm_customers';
        TRUNCATE TABLE bronze.crm_customers;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.crm_customers
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\customers.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Discounts
        PRINT '>> Truncating: bronze.crm_discount';
        TRUNCATE TABLE bronze.crm_discount;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.crm_discount
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\discounts.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Reviews
        PRINT '>> Truncating: bronze.crm_reviews';
        TRUNCATE TABLE bronze.crm_reviews;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.crm_reviews
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\reviews.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Wishlists
        PRINT '>> Truncating: bronze.crm_wishlists';
        TRUNCATE TABLE bronze.crm_wishlists;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.crm_wishlists
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\CRM\wishlists.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';


        /* =========================
           ERP Data - Bulk Insert
           ========================= */
        PRINT '------------------------------';
        PRINT ' Loading ERP Tables ';
        PRINT '------------------------------';

        -- Categories
        PRINT '>> Truncating: bronze.erp_categories';
        TRUNCATE TABLE bronze.erp_categories;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_categories
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\categories.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Inventory Movements
        PRINT '>> Truncating: bronze.erp_inventory_movements';
        TRUNCATE TABLE bronze.erp_inventory_movements;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_inventory_movements
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\inventory_movements.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Order Details
        PRINT '>> Truncating: bronze.erp_order_details';
        TRUNCATE TABLE bronze.erp_order_details;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_order_details
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\order_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Orders
        PRINT '>> Truncating: bronze.erp_orders';
        TRUNCATE TABLE bronze.erp_orders;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_orders
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\orders.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Payments
        PRINT '>> Truncating: bronze.erp_payments';
        TRUNCATE TABLE bronze.erp_payments;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_payments
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\payments.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Products
        PRINT '>> Truncating: bronze.erp_products';
        TRUNCATE TABLE bronze.erp_products;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_products
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\products.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Returns
        PRINT '>> Truncating: bronze.erp_returns';
        TRUNCATE TABLE bronze.erp_returns;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_returns
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\returns.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Shipping
        PRINT '>> Truncating: bronze.erp_shipping';
        TRUNCATE TABLE bronze.erp_shipping;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_shipping
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\shipping.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';

        -- Suppliers
        PRINT '>> Truncating: bronze.erp_suppliers';
        TRUNCATE TABLE bronze.erp_suppliers;

        SET @table_start = SYSDATETIME();
        BULK INSERT bronze.erp_suppliers
        FROM 'C:\Users\Sayed Elmasry\Desktop\ecommerce project\data\ERP\suppliers.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @table_end = SYSDATETIME();
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end);
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms';


        /* =========================
           End of Procedure
           ========================= */
        DECLARE @proc_end DATETIME2 = SYSDATETIME();
        DECLARE @proc_duration BIGINT = DATEDIFF(SECOND, @proc_start, @proc_end);

        PRINT '=======================';
        PRINT ' Bronze Load Completed ';
        PRINT ' Total Duration: ' + CAST(@proc_duration AS VARCHAR(20)) + ' sec';
        PRINT '=======================';
    END TRY
    BEGIN CATCH
        PRINT '!!! Error Occurred During Bronze Load !!!';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
