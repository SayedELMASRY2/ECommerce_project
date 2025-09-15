/* =====================================================================
   Script Name   : gold_layer_ddl.sql
   Description   : Create Views for Gold Layer (Fact & Dimension tables)
                   based on the Silver Layer. This script builds the
                   Star Schema (Facts + Dimensions) using views.
   Author        : Sayed Elmasry
   Date          : 2025-09-15
   ===================================================================== */

------------------------------------------------------------
-- Customer Dimension View
-- Purpose: Provides customer attributes for analytics
------------------------------------------------------------
CREATE OR ALTER VIEW gold.dim_customers AS
SELECT 
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    c.address,
    c.registration_date
FROM silver.crm_customers c;


------------------------------------------------------------
-- Product Dimension View
-- Purpose: Provides product details and related attributes
------------------------------------------------------------
CREATE OR ALTER VIEW gold.dim_products AS
SELECT 
    p.id AS product_id,
    p.name,
    p.description,
    p.price,
    p.sku,
    p.stock_quantity,
    p.category_id,
    p.supplier_id
FROM silver.erp_products p;


------------------------------------------------------------
-- Category Dimension View
-- Purpose: Provides product category hierarchy
------------------------------------------------------------
CREATE OR ALTER VIEW gold.dim_categories AS
SELECT 
    c.id AS category_id,
    c.name,
    c.description,
    c.parent_id
FROM silver.erp_categories c;


------------------------------------------------------------
-- Supplier Dimension View
-- Purpose: Provides supplier details
------------------------------------------------------------
CREATE OR ALTER VIEW gold.dim_suppliers AS
SELECT 
    s.id AS supplier_id,
    s.name,
    s.contact_person,
    s.email,
    s.phone,
    s.address
FROM silver.erp_suppliers s;


------------------------------------------------------------
-- Date Dimension View
-- Purpose: Provides calendar attributes (year, month, day, weekday)
------------------------------------------------------------
CREATE OR ALTER VIEW gold.dim_date AS
SELECT DISTINCT
    CAST(o.order_date AS DATE) AS date_key,
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    DAY(o.order_date) AS day,
    DATENAME(WEEKDAY, o.order_date) AS weekday_name
FROM silver.erp_orders o
WHERE o.order_date IS NOT NULL;


------------------------------------------------------------
-- Orders Fact View
-- Purpose: Provides order-level measures and links to customers
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_orders AS
SELECT 
    o.id AS order_id,
    o.customer_id,
    o.total_amount,
    o.status,
    o.order_date,
    d.category_id
FROM silver.erp_orders o
LEFT JOIN silver.crm_discount d 
    ON o.id = d.order_id;


------------------------------------------------------------
-- Order Details Fact View
-- Purpose: Provides line-item level details per order
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_order_details AS
SELECT 
    od.id AS order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity,
    od.unit_price
FROM silver.erp_order_details od;


------------------------------------------------------------
-- Payments Fact View
-- Purpose: Provides payment transactions and methods
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_payments AS
SELECT 
    p.id AS payment_id,
    p.order_id,
    p.customer_id,
    p.amount,
    p.payment_date,
    p.payment_method,
    p.status
FROM silver.erp_payments p;


------------------------------------------------------------
-- Reviews Fact View
-- Purpose: Provides product reviews and ratings by customers
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_reviews AS
SELECT 
    r.id AS review_id,
    r.product_id,
    r.customer_id,
    r.rating,
    r.comment,
    r.review_date
FROM silver.crm_reviews r;


------------------------------------------------------------
-- Returns Fact View
-- Purpose: Provides returned orders information
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_returns AS
SELECT 
    rt.id AS return_id,
    rt.order_id,
    rt.return_date,
    rt.reason,
    rt.status
FROM silver.erp_returns rt;


------------------------------------------------------------
-- Shipping Fact View
-- Purpose: Provides shipping details and tracking info
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_shipping AS
SELECT 
    s.id AS shipping_id,
    s.order_id,
    s.shipping_date,
    s.tracking_number,
    s.carrier,
    s.status
FROM silver.erp_shipping s;


------------------------------------------------------------
-- Inventory Movements Fact View
-- Purpose: Provides stock movements (in/out) for products
------------------------------------------------------------
CREATE OR ALTER VIEW gold.fact_inventory_movements AS
SELECT 
    im.id AS movement_id,
    im.product_id,
    im.quantity,
    im.movement_type,
    im.movement_date
FROM silver.erp_inventory_movements im;
