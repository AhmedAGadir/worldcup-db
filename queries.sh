#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT sum(winner_goals) + sum(opponent_goals) as total_goals FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT avg(winner_goals) from games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(avg(winner_goals), 2) from games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT round(avg(winner_goals), 16) + round(avg(opponent_goals), 16) from games;")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) from games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(*) from games where winner_goals > 2;")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name from games full join teams on games.winner_id = teams.team_id where year=2018 and round='Final';")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
# my solution below
echo "$($PSQL "select name from teams full join games on teams.team_id in (games.winner_id, games.opponent_id) where year=2014 and round='Eighth-Final' order by name;")"
# alternative solution from GPT below (uses join instead of full join - more efficient)
# echo "$($PSQL "SELECT DISTINCT name FROM teams JOIN games ON teams.team_id IN (games.winner_id, games.opponent_id) WHERE year=2014 AND round='Eighth-Final' ORDER BY name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct(name) from games left join teams on games.winner_id=teams.team_id order by name;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select year, name from games left join teams on games.winner_id=teams.team_id where round='Final' order by year;")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "select name from teams where name like 'Co%';")"
