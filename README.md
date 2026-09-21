# Amazon Sales Data Analysis (SQL)

A beginner-friendly SQL project in **MySQL** that analyzes Amazon sales data to answer common business questions about revenue, products, customers, cities, and monthly trends.

## Objective

Use SQL to turn raw order data into useful insights, such as which products earn the most, who the top customers are, and how sales change month by month.

## Tools Used

- MySQL 8.0+
- MySQL Workbench

## Database

**Database:** `amazon_sales_analysis` | **Table:** `amazon_sales`

| Column Group | Columns |
|--------------|---------|
| Order details | OrderID, OrderDate, OrderStatus, PaymentMethod |
| Customer details | CustomerID, CustomerName, City, State, Country |
| Product details | ProductID, ProductName, Category, Brand, SellerID |
| Amount details | Quantity, UnitPrice, Discount, Tax, ShippingCost, TotalAmount |

## Analysis Performed

**Basic KPIs (Q1-Q5)**
- Total orders, total revenue, total quantity sold, average order value, unique customers

**Sales & Product Analysis (Q6-Q14)**
- Sales by category, brand, and city
- Orders by payment method and order status
- Top 5 products by quantity and by revenue
- Categories with sales above ₹1 crore
- Average order value by category

**Trend Analysis (Q16-Q18)**
- Monthly sales trend
- Monthly revenue and order count
- Highest revenue month

**Customer & Advanced Analysis (Q15, Q19-Q21)**
- Customers who spent more than ₹50,000
- Top-selling city in each state
- Top 3 customers in each city
- Top 3 products in each category

## SQL Concepts Used

- Aggregate functions: `COUNT`, `SUM`, `AVG`
- `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`
- Date functions: `YEAR()`, `MONTH()`
- Subqueries
- Window function: `ROW_NUMBER() OVER (PARTITION BY ...)`

## Sample Query

Top 3 products in each category by revenue:

```sql
SELECT Category, ProductName, TotalRevenue
FROM (
    SELECT Category,
           ProductName,
           SUM(TotalAmount) AS TotalRevenue,
           ROW_NUMBER() OVER (
               PARTITION BY Category
               ORDER BY SUM(TotalAmount) DESC
           ) AS rn
    FROM amazon_sales
    GROUP BY Category, ProductName
) AS ranked
WHERE rn <= 3
ORDER BY Category, rn;
```

## How to Run

1. Open MySQL Workbench.
2. Run the schema part of `amazon.sql` to create the database and table.
3. Import your dataset (CSV) into the `amazon_sales` table.
4. Run the queries (Q1-Q21) one by one.

## Files

- `amazon.sql` - database schema and all analysis queries
- `README.md` - project documentation

## Author

Lokesh
[LinkedIn] www.linkedin.com/in/lokesh-seervi-ba5020370 | [GitHub] https://github.com/LoKeshseervi2169
