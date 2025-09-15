/*******************************************************************************************
Stored Procedure Name : check_payments_quality
Schema               : dq
Table Checked        : bronze.erp_payments
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the payments table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns
    3. Invalid amount values (<= 0)
    4. Future payment_date values
    5. Invalid payment_method
    6. Invalid status values

Usage:
    EXEC dq.check_payments_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_payments_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.erp_payments
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'order_id' AS ColumnName, * FROM bronze.erp_payments WHERE order_id IS NULL
    UNION ALL
    SELECT 'customer_id', * FROM bronze.erp_payments WHERE customer_id IS NULL
    UNION ALL
    SELECT 'amount', * FROM bronze.erp_payments WHERE amount IS NULL
    UNION ALL
    SELECT 'payment_date', * FROM bronze.erp_payments WHERE payment_date IS NULL
    UNION ALL
    SELECT 'payment_method', * FROM bronze.erp_payments WHERE payment_method IS NULL
    UNION ALL
    SELECT 'status', * FROM bronze.erp_payments WHERE status IS NULL;

    PRINT '=== 3. Invalid amount values (<= 0) ===';
    SELECT * FROM bronze.erp_payments WHERE amount <= 0;

    PRINT '=== 4. Future payment_date values ===';
    SELECT * FROM bronze.erp_payments WHERE payment_date > GETDATE();

    PRINT '=== 5. Invalid payment_method values ===';
    SELECT * FROM bronze.erp_payments
    WHERE payment_method NOT IN ('bank_transfer', 'credit_card', 'paypal');

    PRINT '=== 6. Invalid status values ===';
    SELECT * FROM bronze.erp_payments
    WHERE status NOT IN ('pending', 'completed', 'failed');
END;
GO
