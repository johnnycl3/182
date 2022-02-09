#! /usr/bin/env python

#  runVolleyballApplication skeleton, to be modified by students

import psycopg2, sys

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runVolleyballApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third C function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # teamPlayerCount(myConn, name):
 # The teamPlayerCount Python function returns the number of players who are the team with a
 # specified name.  The arguments for teamPlayerCount are the database connection and the name
 # of the team.
 #
 # It is not an error if there is no team with that name in the Teams table. It is also not an
 # error if there is a team with that name, but there are no players on that team.  In both of
 # these circumstances, teamPlayerCount should return 0.

def teamPlayerCount(myConn, name):
    try:
        stmt1 = "SELECT p.teamID FROM Players p, Teams t WHERE p.teamID = t.teamID AND t.name = %s"
        cursor = myConn.cursor()
        cursor.execute(stmt1, (name,))
        teamCount = cursor.rowcount
            
    except:
        print("Call of teamPlayerCount on", name, "had error", file=sys.stderr)
        cursor.close()
        myConn.close()
        sys.exit(-1)
        
    # Python function to be supplied by students
    # You'll need to figure out value to return.
    cursor.close()
    return teamCount

# end teamPlayerCount


# updateTeamCity(myConn, :
# teamCity is an attribute of the Teams table.  Sometimes a team moves to a different city.

# Besides the database connection, the updateTeamCity Python function has two arguments, an
# integer argument theTeamID and a string argument, newTeamCity.  For every team in the Teams
# table (if any) whose teamID equals theTeamID, updateTeamCity should change that team’s
# teamCity to be newTeamCity.
#
#There might be no team whose teamCity equals theTeamID (that’s not an error), and there also
# might be one team whose teamCity equals theTeamID, since teamCity is the Primary Key of the
# Teams table.  updateTeamCity should return the number of teams whose teamCity was updated.

def updateTeamCity(myConn, theTeamID, newTeamCity):
    try:
        stmt2 = "UPDATE Teams SET teamCity = %s WHERE teamID = %s;"
        cursor = myConn.cursor()
        cursor.execute(stmt2, (newTeamCity, theTeamID,))
        if cursor.rowcount > 0:
            return 1
            
    except:
        print("Call of updateTeamCity on", theTeamID, "and", newTeamCity, "had error", file=sys.stderr)
        cursor.close()
        myConn.close()
        sys.exit(-1)
    # Python function to be supplied by students
    cursor.close()
    return 0

# end updateTeamCity


# fireSomePlayers(myConn, maxFired):
# Besides the database connection, this Python function has one integer parameters, maxFired.
# A value of maxFired that’s not positive is invalid, and you should call sys.exit(-1) from
# fireSomePlayers if an invalid maxFired value has been provided.
#
# fireSomePlayers invokes a Stored Function, fireSomePlayersFunction, that you will need to
# implement and store in the database according to the description in Section 5.  The Stored
# Function fireSomePlayersFunction should just have one parameter, maxFired, so don’t the
# database connection is not a parameter for this Stored Function.
#
# Section 5 explains what “firing” means, and also tells you which Players should be fired,
# The fireSomePlayers Python function should return the same integer result that the
# fireSomePlayersFunction Stored Function returns.
#
# The fireSomePlayers function must only invoke the Stored Function fireSomePlayersFunction,
# which does all of the work for this part of the assignment; fireSomePlayers should not do
# the work itself.

def fireSomePlayers(myConn, maxFired):

# We're gving you the code for fireSomePlayers, but you'll have to write the Stored Function
# fireSomePlayersFunction yourselves in a PL/pgSQL file named fireSomePlayersFunction.pgsql

    if maxFired <= 0:
        print(maxFired, "is an illegal value for maxFired")
        sys.exit(-1)
        
    try:
        myCursor = myConn.cursor()
        myCursor.execute("SELECT fireSomePlayersFunction(%s);", (maxFired, ))
    except:
        print("Call of fireSomePlayersFunction on", maxFired, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end fireSomePlayers


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    myConn.autocommit = True

    # Perform the calls to teamPlayerCount described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.
    # Test 1 with team name 'Birds'
    print("Count of players on team {} is" .format("Birds"), teamPlayerCount(myConn, 'Birds'))
    # Test 1 with team name 'Skyscrapers'
    print("Count of players on team {} is" .format("Skyscrapers"), teamPlayerCount(myConn, 'Skyscrapers'))


    # Perform the calls to updateTeamCity described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.
    # Test 1 with teamID = 202 and newTeamCity = 'Las Vegas'
    print("Number of teams with teamID {} who moved to city {} is" .format(202, "Las Vegas"), updateTeamCity(myConn, 202, 'Las Vegas'))
    # Test 2 with teamID = 208 and newTeamCity = 'Toronto'
    print("Number of teams with teamID {} who moved to city {} is" .format(208, "Toronto"), updateTeamCity(myConn, 208, 'Toronto'))


    # Test 1 with maxFired = 2
    print("Number of players fired in fireSomePlayers when maxFired equals {} is" .format(2), fireSomePlayers(myConn, 2)) 
    # Test 2 with maxFired = 3
    print("Number of players fired in firedSomePlayers when maxFired equals {} is" .format(3), fireSomePlayers(myConn, 3))
    # Perform the calls to fireSomePlayers described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.

    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
