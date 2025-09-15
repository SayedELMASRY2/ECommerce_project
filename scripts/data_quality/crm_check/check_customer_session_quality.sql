/*******************************************************************************************
Stored Procedure Name : check_customer_session_quality
Schema               : dq
Table Checked        : bronze.crm_customer_session
--------------------------------------------------------------------------------------------
Purpose:
    Run Data Quality Checks on the crm_customer_session table to ensure data integrity.

Checks Implemented:
    1. Duplicate IDs
    2. NULL values in important columns (id, customer_id, session_start, ip_address)
    3. Invalid session dates (session_end < session_start)
    4. Invalid IP address format

Usage:
    EXEC dq.check_customer_session_quality;

Author       : [Sayed Elmasry]
Date Created : [14/9/2025]
*******************************************************************************************/
CREATE OR ALTER PROCEDURE dq.check_customer_session_quality
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '=== 1. Duplicate IDs ===';
    SELECT id, COUNT_BIG(*) AS duplicate_count
    FROM bronze.crm_customer_session
    GROUP BY id
    HAVING COUNT_BIG(*) > 1;

    PRINT '=== 2. NULL values in important columns ===';
    SELECT 'id' AS ColumnName, * 
    FROM bronze.crm_customer_session WHERE id IS NULL
    UNION ALL
    SELECT 'customer_id' AS ColumnName, * 
    FROM bronze.crm_customer_session WHERE customer_id IS NULL
    UNION ALL
    SELECT 'session_start' AS ColumnName, * 
    FROM bronze.crm_customer_session WHERE session_start IS NULL
    UNION ALL
    SELECT 'ip_address' AS ColumnName, * 
    FROM bronze.crm_customer_session WHERE ip_address IS NULL;

    PRINT '=== 3. Invalid session dates (end < start) ===';
    SELECT id, customer_id, session_start, session_end
    FROM bronze.crm_customer_session
    WHERE session_end < session_start;

    PRINT '=== 4. Invalid IP address format ===';
    SELECT id, customer_id, ip_address
    FROM bronze.crm_customer_session
    WHERE TRY_CONVERT(INT, PARSENAME(ip_address, 1)) IS NULL
       OR TRY_CONVERT(INT, PARSENAME(ip_address, 2)) IS NULL
       OR TRY_CONVERT(INT, PARSENAME(ip_address, 3)) IS NULL
       OR TRY_CONVERT(INT, PARSENAME(ip_address, 4)) IS NULL;
END;
GO
