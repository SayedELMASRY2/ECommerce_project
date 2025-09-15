/*******************************************************************************************
Stored Procedure Name : check_reviews_quality
Schema               : dq
Table Checked        : bronze.crm_reviews
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the reviews table to ensure validity and consistency.

Checks Implemented:
    1. Duplicate IDs
    2. NULLs in important columns (product_id, customer_id, rating, review_date)
    3. Invalid rating values (must be between 1 and 5)
    4. Future review dates
    5. Very short or empty comments
    6. Orphan product_id / customer_id if related tables exist

Usage:
    EXEC dq.check_reviews_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/

CREATE OR ALTER PROCEDURE dq.check_reviews_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks for reviews =====';

    -- 1. Duplicate IDs
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.crm_reviews
    GROUP BY id
    HAVING COUNT(*) > 1;

    -- 2. NULLs in important columns
    PRINT 'Check 2: NULLs in important columns';
    SELECT *
    FROM bronze.crm_reviews
    WHERE product_id IS NULL
       OR customer_id IS NULL
       OR rating IS NULL
       OR review_date IS NULL;

    -- 3. Invalid rating values
    PRINT 'Check 3: Invalid rating values';
    SELECT *
    FROM bronze.crm_reviews
    WHERE rating < 1 OR rating > 5;

    -- 4. Future review dates
    PRINT 'Check 4: Future review dates';
    SELECT *
    FROM bronze.crm_reviews
    WHERE review_date > GETDATE();

    -- 5. Very short or empty comments
    PRINT 'Check 5: Empty or too short comments';
    SELECT *
    FROM bronze.crm_reviews
    WHERE comment IS NULL OR LEN(LTRIM(RTRIM(comment))) < 5;

    -- 6. (Optional) Foreign key checks
    
    PRINT 'Check 6: Orphan product_id';
    SELECT r.*
    FROM bronze.crm_reviews r
    LEFT JOIN bronze.erp_products p ON r.product_id = p.id
    WHERE r.product_id IS NOT NULL AND p.id IS NULL;

    PRINT 'Check 7: Orphan customer_id';
    SELECT r.*
    FROM bronze.crm_reviews r
    LEFT JOIN bronze.crm_customers c ON r.customer_id = c.id
    WHERE r.customer_id IS NOT NULL AND c.id IS NULL;
    
END;
GO
