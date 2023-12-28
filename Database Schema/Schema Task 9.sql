ALTER TABLE orders_table 
ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID;


ALTER TABLE orders_table
ADD CONSTRAINT fk_orders_user_uuid FOREIGN KEY (user_uuid)
REFERENCES dim_users(user_uuid);

ALTER TABLE orders_table
ADD CONSTRAINT fk_orders_date_uuid FOREIGN KEY (date_uuid)
REFERENCES dim_date_times(date_uuid);

ALTER TABLE orders_table
ADD CONSTRAINT fk_orders_card_number FOREIGN KEY (card_number)
REFERENCES dim_card_details(card_number);

ALTER TABLE orders_table
ADD CONSTRAINT fk_orders_store_code FOREIGN KEY (store_code)
REFERENCES dim_store_details(store_code);

ALTER TABLE orders_table
ADD CONSTRAINT fk_orders_product_code FOREIGN KEY (product_code)
REFERENCES dim_products(product_code);