--ALTER TABLE olist_products_dataset_olist_products_dataset
--ADD total_orders INT;
-- Step 2: Count how many orders each product has
UPDATE olist_products_dataset_olist_products_dataset
SET total_orders = (
    SELECT COUNT(*)
    FROM olist_order_items_dataset_olist_order_items_dataset o
    WHERE o.product_id = olist_products_dataset_olist_products_dataset.product_id
);
