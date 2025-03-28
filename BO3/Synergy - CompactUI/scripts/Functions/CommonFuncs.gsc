S(Message)
{
    self iPrintLnBold(Message);
}
P(Message)
{
    self iPrintLn(Message);
}

Godmode()
{
    self.godmode = !bool(self.godmode);
    if(self.godmode){
        self EnableInvulnerability();
        self S("GodMode ^2Enabled");
    }
    else
    {
        self S("GodMode ^1Disabled");
        self DisableInvulnerability();
    }
}

ToggleAmmo()
{
    self endon("stopInfAmmo");
    self endon("game_ended");
    if(!isDefined(self.UnlimAmmo))
    {
        self.UnlimAmmo = true;
        self S("Infinite Ammo ^2Enabled");
    }
    else
    {
        self.UnlimAmmo = undefined;
        self S("Infinite Ammo ^1Disabled");
        self notify("stopInfAmmo");
    }
    while(self.UnlimAmmo == true)
    {
        Clip = self GetCurrentWeapon();
        if(self getWeaponAmmoClip(Clip) < 999){
            self SetWeaponAmmoClip(Clip, 999);
            self SetWeaponAmmoStock(Clip, 999);
            wait .1;
        }
    }
}

KickPlayer(player)
{
    if(self isHost())
    {
        kick(player getEntityNumber());
        self S(player.name+" Was Kicked!");
    }
    else 
    {
        self S("You cannot Kick a Player Unless You are Host!");
    }
}
ThirdPersonToggle()
{
    if(!isDefined(self.ThirdPersonToggle))
    {
        self.ThirdPersonToggle = true;
        self SetClientThirdPerson(1);
        self SetClientThirdPersonAngle(354);
        self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
        self S("Third Person ^2Enabled");
    }
    else{
        self.ThirdPersonToggle = undefined;
        self SetClientThirdPerson(0);
        self SetClientThirdPersonAngle(0);
        self setDepthOfField( 0, 0, 512, 4000, 4, 0 );
        self S("Third Person ^1Disabled");
    }
}



//Music Playing Settings
KillOnAny(Track)
{
    level util::waittill_any("end_game", "disconnect", "sndStateStop", "NewTrack", "EndTrack");
    self StopSounds();
    self StopSound(Track);
    wait 5;
    self Delete();
}

NewTrack(value) {
    if (!isdefined(level.nextTrack))
        level.nextTrack = "";
    if (!isdefined(value) || level.nextTrack == value) {
        level.nextTrack = "none";
        level.musicSystem.currentPlaytype = 0;
        level.musicSystem.currentState = undefined;
        level notify("EndTrack");
        return;
    }
    foreach(i in level.players)
    {
        i P("^1Now Playing: ^2"+value);
    }
    level.nextTrack = value;

    self thread PlayTrackOnPlayers(value);
}

PlayTrackOnPlayers(Track)
{
    level notify("NewTrack");
    #ifdef ZM
    level zm_audio::sndMusicSystem_StopAndFlush();
    #endif

    wait .5;
    self thread PlayTrack(Track);
}

PlayTrack(Track)
{
    level endon("sndStateStop");
    level.musicSystem.currentPlaytype=4;
    level.musicSystem.currentState=Track;
    wait .3;

    music::setmusicstate(Track);
    wait .2;
    ent = spawn("script_origin", self.origin);
    ent thread KillOnAny(Track);
    ent PlaySound(Track);
    playbackTime = soundgetplaybacktime(Track);
    if(!isdefined(playbackTime) || playbackTime <= 0){waitTime = 1;}else{waitTime = playbackTime * 0.001;}
    wait waitTime;
    level.musicSystem.currentPlaytype = 0;
    level.musicSystem.currentState = undefined;
    level notify("EndTrack");
}

playSingleSound(sound, info) {
    self endon("death");
    self endon("disconnect");
    self playSound(sound);
    if (isDefined(info))
        self S(info);
}

