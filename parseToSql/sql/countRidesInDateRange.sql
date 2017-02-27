SET @startdate = '2016-08-01';
SET @enddate = '2016-09-01';

/** Count the number of rides per hour in the date range defined above. */
SELECT YEAR(start_date), MONTH(start_date), DAY(start_date), HOUR(start_date), COUNT(*) 
  FROM trips
 WHERE start_date >= @startdate
   AND end_date < @enddate
   
 GROUP BY YEAR(start_date), MONTH(start_date), DAY(start_date), HOUR(start_date)
 ORDER BY YEAR(start_date), MONTH(start_date), DAY(start_date), HOUR(start_date);

/** Count the number of rides per day in the date range defined above. */
SELECT YEAR(start_date), MONTH(start_date), DAY(start_date), COUNT(*) 
  FROM trips
 WHERE start_date >= @startdate
   AND end_date < @enddate
   
 GROUP BY YEAR(start_date), MONTH(start_date), DAY(start_date)
 ORDER BY YEAR(start_date), MONTH(start_date), DAY(start_date);

/** Count the number of rides per month in the date range defined above. */
SELECT YEAR(start_date), MONTH(start_date), COUNT(*) 
  FROM trips
 WHERE start_date >= @startdate
   AND end_date < @enddate
   
 GROUP BY YEAR(start_date), MONTH(start_date)
 ORDER BY YEAR(start_date), MONTH(start_date);
