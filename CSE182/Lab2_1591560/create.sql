-- You won't lose points if you include or don't include the next two lines
DROP SCHEMA Lab2 CASCADE; 
CREATE SCHEMA Lab2; 

-- Create Tables for Lab2, which you'll have to modify, adding additional constraints

-- Persons(personID, name, address, salary, canBePlayer, canBeCoach)
CREATE TABLE Persons (
        personID INTEGER,
        name VARCHAR(30) NOT NULL,
        address VARCHAR(50),
        salary NUMERIC(7,2),
        canBePlayer BOOLEAN,
        canBeCoach BOOLEAN,
        PRIMARY KEY (personID)
);


-- Teams(teamID, name, coachID, teamCity, teamColor, totalWins, totalLosses)
CREATE TABLE Teams (
        teamID INTEGER,
        name VARCHAR(30),
        coachID INTEGER,
        teamCity VARCHAR(30),
        teamColor CHAR(6) NOT NULL,
        totalWins INTEGER,
        totalLosses INTEGER,
        PRIMARY KEY (teamID),
        FOREIGN KEY (coachID) REFERENCES Persons(personID),
        UNIQUE(teamCity)
);


-- Players(pIayerID, teamID, joinDate, rating, isStarter)
CREATE TABLE Players (
        playerID INTEGER,
        teamID  INTEGER,
        joinDate DATE NOT NULL,
        rating CHAR(1),
        isStarter BOOLEAN,
        PRIMARY KEY (playerID),
        FOREIGN KEY (playerID) REFERENCES Persons(personID),
        FOREIGN KEY (teamID) REFERENCES Teams
);


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
        FOREIGN KEY (visitorTeam) REFERENCES Teams(teamID),
        UNIQUE(gameDate, homeTeam),
        UNIQUE(gameDate, visitorTeam)
);


-- GamePlayers(gameID, playerID, minutesPlayed)
CREATE TABLE GamePlayers (
        gameID INTEGER,
        playerID INTEGER,
        minutesPlayed INTEGER,
        PRIMARY KEY (gameID, playerID),
        FOREIGN KEY (gameID) REFERENCES Games,
        FOREIGN KEY (playerID) REFERENCES Players
);
