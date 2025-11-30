-- Step 1: Add price column to product table if it doesn't exist
-- Run this separately first and check if it succeeds
ALTER TABLE olist_products_dataset_olist_products_dataset
ADD Product_price DECIMAL(10, 2);

-- Step 2: Update product table with prices from order table
-- IMPORTANT: Run this AFTER Step 1 completes successfully
-- This uses average price from all orders for each product
UPDATE olist_products_dataset_olist_products_dataset
SET product_price = (
    SELECT AVG(price)
    FROM olist_order_items_dataset_olist_order_items_dataset o
    WHERE o.product_id = olist_products_dataset_olist_products_dataset.product_id
)
WHERE EXISTS (
    SELECT 1
    FROM olist_order_items_dataset_olist_order_items_dataset o
    WHERE o.product_id = olist_products_dataset_olist_products_dataset.product_id
);
