/* ============================================================
   Script Name : load_silver.sql
   Description : Truncate & Insert all CRM & ERP tables 
                 from Bronze → Silver Layer (Cleaned Data).
   Author      : Sayed Elmasry
   Date        : 2025-09-15

   Usage       : EXEC silver.load_silver;
   ============================================================ */

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @proc_start DATETIME2 = SYSDATETIME();
    DECLARE @table_start DATETIME2, @table_end DATETIME2;
    DECLARE @duration_ms BIGINT;

    BEGIN TRY
        PRINT '======================='
        PRINT ' Starting Silver Load '
        PRINT '======================='

        -----------------------------------
        -- CRM Tables
        -----------------------------------
        PRINT '------------------------------'
        PRINT ' Loading CRM Tables '
        PRINT '------------------------------'

        -- Customer Sessions
        PRINT '>> Truncating: silver.crm_customer_session'
        TRUNCATE TABLE silver.crm_customer_session

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.crm_customer_session (id, customer_id, session_start, session_end, ip_address)
        SELECT id, customer_id, session_start, session_end, ip_address
        FROM bronze.crm_customer_session
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Customers
        PRINT '>> Truncating: silver.crm_customers'
        TRUNCATE TABLE silver.crm_customers

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.crm_customers (id, first_name, last_name, email, phone, address, registration_date)
        SELECT
            id,
            first_name,
            last_name,
            email,
            -- Clean phone inline
            CASE
                WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone,'-',''),' ',''),'(',''),')',''),'+',''),'x',''),'.',''),'_','') AS BIGINT) IS NOT NULL
                     AND LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone,'-',''),' ',''),'(',''),')',''),'+',''),'x',''),'.',''),'_','')) >= 10
                THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone,'-',''),' ',''),'(',''),')',''),'+',''),'x',''),'.',''),'_','')
                ELSE 'N/A'
            END AS phone,
            address,
            registration_date
        FROM bronze.crm_customers
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Discounts
        PRINT '>> Truncating: silver.crm_discount'
        TRUNCATE TABLE silver.crm_discount

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.crm_discount (id, code, percentage, start_date, end_date, is_active, product_id, category_id, order_id)
        SELECT id, code, percentage, start_date, end_date, is_active, product_id, category_id, order_id
        FROM bronze.crm_discount
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Reviews
        PRINT '>> Truncating: silver.crm_reviews'
        TRUNCATE TABLE silver.crm_reviews

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.crm_reviews (id, product_id, customer_id, rating, comment, review_date)
        SELECT id, product_id, customer_id, rating, comment, review_date
        FROM bronze.crm_reviews
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Wishlists
        PRINT '>> Truncating: silver.crm_wishlists'
        TRUNCATE TABLE silver.crm_wishlists

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.crm_wishlists (id, product_id, customer_id, added_date)
        SELECT id, product_id, customer_id, added_date
        FROM bronze.crm_wishlists
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -----------------------------------
        -- ERP Tables
        -----------------------------------
        PRINT '------------------------------'
        PRINT ' Loading ERP Tables '
        PRINT '------------------------------'

        -- Categories
        PRINT '>> Truncating: silver.erp_categories'
        TRUNCATE TABLE silver.erp_categories

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.erp_categories (id, name, description, parent_id)
        SELECT id, name, description, parent_id
        FROM bronze.erp_categories
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Inventory Movements
        PRINT '>> Truncating: silver.erp_inventory_movements'
        TRUNCATE TABLE silver.erp_inventory_movements

        SET @table_start = SYSDATETIME()
        INSERT INTO silver.erp_inventory_movements (id, product_id, quantity, movement_type, movement_date)
        SELECT id, product_id, quantity, movement_type, movement_date
        FROM bronze.erp_inventory_movements
        SET @table_end = SYSDATETIME()
        SET @duration_ms = DATEDIFF(MILLISECOND, @table_start, @table_end)
        PRINT '   -> Duration: ' + CAST(@duration_ms AS VARCHAR(20)) + ' ms'

        -- Orders, Order Details, Payments, Products, Returns, Shipping, Suppliers

        DECLARE @proc_end DATETIME2 = SYSDATETIME()
        DECLARE @proc_duration BIGINT = DATEDIFF(SECOND, @proc_start, @proc_end)

        PRINT '======================='
        PRINT ' Silver Load Completed '
        PRINT ' Total Duration: ' + CAST(@proc_duration AS VARCHAR(20)) + ' sec'
        PRINT '======================='

    END TRY
    BEGIN CATCH
        PRINT '!!! Error Occurred During Silver Load !!!'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
