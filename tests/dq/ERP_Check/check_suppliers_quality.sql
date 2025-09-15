/*******************************************************************************************
Stored Procedure Name : check_suppliers_quality
Schema               : dq
Table Checked        : bronze.erp_suppliers
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the suppliers table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns (name, contact_person, email, phone, address)
    3. Invalid Email format
    4. Invalid Phone numbers

Usage:
    EXEC dq.check_suppliers_quality;

Author       : [Sayed Elmasry]
Date Created : [15/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_suppliers_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.erp_suppliers
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'name' AS ColumnName, * FROM bronze.erp_suppliers WHERE name IS NULL
    UNION ALL
    SELECT 'contact_person', * FROM bronze.erp_suppliers WHERE contact_person IS NULL
    UNION ALL
    SELECT 'email', * FROM bronze.erp_suppliers WHERE email IS NULL
    UNION ALL
    SELECT 'phone', * FROM bronze.erp_suppliers WHERE phone IS NULL
    UNION ALL
    SELECT 'address', * FROM bronze.erp_suppliers WHERE address IS NULL;

    PRINT '=== 3. Invalid Email format ===';
    SELECT id, email
    FROM bronze.erp_suppliers
    WHERE email NOT LIKE '%_@_%._%';

    PRINT '=== 4. Invalid Phone numbers ===';
    SELECT id, phone
    FROM bronze.erp_suppliers
    WHERE TRY_CAST(REPLACE(REPLACE(REPLACE(phone,'+',''),'-',''),'x','') AS BIGINT) IS NULL;
END;
GO
