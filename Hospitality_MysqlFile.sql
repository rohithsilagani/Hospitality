create database hospitality;
use hospitality;

-- 1. dim_hotels
CREATE TABLE dim_hotels (
    property_id INT,
    property_name VARCHAR(255), 
    category VARCHAR(100),
    city VARCHAR(100)
);
select * from dim_hotels;

-- 2. dim_rooms
CREATE TABLE dim_rooms (
    room_id VARCHAR(10) ,
    room_class VARCHAR(100)
);

select * from dim_rooms;

CREATE TABLE dim_date (
    date_str VARCHAR(20),
    mmm_yy VARCHAR(20),
    week_no VARCHAR(10),
    day_type VARCHAR(20)
);

-- 3. dim_date
CREATE TABLE dim_date (
    date_str VARCHAR(20),
    mmm_yy VARCHAR(20),
    week_no VARCHAR(10),
    day_type VARCHAR(20)
);
truncate dim_date;
select * from dim_date;

-- 4. fact_bookings
CREATE TABLE fact_bookings (
    booking_id VARCHAR(50) ,
    property_id INT,
    booking_date VARCHAR(20),
    check_in_date VARCHAR(20),
    checkout_date VARCHAR(20),
    no_guests INT,
    room_category VARCHAR(10),
    booking_platform VARCHAR(50),
    ratings_given FLOAT,
    booking_status VARCHAR(50),
    revenue_generated INT,
    revenue_realized INT
);

select * from fact_bookings;

-- 5. fact_aggregated_bookings
CREATE TABLE fact_aggregated_bookings (
    property_id INT,
    check_in_date VARCHAR(20),
    room_category VARCHAR(10),
    successful_bookings INT,
    capacity INT
);

select * from fact_aggregated_bookings;

---- Total Revenue ----
SELECT CONCAT(ROUND(SUM(revenue_realized) / 1000000), 'M') AS total_revenue
FROM fact_bookings;


---- Total Bookings ----
SELECT CONCAT(ROUND(COUNT(DISTINCT booking_id) / 1000.0),'K') AS Total_Bookings
FROM fact_bookings;

--- Cancelled Bookings ----
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS Cancelled_Booking
FROM fact_bookings
WHERE booking_status = 'Cancelled';

---- Number of Checkouts ---
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS No_of_Checkouts
FROM fact_bookings
WHERE booking_status = 'Checked out';

---- Number of No-Shows ----
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS Num_of_No_Shows
FROM fact_bookings
WHERE booking_status = 'No Show';

--- Total Rooms ----
SELECT CONCAT(ROUND(COUNT(DISTINCT booking_id) / 1000.0),'K') AS Total_Rooms
FROM fact_bookings;

--- Cancellation Rate ---
SELECT CONCAT(
         ROUND(
           COUNT(DISTINCT CASE 
               WHEN booking_status = 'Cancelled' 
               THEN booking_id 
           END) * 100 
           / COUNT(DISTINCT booking_id)),
         '%'
       ) AS `cancellation Rate`
FROM fact_bookings;

---- Occupancy Rate---
SELECT CONCAT(ROUND(SUM(successful_bookings) / SUM(capacity) * 100),'%') AS Occupancy_Rate
FROM fact_aggregated_bookings;

---- Utilized Capacity---
SELECT CONCAT(
         ROUND(
           COUNT(DISTINCT CASE
               WHEN booking_status = 'Checked Out'
               THEN booking_id
           END) / COUNT(DISTINCT booking_id) * 100
         ),
         '%'
       ) AS Utilized_Capacity
FROM fact_bookings;

--- Revenue by City---
SELECT dh.city,CONCAT(ROUND(SUM(fb.revenue_generated) / 1000000.0), 'M') AS Total_Revenue
FROM dim_hotels AS dh
JOIN fact_bookings AS fb
    ON dh.property_id = fb.property_id
GROUP BY dh.city;

--- Revenue Lost due to Cancelled--

SELECT 
    SUM(revenue_realized) AS revenue_lost
FROM fact_bookings
WHERE booking_status IN ('Cancelled', 'No Show');

--- Revenue by Room Class ---

SELECT dr.room_class,
CONCAT(ROUND(SUM(fb.revenue_realized) / 1000000.0), 'M') AS Total_Revenue
FROM dim_rooms AS dr
JOIN fact_bookings AS fb
ON dr.room_id = fb.room_category
GROUP BY dr.room_class;


---- Revenue by Hotel Class luxury vs  Business  ---

SELECT h.category AS hotel_class,
    CONCAT(
        ROUND(SUM(f.revenue_realized) / 1000000, 2),
        ' M'
    ) AS revenue
FROM hospitality.fact_bookings f
JOIN hospitality.dim_hotels h
    ON f.property_id = h.property_id
GROUP BY h.category;




--- Average Revenue per Booking ----
SELECT
    AVG(revenue_realized) AS avg_revenue_per_booking
FROM fact_bookings
WHERE booking_status = 'Checked Out';

--- Top 3 Hotels By Revenue ----
SELECT 
    dh.property_name,
    COUNT(DISTINCT fb.booking_id) AS Total_Bookings
FROM fact_bookings fb
JOIN dim_hotels dh
    ON dh.property_id = fb.property_id
GROUP BY dh.property_name
ORDER BY Total_Bookings DESC
LIMIT 3;

--- Top 3 hotels by occupancy ---
SELECT dh.property_name,CONCAT(ROUND(SUM(successful_bookings) / SUM(capacity) * 100),'%') AS Occupancy_Rate
FROM fact_aggregated_bookings fb
JOIN dim_hotels dh
ON dh.property_id = fb.property_id
GROUP BY dh.property_name
ORDER BY SUM(fb.successful_bookings) / SUM(fb.capacity) DESC
LIMIT 3;

---- Top 3 Hotels by Revenue ---

SELECT dh.property_name,CONCAT(
        ROUND(SUM(fb.revenue_realized) / 1000000.0),'M') AS Total_Revenue
FROM fact_bookings fb
JOIN dim_hotels dh
    ON dh.property_id = fb.property_id
GROUP BY dh.property_name
ORDER BY SUM(fb.revenue_realized) DESC
LIMIT 3;



























SELECT COUNT(booking_id) AS total_bookings 
FROM fact_bookings;

SELECT (SUM(successful_bookings) / SUM(capacity)) * 100 AS occupancy_percentage
FROM fact_aggregated_bookings;

SELECT ROUND(AVG(ratings_given),2) AS avg_rating 
FROM fact_bookings 
WHERE ratings_given IS NOT NULL;

SELECT 
    dh.property_name,
    CONCAT(ROUND(SUM(fb.revenue_realized) / 1000000.0), 'M') AS Total_Revenue
FROM fact_bookings fb
JOIN dim_hotels dh 
    ON dh.property_id = fb.property_id
GROUP BY dh.property_name
ORDER BY SUM(fb.revenue_realized) DESC
LIMIT 3;












