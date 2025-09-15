/*******************************************************************************************
Stored Procedure Name : check_inventory_movements_quality
Schema               : dq
Table Checked        : bronze.erp_inventory_movements
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the inventory_movements table 
    to ensure valid stock movement records.

Checks Implemented:
    1. Duplicate IDs
    2. NULLs in important columns (product_id, quantity, movement_type, movement_date)
    3. Invalid movement_type values (must be 'purchase' or 'sale')
    4. Invalid quantities (<= 0)
    5. Future movement_date values
    6. Orphan product_id

Usage:
    EXEC dq.check_inventory_movements_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/

CREATE OR ALTER PROCEDURE dq.check_inventory_movements_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks for inventory_movements =====';

    -- 1. Duplicate IDs
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.erp_inventory_movements
    GROUP BY id
    HAVING COUNT(*) > 1;

    -- 2. NULLs in important columns
    PRINT 'Check 2: NULLs in important columns';
    SELECT *
    FROM bronze.erp_inventory_movements
    WHERE product_id IS NULL
       OR quantity IS NULL
       OR movement_type IS NULL
       OR movement_date IS NULL;

    -- 3. Invalid movement_type values
    PRINT 'Check 3: Invalid movement_type values';
    SELECT DISTINCT movement_type
    FROM bronze.erp_inventory_movements
    WHERE movement_type NOT IN ('purchase', 'sale');

    -- 4. Invalid quantities
    PRINT 'Check 4: Invalid quantity values (<= 0)';
    SELECT *
    FROM bronze.erp_inventory_movements
    WHERE quantity <= 0;

    -- 5. Future movement dates
    PRINT 'Check 5: Future movement_date values';
    SELECT *
    FROM bronze.erp_inventory_movements
    WHERE movement_date > GETDATE();

    -- 6. Orphan product_id
   
    PRINT 'Check 6: Orphan product_id';
    SELECT m.*
    FROM bronze.erp_inventory_movements m
    LEFT JOIN bronze.erp_products p ON m.product_id = p.id
    WHERE m.product_id IS NOT NULL AND p.id IS NULL;
    
END;
GO
