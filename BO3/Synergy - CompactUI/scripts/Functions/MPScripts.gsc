#ifdef MP
/*
##################################################################
##          All Or Nothing And Quickscope Related Code          ##
##             Coded By MrFawkes1337 for Synergy V3             ##
##################################################################
*/
AoNInit()
{
    self endon("disconnect");
    level endon("gameModeChanged");

    level.AoNWeapon = "pistol_burst";
    self thread AoNConnInit();
}

AoNConnInit()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    level endon("game_ended");

    foreach(player in level.players)
    {
        player suicide();
        wait .1;
        player thread AoNSpawn();
        level.loadoutkillstreaksenabled = 0;
        level.disableweapondrop = 1;
    }
}

AoNSpawn()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    level endon("game_ended");

    InitialSpawn=true;

    for(;;)
    {
        self waittill("spawned_player");
        self thread AoNMonitor();
        self takeAllWeapons();
        wait 1;
        self GiveWeapon(GetWeapon(level.AoNWeapon));
        self SwitchToWeaponImmediate(GetWeapon(level.AoNWeapon));
        self thread AoNKillMonitor();
        self.pers["kills"] = 0;
        if(InitialSpawn){
            self thread welcomeMessage("^4Welcome "+self.name+" ^3To ^2All ^5Or ^1Nothing", "^6Custom Gamemode ^3By: ^4MrFawkes621337");
            self.InitialSpawn=false;
        }
    }
}

AoNMonitor()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    level endon("game_ended");
    self endon("death");

    wait .5;

    self setPerk("specialty_longersprint");
    self setPerk("specialty_fastreload");
    self setPerk("specialty_movefaster");

    self thread AoNKillstreakMonitor();
    wait .1;

    while(self GetCurrentWeapon() != GetWeapon(level.AoNWeapon))
    {
        self switchToWeaponImmediate(GetWeapon(level.AoNWeapon));
        wait .01;
    }
    self.maxhealth=100;
    self.health=self.maxhealth;
}

AoNKillMonitor()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    level endon("game_ended");
    self endon("death");

    self.OldKillCount = self.pers["kills"];
    for(;;)
    {
        if(self.OldKillCount < self.pers["kills"])
        {
            self.OldKillCount=self.pers["kills"];
            self thread AoNKillstreakMonitor();
        }
        wait .1;
    }
}

