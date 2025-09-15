/*******************************************************************************************
Stored Procedure Name : check_products_quality
Schema               : dq
Table Checked        : bronze.erp_products
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the products table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns (name, price, category_id, supplier_id, sku, stock_quantity)
    3. Invalid price (<= 0)
    4. Invalid stock_quantity (< 0)
    5. Empty SKU values

Usage:
    EXEC dq.check_products_quality;

Author       : [Sayed Elmasry]
Date Created : [15/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_products_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.erp_products
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'name' AS ColumnName, * FROM bronze.erp_products WHERE name IS NULL
    UNION ALL
    SELECT 'price', * FROM bronze.erp_products WHERE price IS NULL
    UNION ALL
    SELECT 'category_id', * FROM bronze.erp_products WHERE category_id IS NULL
    UNION ALL
    SELECT 'supplier_id', * FROM bronze.erp_products WHERE supplier_id IS NULL
    UNION ALL
    SELECT 'sku', * FROM bronze.erp_products WHERE sku IS NULL
    UNION ALL
    SELECT 'stock_quantity', * FROM bronze.erp_products WHERE stock_quantity IS NULL;

    PRINT '=== 3. Invalid price (<= 0) ===';
    SELECT * FROM bronze.erp_products WHERE price <= 0;

    PRINT '=== 4. Invalid stock_quantity (< 0) ===';
    SELECT * FROM bronze.erp_products WHERE stock_quantity < 0;

    PRINT '=== 5. Empty SKU values ===';
    SELECT * FROM bronze.erp_products WHERE LTRIM(RTRIM(sku)) = '';
END;
GO
