-- =========================================
-- AMAZON SALES DATA ANALYSIS
-- SQL Project using MySQL
-- =========================================

-- ==================================
--SCHEMA OF THE DATABASE & TABLE--
-- ==================================
Create database if not exists amazon_sales_analysis;
use amazon_sales_analysis;
create table if not exists amazon_sales (
    OrderID VARCHAR(50),
    OrderDate DATE,
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(100),
    ProductID VARCHAR(50),
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Brand VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Tax DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    TotalAmount DECIMAL(12,2),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    SellerID VARCHAR(50));

-- ==================
-- BASIC ANALYSIS
-- ==================

-- Q1. Total number of orders
Select count(OrderID) from amazon_sales;

-- Q2. Total revenue
select sum(TotalAmount) from amazon_sales;

-- Q3. Total quantity sold
select sum(Quantity) from amazon_sales;

-- Q4. Average order value
select avg(TotalAmount) from amazon_sales;

-- Q5. Unique customers
select count(distinct CustomerID) from amazon_sales;

-- ====================
-- PRODUCT ANALYSIS
-- ====================

-- Q6.Find total sales by category.
select Category,sum(TotalAmount) from amazon_sales group by Category;

-- Q7.Find total sales by brand.
select Brand,sum(TotalAmount) from amazon_sales group by Brand;

-- Q8.Find total sales by city.
select City,sum(TotalAmount) from amazon_sales group by City;

-- Q9.Count the number of orders by payment method.
select PaymentMethod, count(OrderID) from amazon_sales group by PaymentMethod;

-- Q10.Count the number of orders by order status.
select OrderStatus, count(OrderID) from amazon_sales group by OrderStatus;

-- Q11.Find the Top 5 best-selling products based on quantity sold.
select ProductName,sum(Quantity) as TotalQuantity_Sold from amazon_sales group by ProductName order by TotalQuantity_Sold desc limit 5;

-- Q12.Find the Top 5 products by revenue.
select ProductName,sum(TotalAmount) as TotalRevenue from amazon_sales group by ProductName order by TotalRevenue desc limit 5;

-- Q13.Find categories whose total sales are greater than ₹1 crore.
select Category,sum(TotalAmount) as TotalSales from amazon_sales group by Category having TotalSales>10000000;

-- Q14.Find the average order value for each category.
select Category,avg(TotalAmount) as Average_OrderValue from amazon_sales group by Category;

-- Q15.Find the city with the highest sales from each state.
select State,City,TotalSales from (select State,City,sum(TotalAmount)as TotalSales,row_number() over(partition by State order by
 sum(TotalAmount)desc) as rn from amazon_sales group by State,City)as ranked where rn=1 order by State;

-- Q16.Find the monthly sales trend.
select year(OrderDate) as Year,month(OrderDate) as Month, sum(TotalAmount) as MonthlyRevenue from amazon_sales 
group by Year(OrderDate),month(OrderDate) order by Year,Month;

-- Q17.Find the total sales and total orders for each month.
select year(OrderDate) as Year,month(OrderDate) as Month, sum(TotalAmount) as MonthlyRevenue,Count(OrderID) as TotalOrders from amazon_sales 
group by Year(OrderDate),month(OrderDate) order by Year,Month;

-- Q18.Find the month that generated the highest revenue
select year(OrderDate) as Year,month(OrderDate) as Month, sum(TotalAmount) as MonthlyRevenue from amazon_sales
 group by Year(OrderDate),month(OrderDate) order by MonthlyRevenue desc limit 1;	

-- Q19.Find customers whose total purchase amount is ₹50,000 or more.
select CustomerName, sum(TotalAmount) as TotalSpent from amazon_sales group by CustomerName having sum(TotalAmount) >50000 order by TotalSpent asc;

-- Q20.Find the Top 3 customers in each city based on total spending
select City,CustomerName,CustomerID,TotalSpendings from (select City,CustomerName,CustomerID,sum(TotalAmount) as TotalSpendings,row_number()
 over(partition by City order by sum(TotalAmount) desc)as rn from amazon_sales group by City,CustomerName,CustomerID)as ranked where rn <=3 order by City,rn;

-- Q21.Find the Top 3 products within each category based on revenue.
select Category,ProductName,TotalRevenue from (select Category,ProductName,sum(TotalAmount) as TotalRevenue,
 row_number() over(partition by Category order by sum(TotalAmount)desc)as rn from amazon_sales group by Category,ProductName)as ranked where rn<=3 order by Category,rn;
 
 
