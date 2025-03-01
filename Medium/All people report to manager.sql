-- Question 55
-- Table: Employees

create table Employees (employee_id int, employee_name varchar(20), manager_id int)
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | manager_id    | int     |
-- +---------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table indicates that the employee with ID employee_id and name employee_name reports his
-- work to his/her direct manager with manager_id
-- The head of the company is the employee with employee_id = 1.
-- Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.
-- The indirect relation between managers will not exceed 3 managers as the company is small.
-- Return result table in any order without duplicates.
-- The query result format is in the following example:
-- Employees table:
-- +-------------+---------------+------------+
-- | employee_id | employee_name | manager_id |
-- +-------------+---------------+------------+
-- | 1           | Boss          | 1          |
-- | 3           | Alice         | 3          |
-- | 2           | Bob           | 1          |
-- | 4           | Daniel        | 2          |
-- | 7           | Luis          | 4          |
-- | 8           | Jhon          | 3          |
-- | 9           | Angela        | 8          |
-- | 77          | Robert        | 1          |
-- +-------------+---------------+------------+
-- Result table:
-- +-------------+
-- | employee_id |
-- +-------------+
-- | 2           |
-- | 77          |
-- | 4           |
-- | 7           |
-- +-------------+
-- The head of the company is the employee with employee_id 1.
-- The employees with employee_id 2 and 77 report their work directly to the head of the company.
-- The employee with employee_id 4 report his work indirectly to the head of the company 4 --> 2 --> 1. 
-- The employee with employee_id 7 report his work indirectly to the head of the company 7 --> 4 --> 2 --> 1.
-- The employees with employee_id 3, 8 and 9 don't report their work to head of company directly or indirectly.

Insert Into Employees Values 
( 1  ,     'Boss'    , 1 ),
( 3  ,     'Alice'    , 3 ),
( 2  ,     'Bob'    , 1 ),
( 4  ,     'Daniel'    , 2 ),
( 7  ,     'Luis'    , 4 ),
( 8  ,     'Jhon'    , 3 ),
( 9  ,     'Angela'    , 8 ),
( 77 ,     'Robert'    , 1 )

Select employee_id from Employees Where manager_id = 
(Select employee_id from Employees where employee_id = 1)
and Employee_Id <> 1

Select * from Employees

;With CTE 
AS
(
Select manager_ID, ROW_NUMBER() OVER(order by employee_id) as N
from Employees  where employee_id = 1
union All 
Select employee_id, N+1 
from CTE A JOIN Employees b On A.manager_id = b.manager_ID
where n  <= 8 --(can be declared in a variable)
)
Select distinct manager_id as employee_id from CTE where manager_id <> 1 

