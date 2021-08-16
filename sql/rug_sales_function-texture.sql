WITH tmp_variables AS (
        SELECT '2018-01-01' AS beg_date, CURRENT_DATE-1 AS end_date
)
SELECT DATE_TRUNC('week',o.created_date) AS week_begin_date,
       o.function,
       o.texture,
       SUM(o.rug_quantity) AS quantity,
       SUM(quantity) OVER(PARTITION BY week_begin_date) AS total_rugs_sold,
       quantity::FLOAT / total_rugs_sold AS percent_of_total,
       COUNT(DISTINCT o.created_date) AS num_days
FROM shopify_ruggable.mv_ruggable_shopify_orders_detailed o
WHERE disc_equals_gross = 'include'
AND o.product_type IN ('Rug','Doormat')
AND customer_email IS NOT NULL
AND created_date BETWEEN (SELECT beg_date FROM tmp_variables) AND (SELECT end_date FROM tmp_variables)
GROUP BY 1,2,3
HAVING num_days = 7
ORDER BY 1,2,3