AoNKillstreakMonitor()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    level endon("game_ended");
    self endon("death");
    self endon("kills");

    for(;;)
    {
        if(self.pers["kills"] == 1)
        {
            self S("You just Unlocked ^2Scavenger!");
            self setPerk("specialty_scavenger");
            self notify("kills");
        }
        if(self.pers["kills"] == 3)
        {
            self S("You Just Unlocked ^2Fast Hands");
            self setPerk("specialty_sprintfire");
            self setPerk("specialty_fastweaponswitch");
            self notify("kills");
        }
        if(self.pers["kills"] == 5)
        {
            self S("You just Unlocked ^2Sixth Sense and Tracker");
            self setPerk("specialty_stalker");
            self setPerk("specialty_showonradar");
            self notify("kills");
        }
        if(self.pers["kills"] == 7)
        {
            self S("You Just Unlocked ^2All Perks");
            self setperk("specialty_additionalprimaryweapon");
            self setperk("specialty_armorpiercing");
            self setperk("specialty_armorvest");
            self setperk("specialty_bulletaccuracy");
            self setperk("specialty_bulletdamage");
            self setperk("specialty_bulletflinch");
            self setperk("specialty_bulletpenetration");
            self setperk("specialty_deadshot");
            self setperk("specialty_delayexplosive");
            self setperk("specialty_detectexplosive");
            self setperk("specialty_disarmexplosive");
            self setperk("specialty_earnmoremomentum");
            self setperk("specialty_explosivedamage");
            self setperk("specialty_extraammo");
            self setperk("specialty_fallheight");
            self setperk("specialty_fastads");
            self setperk("specialty_fastequipmentuse");
            self setperk("specialty_fastladderclimb");
            self setperk("specialty_fastmantle");
            self setperk("specialty_fastmeleerecovery");
            self setperk("specialty_fastreload");
            self setperk("specialty_fasttoss");
            self setperk("specialty_fastweaponswitch");
            self setperk("specialty_finalstand");
            self setperk("specialty_fireproof");
            self setperk("specialty_flakjacket");
            self setperk("specialty_flashprotection");
            self setperk("specialty_gpsjammer");
            self setperk("specialty_grenadepulldeath");
            self setperk("specialty_healthregen");
            self setperk("specialty_holdbreath");
            self setperk("specialty_immunecounteruav");
            self setperk("specialty_immuneemp");
            self setperk("specialty_immunemms");
            self setperk("specialty_immunenvthermal");
            self setperk("specialty_immunerangefinder");
            self setperk("specialty_killstreak");
            self setperk("specialty_longersprint");
            self setperk("specialty_loudenemies");
            self setperk("specialty_marksman");
            self setperk("specialty_movefaster");
            self setperk("specialty_nomotionsensor");
            self setperk("specialty_noname");
            self setperk("specialty_nottargetedbyairsupport");
            self setperk("specialty_nokillstreakreticle");
            self setperk("specialty_nottargettedbysentry");
            self setperk("specialty_pin_back");
            self setperk("specialty_pistoldeath");
            self setperk("specialty_proximityprotection");
            self setperk("specialty_quickrevive");
            self setperk("specialty_quieter");
            self setperk("specialty_reconnaissance");
            self setperk("specialty_rof");
            self setperk("specialty_scavenger");
            self setperk("specialty_showenemyequipment");
            self setperk("specialty_stunprotection");
            self setperk("specialty_shellshock");
            self setperk("specialty_sprintrecovery");
            self setperk("specialty_showonradar");
            self setperk("specialty_stalker");
            self setperk("specialty_twogrenades");
            self setperk("specialty_twoprimaries");
            self setperk("specialty_unlimitedsprint");
            self notify("kills");
        }
        wait .05;
    }
}

GetTehMap()
{
    if(level.script == "mp_veiled") return "Veiled";
    else if(level.script == "mp_stronghold") return "Stronghold";
    else if(level.script == "mp_spire") return "Spire";
    else if(level.script == "mp_sector") return "Sector";
    else if(level.script == "mp_redwood") return "Redwood";
    else if(level.script == "mp_metro") return "Metro";
    else if(level.script == "mp_infection") return "Infection";
    else if(level.script == "mp_havoc") return "Havoc";
    else if(level.script == "mp_ethiopia") return "Hunted";
    else if(level.script == "mp_chinatown") return "Chinatown";
    else if(level.script == "mp_biodome") return "Biodome";
    else if(level.script == "mp_apartments") return "Apartments";
    else if(level.script == "mp_nuketown_x") return "Nuketown";
    else if(level.script == "mp_airship") return "Skyjacked";
    else return "none";
}

QSInit()
{
    self endon("disconnect");
    level endon("gameModeChanged");

    level.QSWeapon1="sniper_fastbolt";
    level.QSWeapon2="knife_loadout";
    level.QSHatchet="hatchet";
    level.loadoutkillstreaksenabled = 0;
    wait 2;
    foreach (player in level.players)
    {
        player thread QuickscopeInit();
        player Suicide();
        wait 2;
    }

}

