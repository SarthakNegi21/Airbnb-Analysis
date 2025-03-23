#Total listings 
Select count(*) from airbnb_listings;

#Find Top 5 Most Expensive Neighborhoods
Select neighbourhood_group,avg(price) as avg_price
from airbnb_listings 
group by neighbourhood_group
order by avg_price desc;

#Find Hosts with the Most Listings
Select host_id,host_name,count(*) as listings
from airbnb_listings 
group by host_id,host_name
order by listings desc; 

#Identify the 5 Most Reviewed Listings
Select id,name,number_of_reviews_ltm
from airbnb_listings 
where rating <> 'No rating'
group by id
order by number_of_reviews_ltm desc
limit 5;  

#What are the most reviewed listings?
Select id, name, number_of_reviews
from airbnb_listings
order by number_of_reviews desc
limit 10;

#Monthly Trend of Reviews
Select month(last_review) as Month, count(*)
from airbnb_listings
group by month(last_review)
order by 1;

#Find High-Price Listings with Low Reviews
Select id,name,price,number_of_reviews
from airbnb_listings
where number_of_reviews < 5
order by price desc,number_of_reviews;

#Check Listings with no rating but High Availability
Select id,name
from airbnb_listings
where rating = 'No rating' and availability_365 > 300
order by rating;

#Revenue Estimation for Each neighbourhood
Select neighbourhood_group,sum(price*minimum_nights) as revenue
from airbnb_listings
group by neighbourhood_group
order by revenue desc;

#Find the 5 Most Profitable Hosts
Select host_id,host_name,sum(price*minimum_nights) as revenue
from airbnb_listings
group by host_id,host_name
order by revenue desc
limit 5;

#Popular Budget-Friendly Neighborhoods
Select neighbourhood, count(*) as listings_count
from airbnb_listings
where price < 100
group by neighbourhood
order by listings_count desc
limit 10;

#Percentage of listings available for the full year (365 days)
Select round(100*(count(*)/(Select count(*) from airbnb_listings)),2) as listing_pct
from airbnb_listings
where availability_365 >= 365;

#Top 5 neighbourhoods with highest average price?
Select neighbourhood, round(avg(price), 2) as avg_price
from airbnb_listings
group by neighbourhood
order by avg_price DESC
limit 5;

#Find listings with extremely high prices (outliers).
Select id, name, neighbourhood, price
from airbnb_listings
where price > (Select avg(price) * 100 from airbnb_listings)
order by price desc;

#Which hosts have the highest average rating (based on reviews per month)?
Select host_id,host_name,avg(reviews_per_month) as avg_reviews
from airbnb_listings
WHERE reviews_per_month IS NOT NULL
group by host_id,host_name
order by avg_reviews desc
limit 5;

#Find the percentage of listings that are rarely available (< 30 days per year)
Select (count(*)/ (Select count(*) from airbnb_listings))*100 as  pct_low_availability
from airbnb_listings
where availability_365 < 30;

#What is the correlation between price and availability?
Select case when availability_365 < 50 then 'Low Availability'
when availability_365 between 50 and 200 then 'Medium Availability'
else 'High Availability' end as availability_category,
avg(price) as avg_price
from airbnb_listings
group by availability_category
order by avg_price desc;

#YOY change in reviews over time?
Select year(last_review) review_year, count(*) as total_reviews
from airbnb_listings
group by review_year
order by review_year;

#Find listings with a high number of reviews but low ratings (potential bad experience).
Select id, name, number_of_reviews, rating
from airbnb_listings
where rating < 3
order by number_of_reviews desc;

#Identify listings where the host has multiple properties in different neighbourhood.
Select host_id, host_name, count(distinct neighbourhood_group) as neighbourhood_cnt
from airbnb_listings
group by host_id, host_name
having neighbourhood_cnt > 1;

#What is the distribution of listings by borough over time?
Select Year(last_review) as review_year,neighbourhood_group, count(*) as total_listings
from airbnb_listings
group by neighbourhood_group, review_year
order by review_year desc, total_listings desc;