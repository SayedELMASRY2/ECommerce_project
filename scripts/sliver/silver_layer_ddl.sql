/* ============================================================
   CRM SCHEMA (Customer Relationship Management)
   ============================================================ */

-- Table: Customer sessions
CREATE TABLE silver.crm_customer_session (
    id INT,                                     -- Session ID
    customer_id INT,                            -- Related customer ID
    session_start DATETIME,                     -- Session start time
    session_end DATETIME ,                      -- Session end time (nullable if still active)
    ip_address VARCHAR(45),                     -- IP address (IPv4/IPv6)
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Customers
CREATE TABLE silver.crm_customers (
    id INT,                                     -- Customer ID
    first_name NVARCHAR(45),                    -- First name
    last_name NVARCHAR(45),                     -- Last name
    email NVARCHAR(60),                         -- Email address
    phone NVARCHAR(20),                         -- Phone number
    address NVARCHAR(255),                      -- Customer address
    registration_date DATETIME,                 -- Registration date
	dwh_create_date DATETIME2 DEFAULT GETDATE()

);

-- Table: Discounts
CREATE TABLE silver.crm_discount (
    id INT ,                                    -- Discount ID
    code NVARCHAR(45),                          -- Discount code
    percentage INT,                             -- Discount percentage
    start_date DATETIME,                        -- Discount start date
    end_date DATETIME,                          -- Discount end date
    is_active BIT,                              -- Is the discount active?
    product_id INT,                             -- Related product ID (optional)
    category_id INT,                            -- Related category ID (optional)
    order_id INT,                                -- Related order ID (optional)
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Customer reviews
CREATE TABLE silver.crm_reviews (
    id INT ,                                    -- Review ID
    product_id INT,                             -- Related product ID
    customer_id INT,                            -- Related customer ID
    rating INT,                                 -- Rating value (1–5)
    comment NVARCHAR(1000),                     -- Review comment
    review_date DATETIME,                        -- Review date
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Wishlists
CREATE TABLE silver.crm_wishlists (
    id INT,                                     -- Wishlist item ID
    customer_id INT,                            -- Related customer ID
    product_id INT,                             -- Related product ID
    added_date DATETIME,                         -- Date when the product was added
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


/* ============================================================
   ERP SCHEMA (Enterprise Resource Planning)
   ============================================================ */

-- Table: Categories
CREATE TABLE silver.erp_categories (
    id INT,                                     -- Category ID
    name NVARCHAR(45),                          -- Category name
    description NVARCHAR(255),                  -- Category description
    parent_id INT,                               -- Parent category ID (for hierarchy)
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Inventory movements
CREATE TABLE silver.erp_inventory_movements (
    id INT ,                                    -- Movement ID
    product_id INT,                             -- Related product ID
    quantity INT,                               -- Quantity moved (positive/negative)
    movement_type NVARCHAR(45),                 -- Movement type (inbound, outbound, transfer, etc.)
    movement_date DATETIME,                      -- Movement date
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Order details (line items)
CREATE TABLE silver.erp_order_details (
    id INT,                                     -- Order detail ID
    order_id INT,                               -- Related order ID
    product_id INT,                             -- Related product ID
    quantity INT,                               -- Quantity ordered
    unit_price Decimal,                          -- Unit price
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Orders
CREATE TABLE silver.erp_orders (
    id INT,                                     -- Order ID
    customer_id INT,                            -- Related customer ID
    order_date DATETIME,                        -- Order date
    total_amount DECIMAL,                       -- Total order amount
    status NVARCHAR(45),                         -- Order status (Pending, Shipped, Completed, etc.)
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Payments
CREATE TABLE silver.erp_payments (
    id INT,                                     -- Payment ID
    order_id INT,                               -- Related order ID
    customer_id INT,                            -- Related customer ID
    amount DECIMAL,                             -- Payment amount
    payment_date DATETIME,                      -- Payment date
    payment_method NVARCHAR(45),                -- Payment method (Cash, Card, PayPal, etc.)
    status NVARCHAR(45),                         -- Payment status (Success, Failed, Pending)
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Products
CREATE TABLE silver.erp_products (
    id INT,                                     -- Product ID
    name NVARCHAR(100),                         -- Product name
    description NVARCHAR(1000),                 -- Product description
    price Decimal,                                  -- Product price
    category_id INT,                            -- Related category ID
    supplier_id INT,                            -- Related supplier ID
    sku NVARCHAR(45),                           -- Stock Keeping Unit (SKU)
    stock_quantity INT,                          -- Available stock quantity
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Returns
CREATE TABLE silver.erp_returns (
    id INT,                                     -- Return ID
    order_id INT,                               -- Related order ID
    return_date DATETIME,                       -- Return date
    reason NVARCHAR(45),                        -- Reason for return
    status NVARCHAR(45),                         -- Return status
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Shipping
CREATE TABLE silver.erp_shipping (
    id INT ,                                    -- Shipping ID
    order_id INT,                               -- Related order ID
    shipping_date DATETIME,                     -- Shipping date
    tracking_number NVARCHAR(45),               -- Tracking number
    carrier NVARCHAR(45),                       -- Shipping carrier
    status NVARCHAR(45),                         -- Shipping status
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Table: Suppliers
CREATE TABLE silver.erp_suppliers (
    id INT,                                     -- Supplier ID
    name NVARCHAR(45),                          -- Supplier name
    contact_person NVARCHAR(45),                -- Contact person
    email NVARCHAR(100),                         -- Supplier email
    phone NVARCHAR(45),                         -- Supplier phone number
    address NVARCHAR(100),                        -- Supplier address
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
