CREATE OR REPLACE FUNCTION fireSomePlayersFunction(maxFired INTEGER) 
RETURNS INTEGER AS $$
	
	DECLARE 
		firedCount INTEGER;
		
		firedPlayerID INTEGER;
		firedSalary NUMERIC(7,2);

	DECLARE atRisk CURSOR FOR
		SELECT p.playerID
		FROM Players p, GamePlayers gp, Persons pe
		WHERE p.teamID IS NOT NULL
			AND p.rating = 'L'
			AND p.playerID = gp.playerID
			AND pe.personID = p.playerID
		GROUP BY p.playerID, pe.salary
		HAVING SUM(gp.minutesPlayed) > 60
		ORDER BY pe.salary DESC;

	BEGIN 
		firedCount := 0;
		
		OPEN atRisk;
		LOOP
			FETCH atRisk INTO firedPlayerID, firedSalary;
			EXIT WHEN NOT FOUND OR firedCount >= maxFired;
			firedCount = firedCount + 1;
			UPDATE Players
			SET teamID = NULL
			WHERE playerID = firedPlayerID;
		END LOOP;
		CLOSE atRisk;
		RETURN firedCount;

	END
$$ LANGUAGE plpgsql;