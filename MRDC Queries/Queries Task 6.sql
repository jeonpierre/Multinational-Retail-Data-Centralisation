SELECT
    SUM(dp.product_price::FLOAT * ot.product_quantity::FLOAT) AS total_sales,
    ddt.year,
    ddt.month
FROM
    orders_table ot
JOIN
    dim_products dp ON ot.product_code = dp.product_code
JOIN
    dim_date_times ddt ON ot.date_uuid::UUID = ddt.date_uuid
GROUP BY
    ddt.year, ddt.month
ORDER BY
    total_sales DESC;