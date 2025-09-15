# Gold Layer Data Catalog

## Overview
This catalog describes the **Gold Layer** views created from the Silver Layer.  
It includes **Dimensions** and **Facts** with SQL Server data types, purposes, and descriptions.

---

## Dimension Tables

### 1. gold.dim_customers
- **Purpose:** Stores customer details for analysis and reporting.
- **Relationships:** Links to `fact_orders`, `fact_payments`, and `fact_reviews` via `customer_id`.

| Column Name        | Data Type        | Description |
|--------------------|-----------------|-------------|
| customer_id        | INT             | Unique identifier for each customer. |
| first_name         | NVARCHAR(45)   | Customer's first name. |
| last_name          | NVARCHAR(45)   | Customer's last name. |
| email              | NVARCHAR(60)   | Customer's email address. |
| phone              | NVARCHAR(20)    | Customer's phone number. |
| address            | NVARCHAR(255)   | Customer's address. |
| registration_date  | DATETIME        | Date when the customer registered. |

---

### 2. gold.dim_products
- **Purpose:** Provides product details and attributes.
- **Relationships:** Links to `fact_order_details`, `fact_reviews`, and `fact_inventory_movements` via `product_id`.

| Column Name     | Data Type        | Description |
|-----------------|-----------------|-------------|
| product_id      | INT             | Unique identifier for the product. |
| name            | NVARCHAR(100)   | Name of the product. |
| description     | NVARCHAR(1000)  | Detailed description of the product. |
| price           | DECIMAL()       | Price of the product. |
| sku             | NVARCHAR(45)   | Stock keeping unit identifier. |
| stock_quantity  | INT             | Quantity available in stock. |
| category_id     | INT             | Foreign key to `dim_categories`. |
| supplier_id     | INT             | Foreign key to `dim_suppliers`. |

---

### 3. gold.dim_categories
- **Purpose:** Represents product categories and hierarchy.
- **Relationships:** Links to `dim_products` via `category_id`.

| Column Name   | Data Type        | Description |
|---------------|-----------------|-------------|
| category_id   | INT             | Unique identifier for the category. |
| name          | NVARCHAR(45)   | Category name. |
| description   | NVARCHAR(10000)   | Description of the category. |
| parent_id     | INT             | Parent category ID for hierarchy. |

---

### 4. gold.dim_suppliers
- **Purpose:** Stores supplier information.
- **Relationships:** Links to `dim_products` via `supplier_id`.

| Column Name     | Data Type        | Description |
|-----------------|-----------------|-------------|
| supplier_id     | INT             | Unique identifier for the supplier. |
| name            | NVARCHAR(45)   | Supplier name. |
| contact_person  | NVARCHAR(45)   | Contact person for the supplier. |
| email           | NVARCHAR(100)   | Supplier's email address. |
| phone           | NVARCHAR(45)    | Supplier's phone number. |
| address         | NVARCHAR(100)   | Supplier's address. |

---

### 5. gold.dim_date
- **Purpose:** Provides calendar breakdown (date, year, month, day, weekday).
- **Relationships:** Links to `fact_orders`, `fact_payments`, `fact_shipping` via date fields.

| Column Name   | Data Type   | Description |
|---------------|------------|-------------|
| date_key      | DATE        | Unique date key. |
| year          | INT         | Year number. |
| month         | INT         | Month number (1-12). |
| day           | INT         | Day of the month (1-31). |
| weekday_name  | NVARCHAR(20)| Name of the weekday (e.g., Monday). |

---

## Fact Tables

### 6. gold.fact_orders
- **Purpose:** Captures order-level transactions.
- **Relationships:** Links to `dim_customers` via `customer_id`, `dim_date` via `order_date`, and `dim_categories` via `category_id`.

| Column Name   | Data Type        | Description |
|---------------|-----------------|-------------|
| order_id      | INT             | Unique identifier for the order. |
| customer_id   | INT             | Foreign key to `dim_customers`. |
| total_amount  | DECIMAL()   | Total amount of the order. |
| status        | NVARCHAR(45)    | Order status (e.g., Completed, Pending). |
| order_date    | DATETIME        | Date when the order was placed. |
| category_id   | INT             | Linked category from discount. |

