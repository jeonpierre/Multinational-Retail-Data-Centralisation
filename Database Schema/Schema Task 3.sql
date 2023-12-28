-- Merge Latitude Columns

UPDATE dim_store_details
SET latitude = COALESCE(latitude);

-- Determine Maximum lenghts for values in store_coe and country_code, needed for choosing appropriate VARCHAR lengths when modifying data types.

SELECT MAX(LENGTH(store_code)) FROM dim_store_details;
SELECT MAX(LENGTH(country_code)) FROM dim_store_details

-- Delete Invalid data from staff_numbers column that doesn’t consist of digits 

DELETE FROM dim_store_details
WHERE staff_numbers !~ '^\d+$';

-- Altering the table data types.

ALTER TABLE dim_store_details
ALTER COLUMN longitude TYPE FLOAT USING longitude::FLOAT,
ALTER COLUMN locality TYPE VARCHAR(255),
ALTER COLUMN store_code TYPE VARCHAR(11),
ALTER COLUMN staff_numbers TYPE SMALLINT USING staff_numbers::SMALLINT,
ALTER COLUMN opening_date TYPE DATE USING opening_date::DATE,
ALTER COLUMN store_type TYPE VARCHAR(255),
ALTER COLUMN latitude TYPE FLOAT USING latitude::FLOAT,
ALTER COLUMN country_code TYPE VARCHAR(2),
ALTER COLUMN continent TYPE VARCHAR(255);