welcomeMessage(message, message2) {
    if (isDefined(self.welcomeMessage))
        while (1) {
            wait .05;
            if (!isDefined(self.welcomeMessage))
                break;
        }
    self.welcomeMessage = true;

    hud = [];
    hud[0] = self createText("default", 1.35, "CENTER", "CENTER", -500, -140 + 60, 10, 1, message);
    hud[1] = self createText("default", 1.35, "CENTER", "CENTER", 500, -120 + 60, 10, 1, message2);

    hud[0] thread hudMoveX(-25, .35);
    hud[1] thread hudMoveX(25, .35);
    wait .35;

    hud[0] thread hudMoveX(25, 3);
    hud[1] thread hudMoveX(-25, 3);
    wait 3;

    hud[0] thread hudMoveX(500, .35);
    hud[1] thread hudMoveX(-500, .35);
    wait .35;

    self destroyAll(hud);
    self.welcomeMessage = undefined;
}

PrintMenuControls()
{
    self endon("disconnect");
    self endon("game_ended");
    info = [];
    info[0]="Synergy V3 Client Edition";
    info[1] = "Press [{+speed_throw}] & [{+Melee}] To Open";
    info[2] = "Press [{+Attack}] & [{+speed_throw}] to Scroll";
    info[3] = "Press [{+Usereload}] to Select, [{+Melee}] to Go Back";
    info[4] = "For Rank Sliders, Use [{+ActionSlot 4}] and [{+ActionSlot 3}] To Scroll";
    for(;;)
    {
        for(i=0;i<5;i++)
        {
            self P(info[i]);
            wait 5;
        }
        wait .2;
    }
}

AllPerkToggle() {
    if(!isDefined(self.HasAllPerks))
    {
        #ifdef ZM
        self thread GiveAllPerksZM();
        #endif
        #ifdef MP
        MPPerks = StrTok("specialty_additionalprimaryweapon;specialty_armorpiercing;specialty_armorvest;specialty_bulletaccuracy;specialty_bulletdamage;specialty_bulletflinch;specialty_bulletpenetration;specialty_deadshot;specialty_delayexplosive;specialty_detectexplosive;specialty_disarmexplosive;specialty_earnmoremomentum;specialty_explosivedamage;specialty_extraammo;specialty_fallheight;specialty_fastads;specialty_fastequipmentuse;specialty_fastladderclimb;specialty_fastmantle;specialty_fastmeleerecovery;specialty_fastreload;specialty_fasttoss;specialty_fastweaponswitch;specialty_finalstand;specialty_fireproof;specialty_flakjacket;specialty_flashprotection;specialty_gpsjammer;specialty_grenadepulldeath;specialty_healthregen;specialty_holdbreath;specialty_immunecounteruav;specialty_immuneemp;specialty_immunemms;specialty_immunenvthermal;specialty_immunerangefinder;specialty_killstreak;specialty_longersprint;specialty_loudenemies;specialty_marksman;specialty_movefaster;specialty_nomotionsensor;specialty_noname;specialty_nottargetedbyairsupport;specialty_nokillstreakreticle;specialty_nottargettedbysentry;specialty_pin_back;specialty_pistoldeath;specialty_proximityprotection;specialty_quickrevive;specialty_quieter;specialty_reconnaissance;specialty_rof;specialty_scavenger;specialty_showenemyequipment;specialty_stunprotection;specialty_shellshock;specialty_sprintrecovery;specialty_showonradar;specialty_stalker;specialty_twogrenades;specialty_twoprimaries;specialty_unlimitedsprint", ";");
        foreach(Perk in MPPerks)
            self setperk(Perk);
        self S("All Perks ^2Given");
        #endif
        self.HasAllPerks=true;
    }
    else
    {
        #ifdef ZM
        foreach(Perk in level._SynPerks)
        {
            self unsetPerk(Perk);
            self notify(Perk + "_stop");
            wait .1;
        }
        #endif
        #ifdef MP
        MPPerks = StrTok("specialty_additionalprimaryweapon;specialty_armorpiercing;specialty_armorvest;specialty_bulletaccuracy;specialty_bulletdamage;specialty_bulletflinch;specialty_bulletpenetration;specialty_deadshot;specialty_delayexplosive;specialty_detectexplosive;specialty_disarmexplosive;specialty_earnmoremomentum;specialty_explosivedamage;specialty_extraammo;specialty_fallheight;specialty_fastads;specialty_fastequipmentuse;specialty_fastladderclimb;specialty_fastmantle;specialty_fastmeleerecovery;specialty_fastreload;specialty_fasttoss;specialty_fastweaponswitch;specialty_finalstand;specialty_fireproof;specialty_flakjacket;specialty_flashprotection;specialty_gpsjammer;specialty_grenadepulldeath;specialty_healthregen;specialty_holdbreath;specialty_immunecounteruav;specialty_immuneemp;specialty_immunemms;specialty_immunenvthermal;specialty_immunerangefinder;specialty_killstreak;specialty_longersprint;specialty_loudenemies;specialty_marksman;specialty_movefaster;specialty_nomotionsensor;specialty_noname;specialty_nottargetedbyairsupport;specialty_nokillstreakreticle;specialty_nottargettedbysentry;specialty_pin_back;specialty_pistoldeath;specialty_proximityprotection;specialty_quickrevive;specialty_quieter;specialty_reconnaissance;specialty_rof;specialty_scavenger;specialty_showenemyequipment;specialty_stunprotection;specialty_shellshock;specialty_sprintrecovery;specialty_showonradar;specialty_stalker;specialty_twogrenades;specialty_twoprimaries;specialty_unlimitedsprint", ";");
        foreach(Perk in MPPerks)
            self unsetPerk(Perk);
        #endif
        self S("All Perks ^1Removed");
        self.HasAllPerks=undefined;
    }
}