---

### 7. gold.fact_order_details
- **Purpose:** Stores details for each order line item.
- **Relationships:** Links to `fact_orders` via `order_id`, and `dim_products` via `product_id`.

| Column Name      | Data Type        | Description |
|------------------|-----------------|-------------|
| order_detail_id  | INT             | Unique identifier for the order detail record. |
| order_id         | INT             | Foreign key to `fact_orders`. |
| product_id       | INT             | Foreign key to `dim_products`. |
| quantity         | INT             | Number of units ordered. |
| unit_price       | DECIMAL()   | Price per unit at the time of order. |

---

### 8. gold.fact_payments
- **Purpose:** Captures payment transactions for orders.
- **Relationships:** Links to `fact_orders` via `order_id`, and `dim_customers` via `customer_id`.

| Column Name     | Data Type        | Description |
|-----------------|-----------------|-------------|
| payment_id      | INT             | Unique identifier for the payment. |
| order_id        | INT             | Foreign key to `fact_orders`. |
| customer_id     | INT             | Foreign key to `dim_customers`. |
| amount          | DECIMAL()   | Payment amount. |
| payment_date    | DATETIME        | Date of payment. |
| payment_method  | NVARCHAR(45)    | Payment method (e.g., Credit Card). |
| status          | NVARCHAR(45)    | Payment status (e.g., Paid, Failed). |

---

### 9. gold.fact_reviews
- **Purpose:** Stores product reviews and ratings by customers.
- **Relationships:** Links to `dim_products` via `product_id`, and `dim_customers` via `customer_id`.

| Column Name   | Data Type        | Description |
|---------------|-----------------|-------------|
| review_id     | INT             | Unique identifier for the review. |
| product_id    | INT             | Foreign key to `dim_products`. |
| customer_id   | INT             | Foreign key to `dim_customers`. |
| rating        | INT             | Rating given by the customer. |
| comment       | NVARCHAR(1000)   | Review comments. |
| review_date   | DATETIME        | Date of the review. |

---

### 10. gold.fact_returns
- **Purpose:** Captures product return transactions.
- **Relationships:** Links to `fact_orders` via `order_id`.

| Column Name   | Data Type        | Description |
|---------------|-----------------|-------------|
| return_id     | INT             | Unique identifier for the return record. |
| order_id      | INT             | Foreign key to `fact_orders`. |
| return_date   | DATETIME        | Date of return. |
| reason        | NVARCHAR(45)   | Reason for the return. |
| status        | NVARCHAR(45)    | Return status. |

---

### 11. gold.fact_shipping
- **Purpose:** Captures shipping and delivery information.
- **Relationships:** Links to `fact_orders` via `order_id`.

| Column Name       | Data Type        | Description |
|-------------------|-----------------|-------------|
| shipping_id       | INT             | Unique identifier for the shipping record. |
| order_id          | INT             | Foreign key to `fact_orders`. |
| shipping_date     | DATETIME        | Date of shipping. |
| tracking_number   | NVARCHAR(45)   | Tracking number provided by carrier. |
| carrier           | NVARCHAR(45)   | Shipping carrier name. |
| status            | NVARCHAR(45)    | Shipping status. |

---

### 12. gold.fact_inventory_movements
- **Purpose:** Tracks inventory stock movements (in and out).
- **Relationships:** Links to `dim_products` via `product_id`.

| Column Name     | Data Type        | Description |
|-----------------|-----------------|-------------|
| movement_id     | INT             | Unique identifier for the inventory movement. |
| product_id      | INT             | Foreign key to `dim_products`. |
| quantity        | INT             | Quantity moved (positive=inbound, negative=outbound). |
| movement_type   | NVARCHAR(45)    | Type of movement (Inbound/Outbound). |
| movement_date   | DATETIME        | Date of the movement. |

---
