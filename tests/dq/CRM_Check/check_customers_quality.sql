/*******************************************************************************************
Stored Procedure Name : check_customers_quality
Schema               : dq
Table Checked        : bronze.crm_customers
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the crm_customers table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. Duplicate Emails
    3. NULL values in important columns (id, first_name, last_name, email)
    4. Invalid Email format
    5. Invalid Phone numbers
    6. Suspicious Registration Dates (before 2000 or future dates)

Usage:
    EXEC dq.check_customers_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_customers_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.crm_customers
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. Duplicate Emails ===';
    SELECT email, COUNT_BIG(*) AS duplicate_count
    FROM bronze.crm_customers
    GROUP BY email
    HAVING COUNT_BIG(*) >= 1;

    PRINT '=== 3. NULL values in important columns ===';
    SELECT 'id' AS ColumnName, * 
    FROM bronze.crm_customers WHERE id IS NULL
    UNION ALL
    SELECT 'first_name', * 
    FROM bronze.crm_customers WHERE first_name IS NULL
    UNION ALL
    SELECT 'last_name', * 
    FROM bronze.crm_customers WHERE last_name IS NULL
    UNION ALL
    SELECT 'email', * 
    FROM bronze.crm_customers WHERE email IS NULL;

    PRINT '=== 4. Invalid Email format ===';
    SELECT id, email
    FROM bronze.crm_customers
    WHERE email NOT LIKE '%_@_%._%';

    PRINT '=== 5. Invalid Phone numbers ===';
    SELECT id, phone
    FROM bronze.crm_customers
    WHERE TRY_CAST(phone AS BIGINT) IS NULL
       OR TRY_CAST(phone AS BIGINT) < 0;

    PRINT '=== 6. Suspicious Registration Dates ===';
    SELECT id, registration_date
    FROM bronze.crm_customers
    WHERE registration_date < '2000-01-01'
       OR registration_date > GETDATE();
END;
GO
