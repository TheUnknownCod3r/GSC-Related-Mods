/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Zombies related functions
*    Date : 21/09/2025 19:42:15
*
*/

oneShotKillZombies()
{
    if( !isDefined( self.oneShotKillZombies ) )
    {
        self.oneShotKillZombies = true;
        while( isDefined( self.oneShotKillZombies ) )
        {
            foreach( zom in returnZombieTeam() )
            {
                zom.maxhealth = 1;
                zom.health    = zom.maxhealth;
            }
            wait 0.01;
        }
    }
    else 
    {
        self.oneShotKillZombies = undefined;
    }
}

killAllZombies()
{
    level notify("next_wave_notify");
    zombies = scripts\cp\_agent_utils::func_7DB0("axis");
    if(isdefined(zombies))
    {
        for(i = 0; i < zombies.size; i++)
            zombies[i] DoDamage(zombies[i].health + 1, zombies[i].origin);
        wait 1;
    }
    self iPrintLnAlt("All Zombies ^2Killed");
}

returnZombieTeam()
{
    return scripts\mp\_mp_agent::func_7DB0("axis");
}

freezeZombies()
{
    if( !isDefined( self.freezeZombies ) )
    {
        self.freezeZombies = true;
        while( isDefined( self.freezeZombies ) )
        {
            foreach( zom in returnZombieTeam() )
            {
                zom freezecontrols(true);
            }
            wait 0.01;
        }
    }
    else 
    {
        self.freezeZombies = undefined;
        foreach( zom in returnZombieTeam() )
        {
            zom freezecontrols(false);
        }
    }
}

teleportZombiesToMe()
{
    foreach( zom in returnZombieTeam() )
    {
        zom setorigin( self.origin + ( 20, 20, 20 ) );
    }
}

outline_zombies() 
{
    self.outline_zombies = !bool(self.outline_zombies);
    if(self.outline_zombies) {
        self iPrintlnAlt("Zombie Outlines [^2ON^7]");
        outline_zombies_loop();
    } else {
    self iPrintLnAlt("Zombie Outlines [^1OFF^7]");
        self notify("stop_outline_zombies");
        foreach(zombie in returnZombieTeam()) {
            scripts\cp\_outline::func_6221(zombie, level.players);
        }
    }
}

outline_zombies_loop() 
{
    self endOn("stop_outline_zombies");
    self endOn("game_ended");
    
    if(!isDefined(self.outline_color)) {
        self.outline_color = 1;
    }
    
    for(;;) {
        foreach(zombie in returnZombieTeam()) {
            scripts\cp\_outline::func_6221(zombie, level.players, self.outline_color, 0, 0, "high");
        }
        wait 0.2;
    }
}

set_outline_color(value)
{
    self.outline_color = value;
}

ChangeOutlineColor(value)
{
    self notify("stop_rainbowOut");
    wait .1;
    self set_outline_color(value);
}

RainbowOutlines()
{
    self endon("stop_rainbowOut");
    self endon("game_ended");
    self endon("stop_outline_zombies");
    
    for(;;)
    {
        self set_outline_color(0);
        wait 1;
        self set_outline_color(1);
        wait 1;
        self set_outline_color(2);
        wait 1;
        self set_outline_color(3);
        wait 1;
        self set_outline_color(4);
        wait 1;
        self set_outline_color(5);
        wait 1;
    }
}

