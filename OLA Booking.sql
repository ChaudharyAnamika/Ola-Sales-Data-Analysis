CREATE TABLE bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT FLOAT,
    C_TAT FLOAT,
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(100),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance INT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT,
    Vehicle_Images VARCHAR(100),
    Extra_Column VARCHAR(100)
);
copy bookings(
    Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type,
    Pickup_Location, Drop_Location, V_TAT, C_TAT, Canceled_Rides_by_Customer,
    Canceled_Rides_by_Driver, Incomplete_Rides, Incomplete_Rides_Reason,
    Booking_Value, Payment_Method, Ride_Distance, Driver_Ratings, Customer_Rating,
    Vehicle_Images, Extra_Column
)
FROM 'C:\Program Files\PostgreSQL\17\booking.csv'
DELIMITER ','
CSV HEADER
NULL 'null';

SELECT * FROM bookings;

1. Retrieve all successful bookings:
  Create View Successful_Bookings As
  SELECT * FROM bookings
  WHERE Booking_Status='Success';

  Select * From Successful_Bookings;

2. Find the average ride distance for each vehicle type:
  CREATE View ride_distance_for_each_vehicle AS
  SELECT Vehicle_Type, AVG(Ride_Distance)
  AS avg_distance FROM bookings
  GROUP BY Vehicle_Type;

  SELECT * from ride_distance_for_each_vehicle;

3. Get the total number of cancelled rides by customers:
    CREATE VIEW  Canceled_rides_by_customer As
	SELECT COUNT(*) FROM bookings
	WHERE Booking_Status='Canceled by Customer';

	SELECT * from canceled_rides_by_customer;
	
4. List the top 5 customers who booked the highest number of rides:
  CREATE VIEW Top_5_Customers AS
  SELECT Customer_ID,COUNT(Booking_ID) as total_rides
  FROM bookings
  GROUP BY Customer_ID
  ORDER BY total_rides DESC LIMIT 5;

  SELECT * FROM TOP_5_Customers;
  
5. Get the number of rides cancelled by drivers due to personal and car-related issues:
   CREATE VIEW Cancled_by_drivers_P_C_Issues AS
   SELECT COUNT(*) FROM bookings 
   WHERE canceled_Rides_by_Driver = 'Personal & Car related issue'; 

   SELECT * FROM Cancled_by_drivers_P_C_Issues;
6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

   CREATE VIEW Driver_ratings_for_Prime_sedan AS
   SELECT MAX(Driver_Ratings) as max_rating, MIN(Driver_Ratings) as min_rating FROM
   bookings WHERE Vehicle_Type = 'Prime Sedan';

   SELECT * FROM Driver_ratings_for_Prime_sedan;

7. Retrieve all rides where payment was made using UPI:

   CREATE VIEW Payment_upi AS
   SELECT * FROM bookings WHERE Payment_Method = 'UPI';

    SELECT * FROM Payment_upi;
	
8. Find the average customer rating per vehicle type:

   CREATE VIEW  avg_customer_rating_vehicletype As
   SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM bookings
   GROUP BY Vehicle_Type;

   SELECT * FROM  avg_customer_rating_vehicletype;
   
9. Calculate the total booking value of rides completed successfully:

     CREATE VIEW Ride_suceesfullydone AS
     SELECT SUM(Booking_Value) as total_successful_value FROM bookings WHERE
     Booking_Status = 'Success';

	 SELECT * FROM Ride_suceesfullydone;
    
10. List all incomplete rides along with the reason:
    CREATE VIEW incomplete_rides as
    SELECT Booking_ID, Incomplete_Rides_Reason FROM bookings WHERE Incomplete_Rides =
    'Yes';

	SELECT * FROM incomplete_rides;
    
     

