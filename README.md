# E-Commerce Business Insights — SQL

Delivering Actionable Analytics Across Finance, Product, Marketing, Supply Chain, and Customer Experience using Advanced SQL

##  Table of Contents

- [About the Project](#about-the-project)
- [Business Domains Covered](#business-domains-covered)
- [Database Schema](#database-schema)
- [Tools & Technologies](#tools--technologies)
- [Key Stakeholder Insights](#key-stakeholder-insights)
- [Query Bank Summary](#query-bank-summary)
- [Execution Dashboard](#execution-dashboard)
- [Getting Started](#getting-started)
- [Author](#author)

# About the Project

This project simulates a real-world e-commerce analytics use case where SQL is used to extract deep, stakeholder-relevant insights from a normalized transactional database. It covers six critical business domains and uses advanced SQL features like CTEs, window functions, and subqueries to drive data storytelling.

# Business Domains Covered

-  Finance & Profitability
-  Product Analytics
-  Customer Behavior & Churn
-  Marketing Campaign Performance
-  Supply Chain & Fulfillment
-  Customer Experience (Support & Feedback)

  #  Database Schema
  
| Table Name        | Description                           |
|-------------------|----------------------------------------|
| Orders            | Order-level data                       |
| Payments          | Transaction details                    |
| Returns           | Returned items                         |
| Products          | Product catalog                        |
| Customers         | Buyer details                          |
| Sellers           | Seller details                         |
| Shipments         | Fulfillment and delivery tracking      |
| Inventory         | Stock data                             |
| Address           | Geolocation (with Region FK)           |
| Product_Reviews   | Rating & textual feedback              |
| Marketing_Campaigns | Promotion and campaign targeting     |

#  Tools & Technologies

- SQL Server Management Studio (SSMS)
- Microsoft SQL Server 2019
- Python
- GitHub

#  Key Stakeholder Insights

####  Finance

- **Monthly Revenue Tracking** helps the finance team spot seasonal trends and plan budgets.
- **AOV by Region** reveals customer spending behavior across geographies, enabling smarter pricing.
- **Net Profit by Region** enables leadership to compare business efficiency between territories.
- **Profit Margin by Seller** helps with vendor performance reviews and negotiating better commission models.
- **Loss-Making Products** can be flagged for delisting or reviewed for cost optimization.

---

####  Product Analytics

- **Top Reviewed Products** highlight items driving the most engagement.
- **Average Rating by Category** helps product teams evaluate category-wise performance.
- **Review Trends Over Time** indicate if product experience is improving or deteriorating.
- **Sentiment by Category** helps customer success or marketing know which categories need attention.
- **Repeat Purchase Products** signal potential for bundling or loyalty promotions.
- **Return vs Rating Correlation** identifies products with mismatch between expectations and experience.

---

####  Customer Analytics

- **Repeat vs One-time Customers** helps understand lifecycle and design better retention strategies.
- **Inactive High-Spenders** can be targeted via reactivation campaigns or personalized offers.
- **Avg Purchase Gap** supports segmentation based on buying frequency.
- **Churn by Region** indicates geographic dissatisfaction or delivery issues.
- **Churned High-Value Customers** are a red flag for marketing or CX teams to investigate root causes.

---

####  Marketing Campaign Performance

- **Top-Grossing Campaigns** support ROI tracking for marketing investment.
- **AOV by Campaign** helps test effectiveness of premium vs discount-led messaging.
- **Lead Time to Order** shows how long users take to convert, optimizing campaign run duration.

---

####  Supply Chain & Fulfillment

- **Avg Delivery Time by Region** assists logistics team in pinpointing delay-prone zones.
- **Return Rate by Region** signals fulfillment or product issues localized to specific areas.
- **Fulfillment Time by Seller** highlights bottlenecks in shipping by specific vendors.
- **Low-Stock Products by Category** helps inventory teams forecast demand & plan reorders.
- **Valid Lead Time Tracking** ensures delivery windows are reliable and data-backed.

---

####  Customer Experience

- **Avg Seller Rating** is a vendor quality KPI tracked by the CX or Ops team.
- **Support-Related Reviews** help CX teams quantify pain points like delays, damaged items, or bad packaging.
- **Rating vs Return Rate** reveals items that are poorly rated **and** frequently returned—ideal candidates for de-prioritization or redesign.


# Query Bank Summary

| Domain                | Basic | Intermediate | Advanced | Total |
|-----------------------|-------|--------------|----------|-------|
| Finance               | 3     | 2            | 1        | 6     |
| Product Analytics     | 2     | 3            | 1        | 6     |
| Customer Analytics    | 2     | 2            | 1        | 5     |
| Marketing Performance | 1     | 1            | 1        | 3     |
| Supply Chain          | 1     | 2            | 2        | 5     |
| Customer Experience   | 1     | 1            | 1        | 3     |
| **Total**             | **10**| **11**       | **7**    | **28**|

#  Execution Summary

###  Summary Execution Table

| Module                      | Difficulty   | Query Count | SQL Techniques Used                                |
|----------------------------|--------------|-------------|----------------------------------------------------|
| **I. Finance**              | Basic        | 3           | Aggregation, Joins                                 |
|                            | Intermediate | 2           | CTEs, Window Functions (`RANK()`)                  |
|                            | Advanced     | 1           | Aggregation, `HAVING`, Business Logic              |
| **II. Product Analytics**   | Basic        | 2           | Joins, Aggregation                                 |
|                            | Intermediate | 3           | Time Grouping, Text Matching, `HAVING`             |
|                            | Advanced     | 1           | Joins, `HAVING`, Left Join with NULL logic         |
| **III. Customer Analytics** | Basic        | 2           | CTE, Aggregation, `HAVING`                         |
|                            | Intermediate | 2           | LAG(), CTE, Date Logic                             |
|                            | Advanced     | 1           | Subqueries, `HAVING`, Spend-based Sorting          |
| **IV. Marketing Campaigns** | Basic        | 1           | Aggregation, Multi-level Joins                     |
|                            | Intermediate | 1           | AVG, Multi-level Joins                             |
|                            | Advanced     | 1           | `DATEDIFF()`, Grouping                             |
| **V. Supply Chain**         | Basic        | 1           | Joins, `DATEDIFF()`                                |
|                            | Intermediate | 2           | Aggregation, Joins, Region-based Grouping          |
|                            | Advanced     | 2           | Threshold Checks, Inventory Logic, Valid Date Diff |
| **VI. Customer Experience** | Basic        | 1           | Joins, AVG                                         |
|                            | Intermediate | 1           | Text Filtering, `GROUP BY`                         |
|                            | Advanced     | 1           | `CAST`, Conditional Aggregation, Left Join         |

# Getting Started

1. Clone the repo
2. Open the .sql file in SSMS
3. Load the sample data
4. Run each section from the Query Bank
5. Refer to Query Execution Summary or Stakeholder Insights

# Author

**Vaibhav Agrawal**  & **Vivek Gautam**

Data & Business Analytics | SQL | Python | Finance  

