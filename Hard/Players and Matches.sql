-- Question 109
-- Table: Players

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | player_id   | int   |
-- | group_id    | int   |
-- +-------------+-------+
-- player_id is the primary key of this table.
-- Each row of this table indicates the group of each player.
-- Table: Matches

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | first_player  | int     |
-- | second_player | int     | 
-- | first_score   | int     |
-- | second_score  | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a match, first_player and second_player contain the player_id of each match.
-- first_score and second_score contain the number of points of the first_player and second_player respectively.
-- You may assume that, in each match, players belongs to the same group.
 

-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, 
-- the lowest player_id wins.

-- Write an SQL query to find the winner in each group.

-- The query result format is in the following example:



-- Players table:
-- +-----------+------------+
-- | player_id | group_id   |
-- +-----------+------------+
-- | 15        | 1          |
-- | 25        | 1          |
-- | 30        | 1          |
-- | 45        | 1          |
-- | 10        | 2          |
-- | 35        | 2          |
-- | 50        | 2          |
-- | 20        | 3          |
-- | 40        | 3          |
-- +-----------+------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | first_player | second_player | first_score | second_score |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 15           | 45            | 3           | 0            |
-- | 2          | 30           | 25            | 1           | 2            |
-- | 3          | 30           | 15            | 2           | 0            |
-- | 4          | 40           | 20            | 5           | 2            |
-- | 5          | 35           | 50            | 1           | 1            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +-----------+------------+
-- | group_id  | player_id  |
-- +-----------+------------+ 
-- | 1         | 15         |
-- | 2         | 35         |
-- | 3         | 40         |
-- +-----------+------------+

Create Table Players (Player_Id int, Group_id int)

Create Table Matches (Match_Id int, First_player int, Second_Player int, First_Score int, Second_Score int)

Insert INTO Players Values 
(15, 1), (25, 1), (30, 1), (45, 1), (10, 2), (35, 2), (50, 2), (20,3), (40, 3)

Insert INTO Matches  Values 
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1)

Select * from Players 
Select * from Matches 

Select Match_Id, First_player, Second_Player, First_Score, Second_Score, Group_id
INTO #A 
FROM Matches m JOIN Players p on m.First_player = p.Player_Id

Select * from #A


; WITH CTE 
AS
(
Select PlayerID, SUM(Score) as score, Group_ID FROM 
(
Select First_player As playerID ,  Group_ID, SUM(First_Score) Score  from #A Group By First_player,  Group_ID 
Union
Select Second_Player As PlayerID , Group_ID, SUM(Second_Score) Score  from #A Group By Second_Player,  Group_ID
) a
Group By PlayerID, Group_id
),
Rank_CTE 
AS
(
Select playerID, score, Group_id, ROW_NUMBER() Over(partition by Group_Id order by score desc, PlayerID) RNO from CTE 
)
Select playerID, score, Group_id from Rank_CTE Where RNO = 1