/*******************************************************************************************
Stored Procedure Name : check_order_returns_quality
Schema               : dq
Table Checked        : bronze.erp_order_returns
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the order_returns table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns (order_id, return_date, reason, status)
    3. Future return_date values
    4. Invalid status values

Usage:
    EXEC dq.check_order_returns_quality;

Author       : [Sayed Elmasry]
Date Created : [15/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_order_returns_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.erp_returns
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'order_id' AS ColumnName, * FROM bronze.erp_returns WHERE order_id IS NULL
    UNION ALL
    SELECT 'return_date', * FROM bronze.erp_returns WHERE return_date IS NULL
    UNION ALL
    SELECT 'reason', * FROM bronze.erp_returns WHERE reason IS NULL
    UNION ALL
    SELECT 'status', * FROM bronze.erp_returns WHERE status IS NULL;

    PRINT '=== 3. Future return_date values ===';
    SELECT * FROM bronze.erp_returns
    WHERE return_date > GETDATE();

    PRINT '=== 4. Invalid status values ===';
    SELECT * FROM bronze.erp_returns
    WHERE status NOT IN ('pending', 'approved', 'completed', 'rejected');
END;
GO
