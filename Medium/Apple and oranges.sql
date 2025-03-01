-- Table: Sales

Create table Saless (sale_date date, fruit nvarchar(50), sold_num int)

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_date     | date    |
-- | fruit         | enum    | 
-- | sold_num      | int     | 
-- +---------------+---------+
-- (sale_date,fruit) is the primary key for this table.
-- This table contains the sales of "apples" and "oranges" sold each day.
-- Write an SQL query to report the difference between number of apples and oranges sold each day.
-- Return the result table ordered by sale_date in format ('YYYY-MM-DD').
-- The query result format is in the following example:

Insert Into Saless values 
( '2020-05-01', 'apples'  , 10 ),
( '2020-05-01', 'oranges'  , 8  ),
( '2020-05-02', 'apples'  , 15 ),
( '2020-05-02', 'oranges'  , 15 ),
( '2020-05-03', 'apples'  , 20 ),
( '2020-05-03', 'oranges'  , 0  ),
( '2020-05-04', 'apples'  , 15 ),
( '2020-05-04', 'oranges'  , 16 )

-- Sales table:
-- +------------+------------+-------------+
-- | sale_date  | fruit      | sold_num    |
-- +------------+------------+-------------+
-- | 2020-05-01 | apples     | 10          |
-- | 2020-05-01 | oranges    | 8           |
-- | 2020-05-02 | apples     | 15          |
-- | 2020-05-02 | oranges    | 15          |
-- | 2020-05-03 | apples     | 20          |
-- | 2020-05-03 | oranges    | 0           |
-- | 2020-05-04 | apples     | 15          |
-- | 2020-05-04 | oranges    | 16          |
-- +------------+------------+-------------+

-- Result table:
-- +------------+--------------+
-- | sale_date  | diff         |
-- +------------+--------------+
-- | 2020-05-01 | 2            |
-- | 2020-05-02 | 0            |
-- | 2020-05-03 | 20           |
-- | 2020-05-04 | -1           |
-- +------------+--------------+

; WITH CTE 
AS
(
Select *, LEAD(sold_num) Over (Partition by sale_date order by sale_date) l from Saless
)
Select Sale_date, (sold_num - l) diff from CTE Where L IS NOT NULL

; WITH CTE 
AS
(
Select *, ROW_NUMBER() OVER(partition by sale_date order by sale_date) RNO  from Saless
)
Select a.sale_date, (b.sold_num -  a.sold_num) diff from CTE A JOIN CTE B ON A.sale_date = B.sale_date and a.RNO > b.RNO



-- Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
-- Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
-- Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
-- Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).


