/*******************************************************************************************
Stored Procedure Name : check_categories_quality
Schema               : dq
Table Checked        : bronze.erp_categories
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the categories table 
    to ensure consistency and valid hierarchy.

Checks Implemented:
    1. Duplicate IDs
    2. NULLs in important columns (name)
    3. Duplicate category names
    4. Empty or very short descriptions
    5. Orphan parent_id (references non-existing category)

Usage:
    EXEC dq.check_categories_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/

CREATE OR ALTER PROCEDURE dq.check_categories_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks for categories =====';

    -- 1. Duplicate IDs
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.erp_categories
    GROUP BY id
    HAVING COUNT(*) > 1;

    -- 2. NULLs in important columns
    PRINT 'Check 2: NULLs in important columns';
    SELECT *
    FROM bronze.erp_categories
    WHERE name IS NULL;

    -- 3. Duplicate category names
    PRINT 'Check 3: Duplicate category names';
    SELECT name, COUNT(*) AS duplicate_count
    FROM bronze.erp_categories
    GROUP BY name
    HAVING COUNT(*) > 1;

    -- 4. Empty or very short descriptions
    PRINT 'Check 4: Empty or very short descriptions';
    SELECT *
    FROM bronze.erp_categories
    WHERE description IS NULL OR LEN(LTRIM(RTRIM(description))) < 10;

    -- 5. Orphan parent_id
    PRINT 'Check 5: Orphan parent_id (invalid hierarchy)';
    SELECT c.*
    FROM bronze.erp_categories c
    LEFT JOIN bronze.erp_categories p ON c.parent_id = p.id
    WHERE c.parent_id IS NOT NULL AND p.id IS NULL;
END;
GO
