-- Question 105
-- The Employee table holds all employees. The employee table has three columns: Employee Id, Company Name, and Salary.

Create table Employee (id int, Company varchar(2), Salary int)

Insert into Employee Values 
(1, 'A', 2341),
(2, 'A', 341),
(3, 'A', 15),
(4, 'A', 15314),
(5, 'A', 451),
(6, 'A', 513),
(7, 'B', 15),
(8, 'B', 13),
(9, 'B', 1154),
(10, 'B', 1345),
(11, 'B', 1221),
(12, 'B', 234),
(13, 'C', 2345),
(14, 'C', 2645),
(15, 'C', 2645),
(16, 'C', 2652),
(17, 'C', 65)

-- +-----+------------+--------+
-- |Id   | Company    | Salary |
-- +-----+------------+--------+
-- |1    | A          | 2341   |
-- |2    | A          | 341    |
-- |3    | A          | 15     |
-- |4    | A          | 15314  |
-- |5    | A          | 451    |
-- |6    | A          | 513    |
-- |7    | B          | 15     |
-- |8    | B          | 13     |
-- |9    | B          | 1154   |
-- |10   | B          | 1345   |
-- |11   | B          | 1221   |
-- |12   | B          | 234    |
-- |13   | C          | 2345   |
-- |14   | C          | 2645   |
-- |15   | C          | 2645   |
-- |16   | C          | 2652   |
-- |17   | C          | 65     |
-- +-----+------------+--------+
-- Write a SQL query to find the median salary of each company. Bonus points if you can solve it without using any built-in SQL functions.

-- +-----+------------+--------+
-- |Id   | Company    | Salary |
-- +-----+------------+--------+
-- |5    | A          | 451    |
-- |6    | A          | 513    |
-- |12   | B          | 234    |
-- |9    | B          | 1154   |
-- |14   | C          | 2645   |
-- +-----+------------+--------+



; WITH CTE 
AS
(
Select *, ROW_NUMBER() OVER(Partition by company order by Salary) RNO ,COUNT(1) OVER(Partition by Company) cnt  from Employee 
),
CTE2
AS
(
Select Company, Salary, cnt%2 ISEVEN , cnt/2 half, RNO  from CTE group by Company, Salary, cnt, RNO
)
Select Company, Salary   from CTE2 
Where (ISEVEN = 0 and RNO between half and half+ 1)
OR (ISEVEN = 1 and RNO = half + 1)


SELECT DISTINCT PERCENTILE_CONT(0.5) 
  WITHIN GROUP (ORDER BY Salary) OVER(Partition by Company) AS "Median"
FROM Employee
group by Company

 
Select DISTINCT Company,

	PERCENTILE_CONT(0.5) WITHIN GROUP(Order by Salary) OVER(Partition by company) 
from Employee


Select * from Employee

Select DISTINCT Company,

	PERCENTILE_CONT(0.99) WITHIN GROUP(Order by Salary desc) OVER(Partition by company) 
from Employee


Select DISTINCT Company,

	PERCENTILE_CONT(0.99) WITHIN GROUP(Order by Salary ) OVER(Partition by company) 
from Employee

Select 100.0/70.0

Select *, NTILE(5) OVER (partition by company order by salary desc) from Employee