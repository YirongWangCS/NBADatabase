/* City that has more than one team */
SELECT cityName
from team
join city on city.cityID = team.cityID
group by cityName
having count(cityName) > 1

/*the highest score each team has made at home*/
with allTeam as(
  SELECT team.teamID, teamName, gameData.ptsHome, gameData.gameID
  from team
  join generate on team.teamID = generate.teamID
  join gameData on generate.gameID = gameData.gameID
  where team.teamID = gameData.homeTeamID
)
select teamID, teamName, max(ptsHome) as HighestPoint
from allTeam
group by teamID, teamName
order by teamID desc;

/*players stay in one team*/
select player.playerID, playerName
from player
join signed on player.playerID = signed.playerID
join team on team.teamID = signed.teamID
group by player.playerID, playerName
having count(team.teamID) = 1

/* A player play on what team for each year. 
Search by the player name*/
SELECT player.playerName, player.playerID, compete.season_year from player
join season on season.playerID = player.playerID
join compete on player.playerID = compete.playerID 
      and season.season_year = compete.season_year
join team on team.teamID = compete.teamID
where player.playerName like '%Kobe Bryant%';

/*teams on each conference*/
SELECT teamName, conference
from team
join conference on conference.conferenceID = team.conferenceID
ORDER by conference

/*top 5 team in east conference has highest assists when at home*/
select top 5 teamName,astHome
from gameData
join team on team.teamID = gameData.homeTeamID
join conference on conference.conferenceID = team.conferenceID
where conference.conference like '%east%'
group by teamName,astHome
order by astHome desc

/*all team home won from 2004-2020*/ 
select teamName,sum(homeTeamWins) as totalWins
from gameData
join team on team.teamID = gameData.homeTeamID
group by teamName
order by totalWins DESC

/*each team regular season record*/
with eachPreSeason as(
  SELECT teamID, seasonID, max(gamesPlayed) as totalGames
  from leaderboard 
  where seasonID > 20000
  group by teamID, seasonID
),
gameData as(
  SELECT DISTINCT eachPreSeason.teamID, eachPreSeason.seasonID, 
                eachPreSeason.totalGames, gamesWon, gamesLost, winPercent
  from eachPreSeason
  join leaderboard on leaderboard.teamID = eachPreSeason.teamID and
  leaderboard.seasonID = eachPreSeason.seasonID AND
  leaderboard.gamesPlayed = eachPreSeason.totalGames
)

SELECT team.teamName, gameData.seasonID, gameData.totalGames, gameData.gamesWon, 
       gameData.gamesLost, gameData.winPercent
from gameData
join team on team.teamID = gameData.teamID
where team.teamName like '%Atlanta%';


/* each team preseason record on each season*/
with eachPreSeason as(
  SELECT teamID, seasonID, max(gamesPlayed) as totalGames
  from leaderboard 
  where seasonID < 20000
  group by teamID, seasonID
),
gameData as(
  SELECT DISTINCT eachPreSeason.teamID, eachPreSeason.seasonID, 
                eachPreSeason.totalGames, gamesWon, gamesLost, winPercent
  from eachPreSeason
  join leaderboard on leaderboard.teamID = eachPreSeason.teamID and
  leaderboard.seasonID = eachPreSeason.seasonID AND
  leaderboard.gamesPlayed = eachPreSeason.totalGames
)

SELECT team.teamName, gameData.seasonID, gameData.totalGames, gameData.gamesWon, 
       gameData.gamesLost, gameData.winPercent
from gameData
join team on team.teamID = gameData.teamID
where team.teamName like '%Atlanta%';

/*The roster of a team on a specific year*/
SELECT teamName, player.playerName, season_year
from compete
join team on team.teamID = compete.teamID
join player on compete.playerID = player.playerID
where season_year like '%2019%' and teamName like '%Portland%'
order by teamName






/* ============== NOT YET INSERTED INTO CODE =================*/

/*Show the game ID, and home team where home team get specific points*/
SELECT gameID, nickname
from gameData
left join team on team.teamID = gameData.homeTeamID
where ptsHome > 135; 



/*sign most team?*/
select TOP 1 player.playerID, playerName, count(distinct team.teamID) as signedTeamNum
from player
join signed on player.playerID = signed.playerID
join team on team.teamID = signed.teamID
group by player.playerID, playerName
order by signedTeamNum desc

/*search by date (MM-DD-YYYY) show all the home team data that day*/
select distinct homeTeamID, ptsHome, fgPctHome, ftPctHome, fg3PctHome, astHome, rebHome
from gameData
join generate on gameData.gameID = generate.gameID
join team on team.teamID = generate.teamID



