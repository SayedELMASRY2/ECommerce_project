# 📘 Gold Layer Data Catalog

This catalog documents the **Gold Layer Views** created in the data warehouse.  
Each view represents either a **Dimension** or a **Fact** table in the Star Schema.

---

## 🟦 Dimension Views

### 1. `gold.dim_customers`
**Description:** Provides customer attributes for analytics.  
**Source:** `silver.crm_customers`  
**Columns:**
- `customer_id` – Unique customer identifier
- `first_name` – Customer's first name
- `last_name` – Customer's last name
- `email` – Customer email address
- `phone` – Customer phone number
- `address` – Customer physical address
- `registration_date` – Date the customer registered

---

### 2. `gold.dim_products`
**Description:** Provides product details and related attributes.  
**Source:** `silver.erp_products`  
**Columns:**
- `product_id` – Unique product identifier
- `name` – Product name
- `description` – Product description
- `price` – Product price
- `sku` – Stock keeping unit code
- `stock_quantity` – Available stock
- `category_id` – Related product category
- `supplier_id` – Supplier providing the product

---

### 3. `gold.dim_categories`
**Description:** Provides product category hierarchy.  
**Source:** `silver.erp_categories`  
**Columns:**
- `category_id` – Unique category identifier
- `name` – Category name
- `description` – Category description
- `parent_id` – Parent category (for hierarchical structure)

---

### 4. `gold.dim_suppliers`
**Description:** Provides supplier details.  
**Source:** `silver.erp_suppliers`  
**Columns:**
- `supplier_id` – Unique supplier identifier
- `name` – Supplier name
- `contact_person` – Main contact person
- `email` – Contact email
- `phone` – Contact phone
- `address` – Supplier address

---

### 5. `gold.dim_date`
**Description:** Provides calendar attributes (year, month, day, weekday).  
**Source:** `silver.erp_orders`  
**Columns:**
- `date_key` – Date identifier (YYYY-MM-DD)
- `year` – Calendar year
- `month` – Calendar month number
- `day` – Calendar day number
- `weekday_name` – Name of the weekday

---

## 🟥 Fact Views

### 6. `gold.fact_orders`
**Description:** Provides order-level measures and links to customers.  
**Source:** `silver.erp_orders`, `silver.crm_discount`  
**Columns:**
- `order_id` – Unique order identifier
- `customer_id` – Related customer
- `total_amount` – Total order amount
- `status` – Order status
- `order_date` – Date of order placement
- `category_id` – Linked discount category (if any)

---

### 7. `gold.fact_order_details`
**Description:** Provides line-item level details per order.  
**Source:** `silver.erp_order_details`  
**Columns:**
- `order_detail_id` – Unique line-item identifier
- `order_id` – Related order
- `product_id` – Related product
- `quantity` – Quantity ordered
- `unit_price` – Price per unit at order time

---

### 8. `gold.fact_payments`
**Description:** Provides payment transactions and methods.  
**Source:** `silver.erp_payments`  
**Columns:**
- `payment_id` – Unique payment identifier
- `order_id` – Related order
- `customer_id` – Related customer
- `amount` – Payment amount
- `payment_date` – Date of payment
- `payment_method` – Payment method used
- `status` – Payment status

---

### 9. `gold.fact_reviews`
**Description:** Provides product reviews and ratings by customers.  
**Source:** `silver.crm_reviews`  
**Columns:**
- `review_id` – Unique review identifier
- `product_id` – Reviewed product
- `customer_id` – Reviewer customer
- `rating` – Numeric rating score
- `comment` – Customer review comment
- `review_date` – Date of review submission

---

### 10. `gold.fact_returns`
**Description:** Provides returned orders information.  
**Source:** `silver.erp_returns`  
**Columns:**
- `return_id` – Unique return identifier
- `order_id` – Related order
- `return_date` – Date of return
- `reason` – Reason for return
- `status` – Return status

---

### 11. `gold.fact_shipping`
**Description:** Provides shipping details and tracking info.  
**Source:** `silver.erp_shipping`  
**Columns:**
- `shipping_id` – Unique shipping identifier
- `order_id` – Related order
- `shipping_date` – Date of shipping
- `tracking_number` – Shipment tracking number
- `carrier` – Shipping carrier
- `status` – Shipping status

---

### 12. `gold.fact_inventory_movements`
**Description:** Provides stock movements (in/out) for products.  
**Source:** `silver.erp_inventory_movements`  
**Columns:**
- `movement_id` – Unique movement identifier
- `product_id` – Related product
- `quantity` – Quantity moved
- `movement_type` – Movement type (in/out)
- `movement_date` – Date of stock movement

---

📌 This catalog ensures a clear understanding of the **Gold Layer** design for reporting & analytics.
