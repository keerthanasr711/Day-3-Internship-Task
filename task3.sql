create database task3;
use task3;
create table retail_sales
(
	transactions_id INT,
    sale_date date,
    sale_time time,
    customer_id int,
    gender varchar(50),
    age int,
    category varchar(15),
    quantity int,
    price_per_unit float,
    cogs float,
    total_sales float
);
-- checking count of rows Imported. and import Data Succesfully.
select count(*) from retail_sales;

-- to see the all the columns name with datatype
show columns from retail_sales;
select * from retail_sales;
-- Data cleaning 
select * from retail_sales
where transactions_id is null;

-- Checking is there any unwanted rows
select * from retail_sales
where 
transactions_id = '0'
or 
sale_time= '0'
or
customer_id = '0'
or
gender = '0'
or
category = '0'
or
quantiy = '0'
or
price_per_unit = '0'
or
cogs = '0'
or
total_sale = '0';
-- we got 3 0 values we need remove it.
-- i am using mysql safe mode where delete command wont works so now i am changing it 0 where i can use delete command.
SET SQL_SAFE_UPDATES = 0;

-- deleting unwanted rows;
delete  from retail_sales
where quantiy = '0';

-- How many sales we have? aggregate function.
create view total_sales as 
select count(*) as total_sales from retail_sales;
select * from total_sales;

-- Q.1 write SQL query to retrive all column for sales made on '2022-11-05' & total revenue on this date?
select * from retail_sales where sale_date = '05-11-2022';
create view  one_day_sales as
select sum(total_sale) as total_revenue from retail_sales where sale_date = '05-11-2022';
select * from one_day_sales;

-- Q .2 write a SQL query to calculate the total sales and there order_count for each category?group by function.
create view sales_by_category as
select category,sum(total_sale),count(*) as total_orders from retail_sales
group by category;
select * from sales_by_category;

-- Q.3 Write an SQL query to find the total number of transaction(transaction_id) made by each gender in each category?
create view sales_by_gender as
select category,gender,count(*) from retail_sales
group by category,gender
order by category;
select * from sales_by_gender;

-- Q.4 write a SQL query to find the average age of the customer who purchased items from the 'Beauty' category?
-- here we used round function which we reduce the decimal point upto some extence 
select round(avg(age),2) avg_age_of_customer from retail_sales
where category = 'Beauty';

-- Q.5 write an SQL query to find all transactions where the total_sale is greater than 1000?
select * from retail_sales
where total_sale > 1000;

-- Q.6 write an SQL query to find the top 5 customer based on the total_sales?
select customer_id, sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- Q.7 write a SQL query to find the number of unique customers who purchased item from each category?
select category,count(distinct customer_id) from retail_sales
group by category;




