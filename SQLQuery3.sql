-- Step 1: Only run this if the column does NOT exist
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'olist_products_dataset_olist_products_dataset'
      AND COLUMN_NAME = 'product_price'
)
BEGIN
    ALTER TABLE olist_products_dataset_olist_products_dataset
    ADD product_price DECIMAL(10, 2);
END
GO

-- Step 2: Update product_price with average price from order_items
UPDATE p
SET p.product_price = o.avg_price
FROM olist_products_dataset_olist_products_dataset p
INNER JOIN (
    SELECT product_id, AVG(price) AS avg_price
    FROM olist_order_items_dataset_olist_order_items_dataset
    GROUP BY product_id
) o
ON p.product_id = o.product_id;
