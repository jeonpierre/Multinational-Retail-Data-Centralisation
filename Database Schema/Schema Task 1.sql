-- Find max Length using LENGTH Function as PC and SC are TEXT type. —

SELECT
MAX(LENGTH(product_code)) AS max_product_length,
MAX(LENGTH(store_code)) AS max_store_length
FROM orders_table;

--- Since BIGINT cast as TEXT to find max with LENGTH —

SELECT
MAX(LENGTH(CAST(card_number AS TEXT))) AS max_card_length
FROM orders_table;

---Adjust the VARCHAR Lengths with Max lengths.-—-

ALTER TABLE orders_table
ALTER COLUMN product_code TYPE VARCHAR(11),
ALTER COLUMN store_code TYPE VARCHAR(12),
ALTER COLUMN card_number TYPE VARCHAR(19)