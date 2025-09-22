/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Host only stuff for YAMM
*    Date : 21/09/2025 19:51:10
*
*/

EndGameHost()
{
    foreach(client in level.players) client iPrintLnAlt("^2Sorry, "+self.name+" Ended The Game");
    level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
}


StartLobbyTimer()
{
    if(!isDefined(level.TimerTime))
    {
        self iPrintLnAlt("You need to set the Timer First");
        return;
    }
    if(isDefined(level.lobbyTimerSet))
    {
        self iPrintLnAlt("Error: The Lobby Timer is already enabled");
    }
    if(!isDefined(level.lobbyTimerSet))
    {
        level.lobbyTimerSet = true;
        level.TimerSet      = true;
        timer               = self createTextWelcome("small",1.5,"left","bottom",0,0,1,1,"Lobby Ends In:",level.rainbowColour);
        timer2              = self createTextWelcome("small",1.5,"left","bottom",105,0,1,1,undefined, level.rainbowColour);
        timer2 setTimer(level.TimerTime * 60);
        wait level.TimerTime * 60;
        timer destroy();
        timer2 destroy();
        EndGameHost();
    }
}

setLobbyTimer(time)
{
    level.TimerTime = time;
    self iPrintLnAlt("Timer Set To: "+time+" Minutes");
}

FastRestartGame()
{
    map_restart(0);
}


PrintCoords()
{
    self iPrintLnAlt("Current Coords: "+self.origin);
}

   
SetXPScale(scale)
{
    self.var_13E26 = scale;
    self.var_13C37 = scale;
    self iPrintLnAlt("XP Scale Set To: "+scale);
}
