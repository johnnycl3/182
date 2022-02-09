DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE Persons (
	personID		INT,
	name			VARCHAR (30),
	address			VARCHAR (50),
	salary			NUMERIC (10,2),
	canBePlayer		BOOLEAN, 
	canBeCoach		BOOLEAN,
	PRIMARY KEY (personID)
);

CREATE TABLE Teams (
	teamID			INT,
	name			VARCHAR (30),
	coachID			INT,
	teamCity		VARCHAR (30),
	teamColor		VARCHAR (15),
	totalWins		INT,
	totalLosses		INT,
	PRIMARY KEY (teamID)

);

CREATE TABLE Players (
	playerID		INT,
	teamID			INT,
	joinDate		DATE,
	rating			CHAR (1),
	isStarter		BOOLEAN,
	PRIMARY KEY (playerID),
	FOREIGN KEY (teamID) REFERENCES Teams

);

CREATE TABLE Games (
	gameID			INT,
	gameDate		DATE,
	homeTeam		INT,
	visitorTeam		INT,
	homePoints		INT,
	visitorPoints	INT,
	PRIMARY KEY (gameID)

);

CREATE TABLE GamePlayers (
	gameID			INT,
	playerID		INT,
	minutesPlayed	INT,
	PRIMARY KEY (gameID, playerID),
	FOREIGN KEY (gameID) REFERENCES Games,
	FOREIGN KEY (playerID) REFERENCES Players

);








