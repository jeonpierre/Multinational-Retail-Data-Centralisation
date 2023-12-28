SELECT MAX(LENGTH(card_number)) FROM dim_card_details;
SELECT MAX(LENGTH(expiry_date)) FROM dim_card_details;

ALTER TABLE dim_card_details
ALTER COLUMN card_number TYPE VARCHAR(19),
ALTER COLUMN expiry_date TYPE VARCHAR(5),
ALTER COLUMN date_payment_confirmed TYPE DATE USING date_payment_confirmed::DATE;