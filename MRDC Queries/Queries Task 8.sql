SELECT
    SUM(CAST(dp.product_price AS FLOAT) * ot.product_quantity) AS total_sales,
    dsd.store_type,
    dsd.country_code
FROM
    orders_table ot
JOIN
    dim_products dp ON ot.product_code = dp.product_code
JOIN
    dim_store_details dsd ON ot.store_code = dsd.store_code
WHERE
    dsd.country_code = 'DE'
GROUP BY
    dsd.store_type, dsd.country_code
ORDER BY
    total_sales ASC;
