# theLook eCommerce - Google BigQuery Analytics Project

This repository serves as a comprehensive Data Analytics portfolio utilizing the public theLook eCommerce live dataset in Google BigQuery. The project is structured using Google's Data Analytics framework to answer high-impact business questions and translate raw transactional infrastructure into strategic insights.

---

## Project Structure & Navigation

### [Module 2: RFM Customer Segmentation](./module-2-customer-segmentation/rfm_analysis.sql)
* **Objective:** Group users into operational profiles (Champions, At Risk, Loyal) using statistical quintiles (`NTILE`) to optimize marketing campaign spend.
* **Tech Stack:** SQL Window Functions, `TIMESTAMP_DIFF`, conditional aggregation.

### [Module 3: Web Conversion Funnel](./module-3-web-conversion/conversion_funnel.sql)
* **Objective:** Analyze user event streams to track checkout drop-offs and discover conversion bottlenecks within the checkout pipeline.
* **Tech Stack:** Advanced CTEs, conditional metrics formatting, session tracking.

---

## Data Infrastructure & Methodology
* **Source:** `bigquery-public-data.thelook_ecommerce` (Live Google Cloud Marketplace dataset).
* **Framework:** "Ask Questions to Make Data-Driven Decisions" (Google Analytics Certification approach).
