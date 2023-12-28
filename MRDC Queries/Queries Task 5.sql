'''-- 1. What percentage of sales come from through each type of store? 

The sales team wants to know which of the different store types is generated the most revenue so they know where to focus.

Find out the total and percentage of sales coming from each of the different store types. '''

SELECT
    dsd.store_type,
    SUM(CAST(dp.product_price AS FLOAT) * ot.product_quantity) AS total_value_sold
FROM
    orders_table ot
JOIN
    dim_products dp ON ot.product_code = dp.product_code
JOIN
    dim_store_details dsd ON ot.store_code = dsd.store_code
GROUP BY
    dsd.store_type
ORDER BY
    total_value_sold DESC;