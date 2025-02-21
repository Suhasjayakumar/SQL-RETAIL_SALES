select * from retail_sales;

#1.DATA EXPLORATION & CLeaning
#RECORD COUNT
select count(*) from retail_sales;
#
select * from retail_sales
where transactions_id is null;
#
select * from retail_sales
 where sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
#
delete from retail_sales
where sale_date is null or transactions_id is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
#
#HOW MANY SALES
select count(transactions_id)as sales from retail_sales;

#HOW MANY CUSTOMERS
select count(distinct customer_id)as customers from retail_sales;

#DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS
#1.Write a SQL query to retrieve all columns for sales made on 2022-11-05
select * from retail_sales
where sale_date='2022-11-05';

#2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 
select category,sum(quantiy) from retail_sales
where category='clothing'
group by category
having sum(quantiy)>=4;

#3.Write a SQL query to calculate the total sales (total_sale) for each category
select category,sum(quantiy)as total_sales,COUNT(*) as total_orders from retail_sales
group by category;

#4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select round(avg(age))as average_age from retail_sales
where category='Beauty';

#5.Write a SQL query to find all transactions where the total_sale is greater than 1000
select * from retail_sales
where total_sale>1000;

#6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select  category,gender,count(transactions_id)As no_of_trans from retail_sales
group by category,gender;

#7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with best as (select year(sale_date)as years,month(sale_date)as months,avg(total_sale)as average,RANK()OVER(partition by year(sale_date) ORDER BY avg(total_sale)desc)as ranke FROM retail_sales
group by year(sale_date),month(sale_date))
select * FROM best
where ranke=1; 

#8.Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale)as total_sales from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5;

#9.Write a SQL query to find the number of unique customers who purchased items from each category
select count(distinct customer_id)as unique_cus,category from retail_sales
group by category;

#10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT *,
       CASE WHEN HOUR(sale_time) < 12 THEN 'morning' END AS morning_shift,
       CASE WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon' END AS afternoon_shift,
       CASE WHEN HOUR(sale_time) > 17 THEN 'evening' END AS evening_shift
FROM retail_sales;

#END 