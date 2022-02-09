SELECT p.name, p.address, p.salary
FROM Persons p, Teams t, Players pl
WHERE t.coachID = p.personID
	AND pl.playerID = p.personID;