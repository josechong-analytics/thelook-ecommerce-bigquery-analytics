WITH base_rfm AS (
  SELECT
    user_id,
    TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), MAX(created_at), DAY) AS recency,
    COUNT(DISTINCT order_id) AS frequency,
    ROUND(SUM(sale_price), 2) AS monetary
  FROM 
    `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE 
    status NOT IN ('Cancelled', 'Returned')
  GROUP BY 
    user_id
),

quintiles_rfm AS (
  SELECT
    user_id,
    recency,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
  FROM 
    base_rfm
)

SELECT
  user_id,
  recency,
  frequency,
  monetary,
  (r_score * 100 + f_score * 10 + m_score) AS rfm_combined_score,
  CASE
    WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions (VIP)'
    WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
    WHEN r_score >= 4 AND f_score = 1 THEN 'New Prospects'
    WHEN r_score = 1 AND f_score >= 3 THEN 'At Risk'
    WHEN r_score = 1 AND f_score = 1 THEN 'Lost Customers'
    ELSE 'Regular Customers'
  END AS segment_name
FROM 
  quintiles_rfm
ORDER BY 
  monetary DESC;
