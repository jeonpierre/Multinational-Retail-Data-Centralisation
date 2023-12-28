-- Query the database to find out which months have produced the most sales. The query should return the following information

SELECT dt.month, COUNT(*) AS total_sales
FROM orders_table AS ot
JOIN dim_date_times AS dt ON CAST(ot.date_uuid AS UUID) = dt.date_uuid
GROUP BY dt.month
ORDER BY total_sales DESC;
