-- Question 107
-- The Numbers table keeps the value of number and its frequency.

Create table numbers (Number int, Frequency int)

Insert into numbers Values 
(0,7), (1, 1), (2, 3), (3, 1)

Select * from numbers
-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.



; WITH CTE 
AS
(
Select number, Frequency from numbers Where Frequency > 0 
Union All 
Select number, Frequency - 1
From CTE 
Where Frequency > 1
)
Select DISTINCT PERCENTILE_CONT(.5) WITHIN group(order by number) over() from CTE 