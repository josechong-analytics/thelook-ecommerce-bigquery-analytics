# Module 2: RFM Customer Segmentation Analysis

### Business Objective
To classify the customer database into distinct behavioral segments based on historical transactions, allowing the marketing team to design personalized retention campaigns for VIP users and re-engage dormant customers.

### Key Business Questions (Google Framework)
1. Who are our high-value (VIP) customers purchasing frequently with high monetary value?
2. What percentage of our active user base is at risk of churning?
3. How can we statistically group transaction histories using automated quintiles?

### Tech Stack
* **Database:** Google BigQuery (Public Dataset: `thelook_ecommerce`)
* **Language:** SQL (Advanced Window Functions `NTILE`, Statistical Partitioning, and Multi-condition `CASE WHEN`)

### Key Insights & Business Impact
* The model dynamically scores users across Recency, Frequency, and Monetary values, dividing the customer ecosystem into actionable marketing targets.
