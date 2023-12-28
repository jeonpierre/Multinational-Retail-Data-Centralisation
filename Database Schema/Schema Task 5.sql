SELECT MAX(LENGTH("EAN")) FROM dim_products;
-- 17
SELECT MAX(LENGTH(product_code)) FROM dim_products;
-- 11
SELECT MAX(LENGTH(weight_class)) FROM dim_products;
-- 14

-- Rename the 'removed' column to 'still_available'
ALTER TABLE dim_products RENAME COLUMN removed TO still_available;
-- Change data types of columns in dim_products table

-- Change product_price from TEXT to FLOAT
ALTER TABLE dim_products ALTER COLUMN product_price TYPE FLOAT USING product_price::FLOAT;

-- Change weight from TEXT to FLOAT
ALTER TABLE dim_products ALTER COLUMN weight TYPE FLOAT USING weight::FLOAT;

-- Change EAN from TEXT to VARCHAR(?)
ALTER TABLE dim_products ALTER COLUMN EAN TYPE VARCHAR(17); 

-- Change product_code from TEXT to VARCHAR(?)
ALTER TABLE dim_products ALTER COLUMN product_code TYPE VARCHAR(11); 

-- Change date_added from TEXT to DATE
ALTER TABLE dim_products ALTER COLUMN date_added TYPE DATE USING date_added::DATE;

-- Change uuid from TEXT to UUID
ALTER TABLE dim_products ALTER COLUMN uuid TYPE UUID USING uuid::UUID;

-- Change still_available from TEXT to BOOL
ALTER TABLE dim_products ALTER COLUMN still_available TYPE BOOL USING CASE WHEN still_available = 'true' THEN TRUE ELSE FALSE END;

-- Change weight_class from TEXT to VARCHAR(?)
ALTER TABLE dim_products ALTER COLUMN weight_class TYPE VARCHAR(14); 