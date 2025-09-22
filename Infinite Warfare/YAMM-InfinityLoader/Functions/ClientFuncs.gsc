/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : An empty canvas for anything you want!
*    Date : 13/09/2025 01:24:05
*
*/


ClientHandler(func, player)
{
    switch(func)
    {
        case 1 : player thread Godmode(); break;
        case 2 : player thread no_clip(); break;
        case 3 : player thread ToggleAmmo(); break;
        case 4 : player thread MaxScore(player); break;
        case 5 : player setOrigin(level.jailPos); player iPrintLnAlt("You have been sent to ^1JAIL"); break;
        case 6 : player setOrigin(level.freePos); player iPrintLnAlt("You have been set free from ^2Jail"); break;
        case 7 : player thread AllPerks(); break;
        case 8 : player thread ToggleKillAura(); break;
    }
    wait .05;
}

AllClientHandler(state)
{
    foreach(client in level.players)
    {
        if(client isHost()){}//don't activate for the host
        else
        switch(state)
        {
            case 1 : client thread Godmode(); break;
            case 2 : client thread no_clip(); break;
            case 3 : client thread ToggleAmmo(); break;
            case 4 : client thread MaxScore(client); break;
            case 5 : client thread AllPerks(); break;
            case 6 : client thread ToggleKillAura(); break;
            case 7 : client setOrigin(level.jailPos); client iPrintLnAlt("^1You have been sent to JAIL"); break;
            case 8 : client setOrigin(level.freePos); client iPrintLnAlt("^2You have been set free from JAIL"); break;
        }
        wait .05;
    }
}

ClientMessages(which)
{
    foreach(player in level.players)
    switch(which)
    {
        case 1 : player thread WelcomeMessage("^1Your Modded Lobby ^3is Hosted By: ^6"+level.hostname, "^2Patch Created By: ^6"+level.creatorName); break;
        case 2 : player thread WelcomeMessage("^5If you want ^2Unlock All, ^5Ask for it!", "^1"+level.hostname+" ^4Will Not Mod your rank ^1without permission"); break;
        case 3 : player thread WelcomeMessage("^1Yes, ^2I ^4can give ^6Directors Cut", "^1I ^2cannot ^4give ^6Keys, or Salvage"); break;
        case 4 : player thread WelcomeMessage("^3To get a ^1MOD MENU ^3like this","^6Purchase ^3INFINITY ^6LOADER"); break;
        case 5 : player thread WelcomeMessage("^4Cold War ^1Mod Menu ^4on Github","^5BO4 ^2Mod Menu ^5On Github"); player iPrintLnAlt("^5https://www.github.com/theunknowncod3r");break;
    }
}