SELECT DISTINCT t1.name AS team1, t1.teamCity AS team1City, t2.name AS team2, t2.teamCity AS team2City
FROM Teams t1, Teams t2, Games g1, Games g2
WHERE t1.teamID = g1.homeTeam
		AND t2.teamID = g1.visitorTeam
		AND g1.homePoints > g1.visitorPoints
EXCEPT
SELECT DISTINCT t1.name AS team1, t1.teamCity AS team1City, t2.name AS team2, t2.teamCity AS team2City
FROM Teams t1, Teams t2, Games g1, Games g2
WHERE t1.teamID = g1.visitorTeam
		AND t2.teamID = g1.homeTeam
		AND g1.homePoints > g1.visitorPoints;