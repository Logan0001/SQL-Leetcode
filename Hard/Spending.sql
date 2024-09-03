-- Question 113
-- Table: Spending


-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | spend_date  | date    |
-- | platform    | enum    | 
-- | amount      | int     |
-- +-------------+---------+
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile application.
-- (user_id, spend_date, platform) is the primary key of this table.
-- The platform column is an ENUM type of ('desktop', 'mobile').
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

-- The query result format is in the following example:

-- Spending table:
-- +---------+------------+----------+--------+
-- | user_id | spend_date | platform | amount |
-- +---------+------------+----------+--------+
-- | 1       | 2019-07-01 | mobile   | 100    |
-- | 1       | 2019-07-01 | desktop  | 100    |
-- | 2       | 2019-07-01 | mobile   | 100    |
-- | 2       | 2019-07-02 | mobile   | 100    |
-- | 3       | 2019-07-01 | desktop  | 100    |
-- | 3       | 2019-07-02 | desktop  | 100    |
-- +---------+------------+----------+--------+

-- Result table:
-- +------------+----------+--------------+-------------+
-- | spend_date | platform | total_amount | total_users |
-- +------------+----------+--------------+-------------+
-- | 2019-07-01 | desktop  | 100          | 1           |
-- | 2019-07-01 | mobile   | 100          | 1           |
-- | 2019-07-01 | both     | 200          | 1           |
-- | 2019-07-02 | desktop  | 100          | 1           |
-- | 2019-07-02 | mobile   | 100          | 1           |
-- | 2019-07-02 | both     | 0            | 0           |
-- +------------+----------+--------------+-------------+ 
-- On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
-- On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.

Create Table Spending (user_ID int, Spend_date date, Platform varchar(100), amount int)

Insert Into Spending Values
(1, '2019-07-01', 'Mobile', 100),
(1, '2019-07-01', 'desktop', 100),
(2, '2019-07-01', 'Mobile', 100),
(2, '2019-07-02', 'Mobile', 100), 
(3, '2019-07-01', 'Desktop', 100),
(3, '2019-07-02', 'Desktop', 100)



Select * INTO #A FROM 
(
Select Distinct 'Desktop' as PLATFORM, Spend_date  from Spending
UNION 
Select Distinct 'Mobile',  (Spend_date)  from Spending
UNION 
Select  Distinct 'Both', Spend_date from Spending
) a


; WITH CTE 
AS
(
Select USER_ID, Count(DISTINCT USER_ID) Users , SUM(amount) Amount, Spend_date, count(PLATFORM) CC from  Spending  group by Spend_Date , user_ID
)
Select A.Spend_date, ISNULL(Platform, 'BOTH') Platform, A.Amount, A.Users
INTO #B
FROM CTE A 
LEFT JOIN Spending B ON A.user_ID = B.user_ID and A.Spend_date = B.Spend_date and A.CC = 1 Order by Spend_date

Select A.Spend_date, A.PLATFORM, ISNULL(Amount, 0) Amount, ISNULL(Users, 0) USERS 
from #A  a LEFT JOIN #B b ON A.Spend_date = B.Spend_date and A.PLATFORM = b.Platform order by A.Spend_date
