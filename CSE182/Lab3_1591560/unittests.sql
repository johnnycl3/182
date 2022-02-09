--Violate Foreign Key Constraints
INSERT INTO Teams
	VALUES (210, 'Test', 99, 'Santa Cruz', 'gray', 0, 0);

INSERT INTO GamePlayers
	VALUES (11111, 25, 25);

INSERT INTO GamePlayers
	VALUES (10001, 99, 25);

--Violate General Constraints
--Meet and violate reasonable_salary
UPDATE GamePlayers
SET minutesPlayed = 10
WHERE playerID = 1;

UPDATE GamePlayers
SET minutesPlayed = -1
WHERE playerID = 1;

--Meet and violate legal_rating
UPDATE Players
SET rating = 'L'
WHERE playerID = 1;

UPDATE Players
SET rating = 'C'
WHERE playerID = 2;

--Meet and violate null_twice
UPDATE Games 
SET homePoints = NULL,
	visitorPoints = NULL
WHERE gameID = 10001;

UPDATE Games
SET homePoints = NULL,
	visitorPoints = 10
WHERE gameID = 10001;