test()
{
    self S("Testing 123");
}

TestInt(Val)
{
    self S("Int Slider Value: "+Val);
}

GameModeSwitcher(Val, Func)
{
    wait .2;
    if(Func == "ModMenu"){self thread ModLobbyInit(Val);}
    #ifdef MP
    else if (Func == "All Or Nothing"){level notify("gameModeChanged"); wait .2; self thread AoNInit();}
    else if (Func == "Quickscoping"){level notify("gameModeChanged"); wait .2; self thread QSInit();}
    #endif
    #ifdef ZM
    else if(Func == "OldSchool"){ self thread OldSchoolInit(); level notify("gameModeChanged");}
    else if(Func == "GunGame"){ level notify("gameModeChanged"); self thread GunGameInit(); }
    #endif
}

ModLobbyInit(Status)
{
    foreach(player in level.players)
    {
        player thread welcomeMessage("Welcome To Synergy V3 | Made By MrFawkes1337", "Your Access Level: "+(Status)+" | Enjoy The Lobby!"); 
        level.GameModeSelected=true;
        player thread AllPlayersAccess(Status);
    }
}

CurrencyLoop()
{
    self endon("StopCurrency");
    if(!isDefined(self.CurrencyLoop))
    {
        self.CurrencyLoop = true;
        self S("Currency Loop Enabled");
    }
    else
    {
        self.CurrencyLoop = undefined;
        self notify("StopCurrency");
        self S("Currency Loop Stopped");
    }
    while(self.CurrencyLoop)
    {
        self GiveLoot(self, !SessionModeIsMultiplayerGame(), SessionModeIsMultiplayerGame() ? 40 : 250);
        wait 1;
    }
}

