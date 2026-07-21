WITH warehouse_performance AS (
  SELECT
    oi.order_id,
    p.distribution_center_id,
    TIMESTAMP_DIFF(oi.shipped_at, oi.created_at, DAY) AS days_to_ship,
    ROUND(oi.sale_price - p.cost, 2) AS net_profit
  FROM 
    `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN 
    `bigquery-public-data.thelook_ecommerce.products` p 
    ON oi.product_id = p.id
  WHERE 
    oi.status = 'Shipped' AND oi.shipped_at IS NOT NULL
)

SELECT
  dc.name AS distribution_center_name,
  COUNT(DISTINCT wp.order_id) AS total_orders_shipped,
  ROUND(AVG(wp.days_to_ship), 1) AS avg_days_to_ship,
  ROUND(SUM(wp.net_profit), 2) AS total_net_profit
FROM 
  warehouse_performance wp
JOIN 
  `bigquery-public-data.thelook_ecommerce.distribution_centers` dc 
  ON wp.distribution_center_id = dc.id
GROUP BY 
  dc.name
ORDER BY 
  total_net_profit DESC;
