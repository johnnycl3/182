SELECT DISTINCT p.name, pl.joinDate
FROM Persons p, Teams t, Players pl 
WHERE p.personID = pl.playerID
	AND t.teamCity != 'New York'
	AND pl.joinDate < DATE '2019-01-31'
	AND p.salary > 78765.43
	AND isStarter = 'TRUE'
	AND p.name LIKE '%er%'