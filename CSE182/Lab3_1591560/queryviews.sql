SELECT t.teamID, t.name AS teamName, (t.totalWins - wd.computedWins) AS winDiff, (t.totalLosses - ld.computedLosses) AS lossDiff, COUNT(p.teamID) AS numPlayers
FROM WinsDisagree wd, LossesDisagree ld, Teams t, Players p
WHERE ld.teamID = wd.teamID
	AND t.teamID = wd.teamID
	AND t.teamID = p.teamID
GROUP BY t.teamID, wd.computedWins, ld.computedLosses;

/* 
teamid | teamname   | windiff | lossdiff | numplayers
-------+------------+---------+----------+----------
203    | Peaches    | 1       | -1       | 3
209    | Lone Stars | -1      | -2       | 2
(2 rows)
*/
	
DELETE FROM Games 
WHERE gameID = 10005;

DELETE FROM Games
WHERE gameID = 10001;

--Run again
SELECT t.teamID, t.name AS teamName, (t.totalWins - wd.computedWins) AS winDiff, (t.totalLosses - ld.computedLosses) AS lossDiff, COUNT(p.teamID) AS numPlayers
FROM WinsDisagree wd, LossesDisagree ld, Teams t, Players p
WHERE ld.teamID = wd.teamID
	AND t.teamID = wd.teamID
	AND t.teamID = p.teamID
GROUP BY t.teamID, wd.computedWins, ld.computedLosses;