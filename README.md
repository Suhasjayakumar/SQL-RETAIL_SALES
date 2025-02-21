 Retail Sales Analysis SQL Project

## Project Overview
**Project Title:** Retail Sales Analysis  
**Level:** Beginner  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
- **Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.
- **Data Cleaning:** Identify and remove any records with missing or null values.
- **Exploratory Data Analysis (EDA):** Perform basic exploratory data analysis to understand the dataset.
- **Business Analysis:** Use SQL to answer specific business questions and derive insights from the sales data.

## Data Exploration & Cleaning
1. **Record Count:** Determine the total number of records in the dataset.
   ```sql
   SELECT COUNT(*) FROM retail_sales;
   ```
2. **Customer Count:** Find out how many unique customers are in the dataset.
   ```sql
   SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
   ```
3. **Category Count:** Identify all unique product categories in the dataset.
   ```sql
   SELECT DISTINCT category FROM retail_sales;
   ```
4. **Null Value Check:** Check for any null values in the dataset and delete records with missing data.
   ```sql
   DELETE FROM retail_sales
   WHERE sale_date IS NULL OR transactions_id IS NULL OR sale_time IS NULL OR 
         customer_id IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL OR 
         quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
   ```

## Data Analysis & Findings
1. **Retrieve all sales on 2022-11-05:**
   ```sql
   SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
   ```
2. **Find transactions where the category is 'Clothing' and quantity sold is more than 4:**
   ```sql
   SELECT category, SUM(quantiy) 
   FROM retail_sales
   WHERE category = 'Clothing'
   GROUP BY category
   HAVING SUM(quantiy) > 4;
   ```
3. **Calculate total sales for each category:**
   ```sql
   SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders 
   FROM retail_sales 
   GROUP BY category;
   ```
4. **Find the average age of customers purchasing from the 'Beauty' category:**
   ```sql
   SELECT ROUND(AVG(age)) AS average_age FROM retail_sales WHERE category = 'Beauty';
   ```
5. **Find transactions where the total sale is greater than 1000:**
   ```sql
   SELECT * FROM retail_sales WHERE total_sale > 1000;
   ```
6. **Total number of transactions made by each gender in each category:**
   ```sql
   SELECT category, gender, COUNT(transactions_id) AS no_of_trans
   FROM retail_sales
   GROUP BY category, gender;
   ```
7. **Find the best-selling month in each year based on average sales:**
   ```sql
   WITH best AS (
       SELECT YEAR(sale_date) AS years, MONTH(sale_date) AS months, 
              AVG(total_sale) AS average, 
              RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranke 
       FROM retail_sales
       GROUP BY YEAR(sale_date), MONTH(sale_date)
   )
   SELECT * FROM best WHERE ranke = 1;
   ```
8. **Find the top 5 customers based on total sales:**
   ```sql
   SELECT customer_id, SUM(total_sale) AS total_sales
   FROM retail_sales
   GROUP BY customer_id
   ORDER BY SUM(total_sale) DESC
   LIMIT 5;
   ```
9. **Find unique customers who purchased from each category:**
   ```sql
   SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
   FROM retail_sales 
   GROUP BY category;
   ```
10. **Classify orders into shifts based on sale time:**
    ```sql
    SELECT *,
           CASE WHEN HOUR(sale_time) < 12 THEN 'Morning' 
                WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
                ELSE 'Evening' END AS shift 
    FROM retail_sales;
    ```

## Findings
- **Customer Demographics:** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions:** Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends:** Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights:** The analysis identifies the top-spending customers and the most popular product categories.

## Reports
- **Sales Summary:** A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis:** Insights into sales trends across different months and shifts.
- **Customer Insights:** Reports on top customers and unique customer counts per category.

## Conclusion
This project serves as a comprehensive introduction to SQL for business analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