GiveLoot(player, IsVials = false, amount)
{
    if(!isdefined(player) || !isplayer(player)) return;
    
    if(!isdefined(player.CurrencyAwarded))
        player.CurrencyAwarded = 0;
    
    IsVials = int(IsVials);
    IsVials = isdefined(IsVials) && IsVials;
    
    amount = int(amount);
    if(!isdefined(amount)) amount = 1;
    baseAmount = amount;
    if(!isVials) amount *= 100;
    uploadstats(player);
    
    player.CurrencyAwarded += baseAmount;
    self S("Awarded ^2" + baseAmount + " ^7Currency (^2" + player.CurrencyAwarded + " ^7Total)");
    level.players[0] P(player.name+"Now Has: "+player.CurrencyAwarded+" Currency");
    wait .1;
}

FastEndGame()
{
    #ifdef MP
    level.roundLimit = 1;
    level.skipGameEnd = true;
    winner = globallogic_score::getHighestScoringPlayer();
    globallogic::endGame(winner, &"MP_ENDED_GAME");
    foreach(player in level.players)
        player S(level.hostname+" ^1Ended the Game.");
    #endif
    #ifdef ZM
    level notify("end_game");
    foreach(client in level.players) client S("^2Sorry, "+level.hostname+" Ended The Game");
    #endif
}


ChangeTheme(which)
{
    switch(which)
    {
        case 0: if(self.menu["Theme"]["Default"] == true) {self S("Theme is Already Synergy V3"); return;} self menuClose(); wait .2; self.menu["Theme"]["Default"] = true; self.menu["Theme"]["Flex"]=false; self thread menuOpen(); wait .1; self S("Menu Theme Changed To: Synergy V3"); break;
        case 1: if(self.menu["Theme"]["Flex"] == true) {self S("Theme is Already Physics N Flex"); return;} self menuClose(); wait .2; self.menu["Theme"]["Default"] = false; self.menu["Theme"]["Flex"] = true; self thread menuOpen(); wait .1; self S("Menu Theme Changed To: Physics N Flex"); break;
    }
}
ToggleForceHost()
{
    if(!isDefined(self.ForcingHost))
    {
        SetDvar("lobbySearchListenCountries", "0,103,6,5,8,13,16,23,25,32,34,24,37,42,44,50,71,74,76,75,82,84,88,31,90,18,35");
        SetDvar("excellentPing", 3);
        SetDvar("goodPing", 4);
        SetDvar("terriblePing", 5);
        SetDvar("migration_forceHost", 1);
        SetDvar("migration_minclientcount", 12);
        SetDvar("party_connectToOthers", 0);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 12);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 0);
        SetDvar("party_neverJoinRecent", 1);
        SetDvar("party_readyPercentRequired", .25);
        SetDvar("partyMigrate_disabled", 1);
        self.ForcingHost=true;
        self S("Force Host ^2Enabled");
    }
    else
    {
        SetDvar("lobbySearchListenCountries", "");
        SetDvar("excellentPing", 30);
        SetDvar("goodPing", 100);
        SetDvar("terriblePing", 500);
        SetDvar("migration_forceHost", 0);
        SetDvar("migration_minclientcount", 2);
        SetDvar("party_connectToOthers", 1);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 2);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 1);
        SetDvar("party_neverJoinRecent", 0);
        SetDvar("partyMigrate_disabled", 0);
        self.ForcingHost=undefined;
        self S("Force Host ^1Disabled");
    }
}

ExecuteClient(player)
{
    if(isDefined(player.godmode))
        player thread Godmode();
    wait .1;
    #ifdef ZM
    player notify("player_suicide");
    player zm_laststand::bleed_out();
    #endif
    #ifdef MP
    player suicide();
    #endif
    self S("Killed "+player.name);
    player S("You Just got murdered By: "+self.name);
}

FastRestartGame()
{
    map_restart(0);
}


CustomMessage()
{
    self thread menuClose();
    String = CustomKeyboard("Custom Message");
    wait .2;
    self thread TypeWriter(String);
    self thread S(String);
}

PrintMapName()
{
    self S(GetTehMap());
}