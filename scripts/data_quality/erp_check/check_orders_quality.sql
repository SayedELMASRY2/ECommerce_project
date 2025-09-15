/*******************************************************************************************
Stored Procedure Name : check_orders_quality
Schema               : dq
Table Checked        : bronze.erp_orders
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the orders table:
        1. Duplicate IDs
        2. NULLs in important columns
        3. Invalid total_amount
        4. Future order_date values
        5. Invalid status values

Usage:
    EXEC dq.check_orders_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_orders_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks: orders =====';

    ----------------------------------------------------------------------------------------
    -- 1. Duplicate IDs
    ----------------------------------------------------------------------------------------
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.erp_orders
    GROUP BY id
    HAVING COUNT(*) > 1;

    ----------------------------------------------------------------------------------------
    -- 2. NULLs in important columns
    ----------------------------------------------------------------------------------------
    PRINT 'Check 2: NULLs in key columns';
    SELECT *
    FROM bronze.erp_orders
    WHERE customer_id IS NULL
       OR order_date IS NULL
       OR total_amount IS NULL
       OR status IS NULL;

    ----------------------------------------------------------------------------------------
    -- 3. Invalid total_amount
    ----------------------------------------------------------------------------------------
    PRINT 'Check 3: Invalid total_amount (<= 0)';
    SELECT *
    FROM bronze.erp_orders
    WHERE total_amount <= 0;

    ----------------------------------------------------------------------------------------
    -- 4. Future order_date
    ----------------------------------------------------------------------------------------
    PRINT 'Check 4: Future order_date values';
    SELECT *
    FROM bronze.erp_orders
    WHERE order_date > GETDATE();

    ----------------------------------------------------------------------------------------
    -- 5. Invalid status
    ----------------------------------------------------------------------------------------
    PRINT 'Check 5: Invalid status values';
    SELECT *
    FROM bronze.erp_orders
    WHERE status NOT IN ('processing', 'pending', 'cancelled', 'completed', 'delivered', 'shipped');
END;
GO
