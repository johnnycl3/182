SELECT DISTINCT p.personID, p.name, p.salary
FROM Persons p, GamePlayers gp
WHERE (p.canBePlayer = 'TRUE'
		AND p.personID != gp.playerID)

EXCEPT 

SELECT DISTINCT p.personID, p.name, p.salary
FROM Persons p, GamePlayers gp
WHERE (p.canBePlayer = 'TRUE'
		AND p.personID = gp.playerID)

ORDER BY name DESC,
		salary ASC;