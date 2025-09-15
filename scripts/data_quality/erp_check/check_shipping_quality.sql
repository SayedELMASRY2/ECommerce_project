/*******************************************************************************************
Stored Procedure Name : check_shipping_quality
Schema               : dq
Table Checked        : bronze.erp_shipping
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the shipping table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns (order_id, shipping_date, tracking_number, carrier, status)
    3. Future shipping_date values
    4. Invalid carrier values
    5. Invalid status values

Usage:
    EXEC dq.check_shipping_quality;

Author       : [Sayed Elmasry]
Date Created : [15/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_shipping_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.erp_shipping
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'order_id' AS ColumnName, * FROM bronze.erp_shipping WHERE order_id IS NULL
    UNION ALL
    SELECT 'shipping_date', * FROM bronze.erp_shipping WHERE shipping_date IS NULL
    UNION ALL
    SELECT 'tracking_number', * FROM bronze.erp_shipping WHERE tracking_number IS NULL
    UNION ALL
    SELECT 'carrier', * FROM bronze.erp_shipping WHERE carrier IS NULL
    UNION ALL
    SELECT 'status', * FROM bronze.erp_shipping WHERE status IS NULL;

     PRINT '=== 3. Future shipping_date values ===';
    SELECT * FROM bronze.erp_shipping
    WHERE shipping_date > GETDATE();

    PRINT '=== 4. Invalid carrier values ===';
    SELECT * FROM bronze.erp_shipping
    WHERE carrier NOT IN ('FedEx', 'UPS', 'USPS', 'DHL');

    PRINT '=== 5. Invalid status values ===';
    SELECT * FROM bronze.erp_shipping
    WHERE status NOT IN ('in_transit', 'delivered', 'pending');
END;
GO