/*******************************************************************************************
Stored Procedure Name : check_order_details_quality
Schema               : bronze 
Table Checked        : bronze.erp_order_details
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the order_items table:
        1. Duplicate rows (order_id + product_id)
        2. NULL values in key columns
        3. Invalid values (quantity <= 0 OR unit_price <= 0)

Usage:
    EXEC dq.check_order_details_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_order_details_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks: order_items =====';

    ----------------------------------------------------------------------------------------
    -- 1. Duplicate rows (order_id + product_id)
    ----------------------------------------------------------------------------------------
    PRINT 'Check 1: Duplicate (order_id, product_id)';
    SELECT order_id, product_id, COUNT(*) AS duplicate_count
    FROM bronze.erp_order_details
    GROUP BY order_id, product_id
    HAVING COUNT(*) > 1;

    ----------------------------------------------------------------------------------------
    -- 2. NULLs in important columns
    ----------------------------------------------------------------------------------------
    PRINT 'Check 2: NULL values in key columns';
    SELECT *
    FROM bronze.erp_order_details
    WHERE order_id IS NULL
       OR product_id IS NULL
       OR quantity IS NULL
       OR unit_price IS NULL;

    ----------------------------------------------------------------------------------------
    -- 3. Invalid values (quantity <= 0 OR unit_price <= 0)
    ----------------------------------------------------------------------------------------
    PRINT 'Check 3: Invalid values (quantity <= 0 OR unit_price <= 0)';
    SELECT *
    FROM bronze.erp_order_details
    WHERE quantity <= 0
       OR unit_price <= 0;
END;
GO
