-- You won't lose points if you include or don't include the next two lines
DROP SCHEMA Lab1 CASCADE; 
CREATE SCHEMA Lab1; 

-- Create Tables for Lab1

-- Persons(personID, name, address, salary, canBePlayer, canBeCoach)
CREATE TABLE Persons (
        personID INTEGER,
        name VARCHAR(30),
        address VARCHAR(50),
        salary NUMERIC(7,2),
        canBePlayer BOOLEAN,
        canBeCoach BOOLEAN,
        PRIMARY KEY (personID)
);
-- Okay instead to write:   personID INTEGER PRIMARY KEY


-- Teams(teamID, name, coachID, teamCity, teamColor, totalWins, totalLosses)
CREATE TABLE Teams (
        teamID INTEGER,
        name VARCHAR(30),
        coachID INTEGER,
        teamCity VARCHAR(30),
        teamColor CHAR(6),
        totalWins INTEGER,
        totalLosses INTEGER,
        PRIMARY KEY (teamID),
        FOREIGN KEY (coachID) REFERENCES Persons(personID)
);
-- Okay instead to write:  teamID INTEGER PRIMARY KEY
-- Okay instead to write:  coachID INTEGER REFERENCES Persons(personID)


-- Players(pIayerID, teamID, joinDate, rating, isStarter)
CREATE TABLE Players (
        playerID INTEGER,
        teamID  INTEGER,
        joinDate DATE,
        rating CHAR(1),
        isStarter BOOLEAN,
        PRIMARY KEY (playerID),
        FOREIGN KEY (playerID) REFERENCES Persons(personID),
        FOREIGN KEY (teamID) REFERENCES Teams
);
-- Okay instead to write:  playerID INTEGER PRIMARY KEY
-- Okay instead to write:  playerID INTEGER REFERENCES Persons(personID)
-- Okay instead to write teamID INTEGER REFERENCES Teams or teamID INTEGER REFERENCES Teams(teamID)
-- Also, okay to write REFERENCES Teams(teamID) with either version


-- Games(gameID, gameDate, homeTeam, visitorTeam, homePoints, visitorPoints)
CREATE TABLE Games (
        gameID INTEGER,
        gameDate DATE,
        homeTeam INTEGER,
        visitorTeam INTEGER,
        homePoints INTEGER,
        visitorPoints INTEGER,
        PRIMARY KEY (gameID),
        FOREIGN KEY (homeTeam) REFERENCES Teams(teamID),
        FOREIGN KEY (visitorTeam) REFERENCES Teams(teamID)
);
-- Okay instead to write:  homeTeam INTEGER REFERENCES Teams(teamID)
-- Okay instead to write:  visitorTeam INTEGER REFERENCES Teams(teamID)


-- GamePlayers(gameID, playerID, minutesPlayed)
CREATE TABLE GamePlayers (
        gameID INTEGER,
        playerID INTEGER,
        minutesPlayed INTEGER,
        PRIMARY KEY (gameID, playerID),
        FOREIGN KEY (gameID) REFERENCES Games,
        FOREIGN KEY (playerID) REFERENCES Players
);
-- Okay instead to write:  gameID INTEGER REFERENCES Games
-- Okay instead to write:  playerID INTEGER REFERENCES Players
-- Also kay to write REFERENCES Games(gameID) in either version
-- Also okay to write REFERENCES Players(playerID) in either version