QuickscopeInit()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    self endon("game_ended");

    InitialSpawn=true;
    level.disableweapondrop = 1;
    for(;;)
    {
        self waittill("spawned_player");
        self TakeAllWeapons();
        wait .5;
        self GiveWeapon(GetWeapon(level.QSWeapon1), self CalcWeaponOptions( 12, 1, 0), 0 );
        self SwitchToWeaponImmediate(GetWeapon(level.QSWeapon1));
        wait .1;
        self GiveWeapon(GetWeapon(level.QSWeapon2));
        wait .05;
        self GiveWeapon(GetWeapon(level.QSHatchet));
        self SetWeaponAmmoStock(level.QSHatchet, 2);
        self SetWeaponAmmoClip(level.QSHatchet, 2);//may not work was added and not tested. Remove if you crash on two errors you numb fuck
        self.maxhealth =30;
        self.health = self.maxhealth;
        if(InitialSpawn)
        {
            InitialSpawn=false;
            self thread welcomeMessage("^2Welcome to ^1Synergy's ^5Quickscoping ^4Lobby!", "^6Made By ^3Mr^5Faw^2k^1e^4s^51337");
        }
        self thread MonitorForQS();

        self ClearPerks();
        wait .2;
        self setperk("specialty_additionalprimaryweapon");
            self setperk("specialty_armorpiercing");
            self setperk("specialty_armorvest");
            self setperk("specialty_bulletaccuracy");
            self setperk("specialty_bulletdamage");
            self setperk("specialty_bulletflinch");
            self setperk("specialty_bulletpenetration");
            self setperk("specialty_deadshot");
            self setperk("specialty_delayexplosive");
            self setperk("specialty_detectexplosive");
            self setperk("specialty_disarmexplosive");
            self setperk("specialty_earnmoremomentum");
            self setperk("specialty_explosivedamage");
            self setperk("specialty_extraammo");
            self setperk("specialty_fallheight");
            self setperk("specialty_fastads");
            self setperk("specialty_fastequipmentuse");
            self setperk("specialty_fastladderclimb");
            self setperk("specialty_fastmantle");
            self setperk("specialty_fastmeleerecovery");
            self setperk("specialty_fastreload");
            self setperk("specialty_fasttoss");
            self setperk("specialty_fastweaponswitch");
            self setperk("specialty_finalstand");
            self setperk("specialty_fireproof");
            self setperk("specialty_flakjacket");
            self setperk("specialty_flashprotection");
            self setperk("specialty_gpsjammer");
            self setperk("specialty_grenadepulldeath");
            self setperk("specialty_healthregen");
            self setperk("specialty_holdbreath");
            self setperk("specialty_immunecounteruav");
            self setperk("specialty_immuneemp");
            self setperk("specialty_immunemms");
            self setperk("specialty_immunenvthermal");
            self setperk("specialty_immunerangefinder");
            self setperk("specialty_killstreak");
            self setperk("specialty_longersprint");
            self setperk("specialty_loudenemies");
            self setperk("specialty_marksman");
            self setperk("specialty_movefaster");
            self setperk("specialty_nomotionsensor");
            self setperk("specialty_noname");
            self setperk("specialty_nottargetedbyairsupport");
            self setperk("specialty_nokillstreakreticle");
            self setperk("specialty_nottargettedbysentry");
            self setperk("specialty_pin_back");
            self setperk("specialty_pistoldeath");
            self setperk("specialty_proximityprotection");
            self setperk("specialty_quickrevive");
            self setperk("specialty_quieter");
            self setperk("specialty_reconnaissance");
            self setperk("specialty_rof");
            self setperk("specialty_scavenger");
            self setperk("specialty_showenemyequipment");
            self setperk("specialty_stunprotection");
            self setperk("specialty_shellshock");
            self setperk("specialty_sprintrecovery");
            self setperk("specialty_showonradar");
            self setperk("specialty_stalker");
            self setperk("specialty_twogrenades");
            self setperk("specialty_twoprimaries");
            self setperk("specialty_unlimitedsprint");
        
    }
}

MonitorForQS()
{
    self endon("disconnect");
    level endon("gameModeChanged");
    self endon("death");
    self endon("game_ended");

    for(;;)
    {
        if(self meleeButtonPressed())
        {
            self S("^5Knifing ^4Is ^1Disabled!!");
            wait .025;
        }
        if(self adsButtonPressed())
        {
            wait .4;
            self allowAds(0);
            wait .4;
            self allowAds(1);
        }
        wait 0.05;
    }
}

//maybe do cranked tomorrow??
/*
###########################################
##          GAMEMODE CODE ENDED          ##
###########################################
*/

toggleUAV()
{
    self.AdvancedUAV = !bool(self.AdvancedUAV);
    self S("Advanced UAV " + (!self.AdvancedUAV ? "^1OFF" : "^2ON") );
    self setclientuivisibilityflag("g_compassShowEnemies", (self.AdvancedUAV ? 1 : 0));
}
#endif