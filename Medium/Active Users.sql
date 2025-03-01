--Question 94
-- Table Accounts:

Create table Accounts (id int, name varchar(20))
Create table Logins (id int, login_date date)
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.
 

-- Table Logins:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 
	

-- Write an SQL query to find the id and the name of active users.

-- Active users are those who logged in to their accounts for 5 or more consecutive days.

-- Return the result table ordered by the id.

-- The query result format is in the following example:

Insert Into Accounts Values 
(1, 'Winston'), (7, 'Jonathan')

Insert Into Logins Values 
(7  , '2020-05-30'),
(1  , '2020-05-30'),
(7  , '2020-05-31'),
(7  , '2020-06-01'),
(7  , '2020-06-02'),
(7  , '2020-06-02'),
(7  , '2020-06-03'),
(1  , '2020-06-07'),
(7  , '2020-06-10')

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

Select * from Logins order by id 

; WITH CTE 
AS
(Select Distinct id, login_date
from logins
), CTE1
AS
(
Select Distinct *,(DATENAME(DAYOFYEAR, login_date) - ROW_NUMBER() OVER(Partition By id order by id)) cal_Col from CTE 
)
Select a.id, b.name
FROM CTE1 A
Join Accounts b On A.id = b.id
group by a.id, cal_col,  b.name
having COUNT(1) >= 5