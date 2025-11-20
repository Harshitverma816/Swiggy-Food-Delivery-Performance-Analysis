
-- Swiggy Data Analysis SQL Queries

-- 1. Most Active cities
select customer_city, count(*) as total_orders 
from swiggy_data 
group by customer_city 
order by total_orders desc;

-- 2. Peak Ordering Hours
select extract(hour from order_datetime) as hour, count(*) as total_orders 
from swiggy_data 
group by hour 
order by total_orders desc;

-- 3. Top Selling Cuisine
select cuisine, count(*) as total_orders 
from swiggy_data 
group by cuisine 
order by total_orders desc;

-- 4. Restaurant-wise Order Volume
select restaurant_name, count(*) as total_orders 
from swiggy_data 
group by restaurant_name 
order by total_orders desc;

-- 5. Average Delivery Time Per Restaurant
select restaurant_name, avg(delivery_time_mins) as avg_delivery_time  
from swiggy_data 
group by restaurant_name 
order by avg_delivery_time;

-- 6. Delivery Partner Performance 
select delivery_partner, count(*) as total_deliveries, avg(delivery_time_mins) as avg_delivery_time  
from swiggy_data 
group by delivery_partner 
order by avg_delivery_time;

-- 7. Late Deliveries Percentage
select 
	(sum(case when is_delayed = 1 then 1 else 0 end) * 100.0) / count(*) as late_deliveries_percrntage   
from swiggy_data;

-- 8. Revenue by City
select customer_city, sum(total_payable) as total_revenue 
from swiggy_data 
group by customer_city 
order by total_revenue desc;

-- 9. Top repeat customers
select customer_id, 
    count(*) as total_orders
from swiggy_data 
group by customer_id 
order by total_orders desc
limit 10;

-- 10. Customer Membership Vs Order Count
select customer_membership, count(*) as total_orders 
from swiggy_data 
group by customer_membership;

-- 11. Coupon Usage Distribution
select coupon_code_used, count(*) as usage_count 
from swiggy_data 
group by coupon_code_used 
order by usage_count desc;

-- 12. Revenye Contribution by Customer Segment
select customer_segment, 
	count(*) as orders,
    sum(total_payable) as revenue,
    avg(total_payable) as avg_order_value 
from swiggy_data 
group by customer_segment 
order by revenue desc;

-- 13. Impact of Coupons on Average Order Value
select 
	case when coupon_code_used = 'NONE' then 'No Coupon' 
    else 'Coupon Used' end as coupon_flag, 
    count(*) as total_orders,
    avg(total_payable) as avg_order_value 
from swiggy_data 
group by coupon_flag;

-- 14. Delay Analysis by Restaurant Type
select restaurant_type, 
	count(*) as total_orders, 
    sum(is_delayed) as delayed_orders, 
    (sum(is_delayed) * 100.0 / count(*)) as delayed_percentage 
from swiggy_data 
group by restaurant_type 
order by delayed_percentage desc;

-- 15. Top 10 Highest Revenue Customers
select customer_id, 
	count(*) as order_count,
    sum(total_payable) as total_spent 
from swiggy_data 
group by customer_id 
order by total_spent desc 
limit 10;

-- 16. Delivery Time Vs Rating Analysis
select rating, 
	avg(delivery_time_mins) as avg_delivery_time,
    count(*) as rating_count 
from swiggy_data 
group by rating 
order by rating;

-- 17. Monthly revenue trend
select date_format(order_datetime, '%Y-%m') as month, SUM(order_amount) as revenue
from swiggy_data
group by month
order by month;

-- 18. Cancelled orders percentage
select 
    (sum(case when delivery_status='Cancelled' then 1 else 0 end) * 100.0) / count(*) 
    as cancelled_percentage
from swiggy_data;
