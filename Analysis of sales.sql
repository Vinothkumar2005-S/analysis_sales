create DATABASE analysis_sales ;
use analysis_sales;
SELECT COUNT(*) from analysis_sales;

SELECT order_number from  analysis_sales
ORDER BY 1 DESC;

SELECT DISTINCT(orderline_number)
from analysis_sales;

SELECT order_number , count(*)
from analysis_sales
GROUP BY 1
HAVING count(*) >1;

## DELETE duplicates values 
DELETE  o
from analysis_sales o
join analysis_sales b
	on o.order_number = b.order_number;

SELECT * from analysis_sales;

# windows functions 
create view delete_numbers as 
SELECT order_number ,customer_name , sales ,
ROW_NUMBER() over(PARTITION BY customer_name ORDER BY sales DESC) as rnk
FROM analysis_sales;

delete from delete_numbers 
where rnk > 1;

SELECT * from analysis_sales;

SELECT * from analysis_sales
where quantity_ordered = 40;

SELECT count(*) from
analysis_sales;

SELECT * from analysis_sales;

# find out 80 to 100 price_each by using where , and , between 
SELECT customer_name , order_number , avg(price_each) as avg_price
from analysis_sales
where price_each BETWEEN 90 and 100
GROUP BY 1,2
ORDER BY avg_price DESC; 

# groupby 
SELECT customer_name , sum(sales) sum_of_sales 
from analysis_sales
GROUP BY 1;

# use COMMON TABLE expression
with cus_row_num as (
SELECT customer_name , year,
	ROW_NUMBER() over(PARTITION BY year ORDER BY customer_name) as row_num
from analysis_sales
)

# use wild card function
SELECT * from cus_row_num
WHERE customer_name LIKE 'A%';


# use the case statements

SELECT order_number , customer_name , sales ,price_each,
case 
	WHEN price_each BETWEEN 91 and 100 then 'high_price'
    WHEN price_each BETWEEN 75 and 90 then 'mid_price'
    WHEN price_each BETWEEN 50 and 74 then 'avg_price'
ELSE 'low_price'
END as price_track
from analysis_sales
ORDER BY customer_name and order_number ASC;


# find out second hightest salary with subquery
create view VW_sales as
SELECT customer_name , sum(sales) as sum_of_sales
from analysis_sales
GROUP BY 1;



SELECT MAX(sum_of_sales) as second_highest_sales 
from VW_sales
WHERE sum_of_sales not in (SELECT MAX(sum_of_sales) from VW_sales);

# find out second hightest salary;

SELECT customer_name , sum_of_sales from VW_sales
ORDER BY sum_of_sales DESC
LIMIT 2 ;

SELECT order_date 
from analysis_sales;

SELECT TIMESTAMP(order_date)
from analysis_sales;

TRUNCATE table analysis_sales;
SELECT * from analysis_sales;

DESCRIBE SELECT order_date 
from analysis_sales;


SELECT date_format(order_date,'%d/%m/%Y')
from analysis_sales;

# find the 3rd max of sales in the table   


create view sales_values as
SELECT sum_of_sales from vw_sales
ORDER BY sum_of_sales DESC ;


SELECT sum_of_sales 
from vw_sales 
ORDER BY sum_of_sales DESC
LIMIT 1 OFFSET 2;










