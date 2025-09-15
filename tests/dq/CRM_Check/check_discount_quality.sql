/*******************************************************************************************
Stored Procedure Name : check_discount_quality
Schema               : dq
Table Checked        : bronze.crm_discount
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the crm_discount table to ensure data integrity and validity.

Checks Implemented:
    1. Duplicate IDs
    2. NULLs in important columns (code, percentage, start_date, end_date, is_active)
    3. Invalid percentage values (outside the range 0–100)
    4. Invalid date ranges (end_date < start_date)
    5. Duplicate discount codes
    6. Orphan foreign keys (product_id, category_id, order_id) if related tables exist

Usage:
    EXEC dq.check_discount_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/

CREATE OR ALTER PROCEDURE dq.check_discount_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks for crm_discount =====';

    -- 1. Duplicate IDs
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.crm_discount
    GROUP BY id
    HAVING COUNT(*) > 1;

    -- 2. NULLs in important columns
    PRINT 'Check 2: NULLs in important columns';
    SELECT *
    FROM bronze.crm_discount
    WHERE code IS NULL
       OR percentage IS NULL
       OR start_date IS NULL
       OR end_date IS NULL
       OR is_active IS NULL;

    -- 3. Invalid percentage
    PRINT 'Check 3: Invalid percentage values';
    SELECT *
    FROM bronze.crm_discount
    WHERE percentage < 0 OR percentage > 100;

    -- 4. Invalid date ranges
    PRINT 'Check 4: Invalid date ranges (end < start)';
    SELECT *
    FROM bronze.crm_discount
    WHERE end_date < start_date;

    -- 5. Duplicate discount codes
    PRINT 'Check 5: Duplicate discount codes';
    SELECT code, COUNT(*) AS duplicate_count
    FROM bronze.crm_discount
    GROUP BY code
    HAVING COUNT(*) > 1;

    -- 6. Foreign key checks
   
    PRINT 'Check 6: Orphan product_id';
    SELECT d.*
    FROM bronze.crm_discount d
    LEFT JOIN bronze.erp_payments p ON d.product_id = p.id
    WHERE d.product_id IS NOT NULL AND p.id IS NULL;
    
END;
GO
