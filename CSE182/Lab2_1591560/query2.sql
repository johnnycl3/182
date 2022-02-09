SELECT DISTINCT p.name
FROM Persons p, Teams t1, Teams t2, Games g
WHERE (t1.totalWins >= 1 
		AND t1.coachID = p.personID
		AND (g.homeTeam = t1.teamID
		AND g.visitorTeam = t2.teamID
		AND t2.teamColor = 'red')
		AND g.visitorPoints < g.homePoints)
	OR (t2.totalWins >= 1 
		AND t2.coachID = p.personID
		AND (g.visitorTeam = t2.teamID
		AND g.homeTeam = t1.teamID
		AND t1.teamColor = 'red')
		AND g.homePoints < g.visitorPoints);
