/*******************************************************************************************
Stored Procedure Name : check_wishlist_quality
Schema               : dq
Table Checked        : bronze.crm_wishlist
--------------------------------------------------------------------------------------------
Purpose:
    Perform data quality checks on the wishlist table 
    to ensure data integrity and remove duplicates.

Checks Implemented:
    1. Duplicate IDs
    2. NULLs in important columns (customer_id, product_id, added_date)
    3. Duplicate wishlist entries per (customer_id, product_id)
    4. Future added_date values
    5. (Optional) Orphan product_id / customer_id if related tables exist

Usage:
    EXEC dq.check_wishlist_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/

CREATE OR ALTER PROCEDURE dq.check_wishlist_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== Data Quality Checks for wishlist =====';

    -- 1. Duplicate IDs
    PRINT 'Check 1: Duplicate IDs';
    SELECT id, COUNT(*) AS duplicate_count
    FROM bronze.crm_wishlists
    GROUP BY id
    HAVING COUNT(*) > 1;

    -- 2. NULLs in important columns
    PRINT 'Check 2: NULLs in important columns';
    SELECT *
    FROM bronze.crm_wishlists
    WHERE customer_id IS NULL
       OR product_id IS NULL
       OR added_date IS NULL;

    -- 3. Duplicate customer-product pairs
    PRINT 'Check 3: Duplicate (customer_id, product_id) pairs';
    SELECT customer_id, product_id, COUNT(*) AS duplicate_count
    FROM bronze.crm_wishlists
    GROUP BY customer_id, product_id
    HAVING COUNT(*) > 1;

    -- 4. Future added_date values
    PRINT 'Check 4: Future added_date values';
    SELECT *
    FROM bronze.crm_wishlists
    WHERE added_date > GETDATE();

    -- 5. Foreign key checks
    
    PRINT 'Check 5: Orphan product_id';
    SELECT w.*
    FROM bronze.crm_wishlists w
    LEFT JOIN bronze.erp_products p ON w.product_id = p.id
    WHERE w.product_id IS NOT NULL AND p.id IS NULL;

    PRINT 'Check 6: Orphan customer_id';
    SELECT w.*
    FROM bronze.crm_wishlists w
    LEFT JOIN bronze.crm_customers c ON w.customer_id = c.id
    WHERE w.customer_id IS NOT NULL AND c.id IS NULL;
    
END;
GO
