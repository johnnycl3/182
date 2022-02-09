--TotalWins 203, 204, 209
CREATE VIEW WinsDisagree AS 
	SELECT t1.teamID, t1.name AS teamName, t1.totalWins, COUNT(t1.totalWins) AS computedWins
	FROM Games g, Teams t1, Teams t2
	WHERE (g.homeTeam = t1.teamID
			AND g.visitorTeam = t2.teamID
			AND g.homePoints > g.visitorPoints)
		OR (g.visitorTeam = t1.teamID
			AND g.homeTeam = t2.teamID
			AND g.visitorPoints > g.homePoints)	
	GROUP BY t1.teamID
	HAVING COUNT (t1.totalWins) != t1.totalWins;
	


--TotalLosses 201, 202, 203, 205, 209
CREATE VIEW LossesDisagree AS
	SELECT t1.teamID, t1.name AS teamName, t1.totalLosses, COUNT(t1.totalLosses) AS computedLosses
	FROM Games g, Teams t1, Teams t2
	WHERE (g.homeTeam = t1.teamID
			AND g.visitorTeam = t2.teamID
			AND g.homePoints < g.visitorPoints)
		OR (g.visitorTeam = t1.teamID
			AND g.homeTeam = t2.teamID
			AND g.visitorPoints < g.homePoints)	
	GROUP BY t1.teamID
	HAVING COUNT (t1.totalLosses) != t1.totalLosses;

