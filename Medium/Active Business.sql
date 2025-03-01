-- Question 65
-- Table: Events

Create table Events(business_id int, event_type varchar(20), occurences int)

Insert INto Events Values 
(1,   'reviews' , 7   ),
(3,   'reviews' , 3   ),
(1,   'ads' , 11      ),
(2,   'ads' , 7       ),
(3,   'ads' , 6       ),
(1,   'page views', 3 ),
(2,   'page views', 12)

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | business_id   | int     |
-- | event_type    | varchar |
-- | occurences    | int     | 
-- +---------------+---------+
-- (business_id, event_type) is the primary key of this table.
-- Each row in the table logs the info that an event of some type occured at some business for a number of times.
 

-- Write an SQL query to find all active businesses.

-- An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

-- The query result format is in the following example:

-- Events table:
-- +-------------+------------+------------+
-- | business_id | event_type | occurences |
-- +-------------+------------+------------+
-- | 1           | reviews    | 7          |
-- | 3           | reviews    | 3          |
-- | 1           | ads        | 11         |
-- | 2           | ads        | 7          |
-- | 3           | ads        | 6          |
-- | 1           | page views | 3          |
-- | 2           | page views | 12         |
-- +-------------+------------+------------+

-- Result table:
-- +-------------+
-- | business_id |
-- +-------------+
-- | 1           |
-- +-------------+ 
-- Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
-- Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.

; WITH CTE 
AS
(
Select *, AVG(occurences) over(Partition by event_type) Avg_occ from Events
), CTE1
AS
(
Select *, ROW_NUMBER() OVER(Partition by Business_ID order by Business_ID) RNO from CTE Where occurences > Avg_occ
)
Select Business_ID from CTE1 Where RNO > 2