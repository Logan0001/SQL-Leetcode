-- Question 99
-- X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

-- Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

Create table stadium (id int, visit_date date, people int)
Insert INTO stadium Values
( 1 , '2017-01-01', 10  ),
( 2 , '2017-01-02', 109 ),
( 3 , '2017-01-03', 150 ),
( 4 , '2017-01-04', 99  ),
( 5 , '2017-01-05', 145 ),
( 6 , '2017-01-06', 1455),
( 7 , '2017-01-07', 199 ),
( 8 , '2017-01-08', 188 )

-- For example, the table stadium:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- For the sample data above, the output is:

-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- Note:
-- Each day only have one row record, and the dates are increasing with id increasing.
; WITH CTE 
AS
(
Select *, case When (people > 100 ) Then 'Y' Else 'N' END Mor from stadium
), CTE1
AS
(
Select *,  id - ROW_NUMBER() OVER(partition by Mor order by id) RNO
FROM CTE 
), CTE2
AS
(
Select *, Count(1) over(partition by RNO) cnt from CTE1 Where mor = 'Y'  
)
Select id, visit_date, people from CTE2 Where cnt > 3
