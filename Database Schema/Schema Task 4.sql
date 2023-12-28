-- Remove the '£' character from the product_price column
UPDATE dim_products
SET product_price = REPLACE(product_price, '£', '');

-- Add a new column 'weight_class' to products table
ALTER TABLE dim_products
ADD COLUMN weight_class VARCHAR(50); -- Adjust the length based on your specific requirements

-- Update products with their respective weight_class
UPDATE dim_products
SET weight_class = 'Light'
WHERE weight < 2;

UPDATE dim_products
SET weight_class = 'Mid_Sized'
WHERE weight >= 2 AND weight < 40;

UPDATE dim_products
SET weight_class = 'Heavy'
WHERE weight >= 40 AND weight < 140;

UPDATE dim_products
SET weight_class = 'Truck_Required'
WHERE weight >= 140;