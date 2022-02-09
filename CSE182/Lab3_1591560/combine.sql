BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Persons(personID, name, address, salary, canBePlayer, canBeCoach)
SELECT pc.personID, pc.name, pc.address, pc.salary, 'TRUE', NULL
FROM PersonChanges pc
WHERE NOT EXISTS (SELECT *
				FROM Persons p
				WHERE p.personID = pc.personID);

UPDATE Persons p
SET canBePlayer = 'False' AND canBeCoach = 'False'
FROM PersonChanges pc
WHERE p.personID = pc.personID;

COMMIT;