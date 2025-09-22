/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Gamemodes for YAMM
*    Date : 21/09/2025 19:50:23
*
*/

OldSchoolInit()
{
    self endon("disconnect");
    self endon("game_ended");
    self endon("gameModeChanged");

    foreach(player in level.players)
    {
        player thread menuClose();
        wait .2;
        player thread OldSchoolMonitor();
    }
}

OldSchoolMonitor()
{
    self endon("disconnect");
    self endon("game_ended");
    
    self thread PlayAudioToClients(level.EESong);
    self.hasUnlocked = false;
    self thread welcomeMessage("^4Old School ^3Prestige Lobby", "^5Made By ^6"+level.creatorName);
    wait 2;
    self iPrintLnAlt("^2Get a Kill to get ^2Max Level ^1And ^2All Unlocks");
    for(;;)
    {
        self waittill("zombie_killed");
        if(!self isHost() && self.hasUnlocked == false)
        {
            self.hasUnlocked = true;
            self iPrintLnAlt("Max Level ^2Awarded");
            self setplayerdata("cp","progression","playerLevel", "xp", int( 95297348 ) );
            wait 1;
            self thread CompleteChallenges(self);
            wait 1;
            self thread SoulKeyUnlock(self);
            wait 1;
            self thread SetPlayerMaxWeaponRanks(self);
            wait 1;
            self thread UnlockTalismans(self);
            wait 1;
            self thread UnlockDC(self);
        }
        wait .02;
    }
}

GameModeSwitcher(Val, Func)
{
    wait .2;
    if(Func == "ModMenu"){self thread ModLobbyInit(Val);level notify("gameModeChanged");}
    if(Func == "OldSchool"){ self thread OldSchoolInit(); level notify("gameModeChanged");}
}
ModLobbyInit(Status)
{
    foreach(player in level.players)
    {
        player thread welcomeMessage("^5Welcome To ^6"+level.patchName+"^7, ^4Created by ^5"+level.creatorName, "^2Your Access Level: ^6"+(Status)+" | ^1Enjoy The Lobby!"); 
        level.GameModeSelected=true;
        level thread ClearDoorsAndDebris();
        wait 1;
        level thread TurnOnPower();
        player thread PlayAudioToClients(level.EESong);
        player thread AllPlayersAccess(Status);
    }
}

