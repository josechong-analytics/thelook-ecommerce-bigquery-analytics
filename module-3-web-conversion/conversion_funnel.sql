WITH event_counts AS (
  -- Step A: Count unique users executing each web action
  SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'product' THEN session_id END) AS users_viewed_product,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN session_id END) AS users_added_to_cart,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN session_id END) AS users_purchased
  FROM 
    `bigquery-public-data.thelook_ecommerce.events`
  WHERE 
    created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 365 DAY)
)

-- Step B: Calculate conversion and abandonment rates
SELECT
  users_viewed_product,
  users_added_to_cart,
  users_purchased,
  ROUND((users_added_to_cart / users_viewed_product) * 100, 2) AS cart_conversion_rate,
  ROUND((users_purchased / users_added_to_cart) * 100, 2) AS purchase_conversion_rate,
  ROUND((users_purchased / users_viewed_product) * 100, 2) AS overall_conversion_rate,
  ROUND((1 - (users_purchased / users_added_to_cart)) * 100, 2) AS cart_abandonment_rate
FROM 
  event_counts;
