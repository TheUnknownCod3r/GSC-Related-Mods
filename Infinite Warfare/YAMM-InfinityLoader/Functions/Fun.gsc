/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Fun Modifications for YAMM
*    Date : 21/09/2025 19:45:58
*
*/

ToggleKillAura()
{
    self.killAura = !bool(self.killAura);
    if(self.killAura)
    {
        self iPrintLnAlt("Kill Aura ^2Enabled");
        self thread kill_near_me();
    }
    else
    {
        self iPrintLnAlt("Kill Aura ^1Disabled");
        self notify("End_Kill_Aura");
    }
}

kill_near_me()
{
    self endon("End_Kill_Aura");
    for(;;)
    {
        foreach(zombie in returnZombieTeam())
        {
            if(distancesquared(zombie.origin,self.origin) < 150 * 150)
            {
                if(level.script == "cp_disco"){
                    playfx(level._effect["nunchuck_pap2"],zombie.origin + (0,0,30));
                }
                else{
                    playfx(level._effect["zombie_freeze_shatter"],zombie.origin + (0,0,30));
                }
                zombie DoDamage(zombie.health + 1, self.origin,self,undefined,"MOD_EXPLOSIVE");
            }
        }

        wait .05;
    }
}

TeleToCrosshairLoop()
{
    self.crosshairLoop = isDefined(self.crosshairLoop) ? undefined : true;
    if(isDefined(self.crosshairLoop))
    {
        self thread TeleToMe();
        self iPrintLnAlt("Tele to Crosshair ^2Enabled");
    }
    else{
        self notify("end_crosshairtele");
        self iPrintLnAlt("Tele to Crosshair ^1Disabled");
    }
}

TeleToMe() 
{
    self endon("end_crosshairtele");
    self endon("game_ended");
    for (;;)
    {
        forward = anglesToForward(self.angles); // convert player angles to forward vector

        foreach (zombo in returnZombieTeam()) 
        {
            
            zombo setorigin(self.origin + (forward[0]*70, forward[1]*70, forward[2]*70));
        }

        wait .1;
    }
    wait .1;
}


skyTrip()
{
    self endon("disconnect");
    if(!isDefined(self.skytrip))
    {
        self.skytrip = true;
        if(!self.godmode) self Godmode();
        firstOrigin = self.origin;
        tripShip = modelSpawner(self.origin, "tag_origin");
        self playerLinkTo(tripShip);
        
        tripShip MoveTo(firstOrigin+(0,0,2500),4);
        wait 6;
        tripShip MoveTo(firstOrigin+(0,4800,2500),4);
        wait 6;
        tripShip MoveTo(firstOrigin+(4800,2800,2500),4);
        wait 6;
        tripShip MoveTo(firstOrigin+(-4800,-2800,4500),4);
        wait 6;
        tripShip MoveTo(firstOrigin+(0,0,2500),4);
        wait 6;
        tripShip MoveTo(firstOrigin+(25,25,60),4);
        wait 4;
        tripShip MoveTo(firstOrigin+(0,0,30),1);
        wait 1;
        tripShip delete();
        
        self notify( "reopen_menu" );
        
        self.skytrip = undefined;
    }
    else
    self iPrintlnAlt("Wait For The Current Sky Trip To Finish");
}
 