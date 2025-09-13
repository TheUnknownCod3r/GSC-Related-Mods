/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : test3
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Starts Zombies code execution!
*    Date : 13/11/2024 01:35:11
*
*/
#include common_scripts\utility;
#include scripts\cp\zombies\direct_boss_fight;
#include scripts\cp\zombies\zombie_jukebox;
#include scripts\cp\_persistence;
//Preprocessor definition chaining

init()
{
    level thread InitializeMenu();
    level thread onPlayerConnect();
    level.mapName = level.script;
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if( !isdefined( level.patchCallback ) ) {
            level.patchCallback = true;
            level patchCallback();
        }
        setDvar("sv_cheats", 1);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(isDefined(self.playerSpawned))
            continue;
        self.playerSpawned = true;
        if(!isDefined(level.initial_setup)) {
            level.initial_setup = true;
        }
        wait 2;
        if(self isHost())
        {
            level.hostname  = self.name;
            self freezeControls(false);
            self thread initializeSetup(5, self);
            self thread welcomeMessage("^4Welcome ^2"+self.name+" ^7to ^5"+level.patchName, "^4Your Access Level: ^2"+GetAccessName(self.access)+"^7, ^1Created by: ^5"+level.creatorName);
            wait 3;
        }
        else { self.access = 0;}
        level thread RainbowColor();
    }
}
patchCallback() {
    level.callback_player_damage_stub    = level.callbackplayerdamage;
    level.callbackplayerdamage           = ::callback_player_damage_stub;
    level.callback_player_killed_stub    = level.callbackplayerkilled;
    level.callbackplayerkilled           = ::callback_player_killed_stub;
    level.callback_player_laststand_stub = level.callbackplayerlaststand;
    level.callbackplayerlaststand        = ::callback_player_laststand_stub;
}


callback_player_damage_stub( inflictor, attacker, damage, flag, death_cause, weapon, point, direction, hit_location, time_offset ) {
    if( bool( self.godmode ) )
        return;
    
    [[ level.callback_player_damage_stub ]]( inflictor, attacker, damage, flag, death_cause, weapon, point, direction, hit_location, time_offset );
}


callback_player_killed_stub( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration ) {
    [[ level.callback_player_killed_stub ]]( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration );
}

callback_player_laststand_stub( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration ) {
    self notify( "player_downed" );
    [[ level.callback_player_laststand_stub ]]( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration );
}

InitializeMenu()
{
    level.Status           = ["^1Unverified", "^3Verified", "^4VIP", "^6Admin", "^5Co-Host", "^2Host"];
    level.RGB              = ["Red", "Green", "Blue"];
    level.patchName        = "YetAnotherModMenu";
    level.creatorName      = "TheUnknownCoder";
    level.TimerTime        = "Not Set";
    level.WeaponCategories = ["Assault Rifles", "Sub Machine Guns", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Classic Weapons", "Melee Weapons", "Specialist Weapons", "Map Specific Weapons", "Other Weapons"];
    level.Assault          = ["iw7_m4_zm", "iw7_sdfar_zm", "iw7_ar57_zm", "iw7_fmg_zm+akimbofmg_zm", "iw7_ake_zmr", "iw7_rvn_zm+meleervn", "iw7_vr_zm", "iw7_gauss_zm", "iw7_erad_zm"];
    level.SMG              = ["iw7_fhr_zm", "iw7_crb_zml+crblscope_camo", "iw7_ripper_zmr", "iw7_ump45_zml+ump45lscope_camo", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_tacburst_zm+gltacburst"];
    level.LMG              = ["iw7_sdflmg_zm", "iw7_mauler_zm", "iw7_lmg03_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm"];
    level.Snipers          = ["iw7_kbs_zm", "iw7_m8_zm", "iw7_cheytac_zmr", "iw7_m1_zm", "iw7_ba50cal_zm", "iw7_longshot_zm+longshotlscope_zm"];
    level.Shotguns         = ["iw7_devastator_zm", "iw7_sonic_zmr", "iw7_sdfshotty_zm+sdfshottyscope_camo", "iw7_spas_zmr", "iw7_mod2187_zm"];
    level.Pistols          = ["iw7_emc_zm", "iw7_nrg_zm", "iw7_g18_zmr", "iw7_revolver_zm", "iw7_udm45_zm+udm45scope", "iw7_mag_zm"];
    level.Launchers        = ["iw7_lockon_zm", "iw7_glprox_zm", "iw7_chargeshot_zm+chargeshotscope_camo"];
    level.Classics         = ["iw7_m1c_zm", "iw7_g18c_zm", "iw7_ump45c_zm", "iw7_spasc_zm", "iw7_arclassic_zm", "iw7_cheytacc_zm"];
    level.Melee            = ["iw7_axe_zm"];
    level.Specials         = ["iw7_atomizer_mp", "iw7_penetrationrail_mp+penetrationrailscope", "iw7_steeldragon_mp", "iw7_claw_mp", "iw7_blackholegun_mp+blackholegunscope"];
    level.ARNames          = ["NV4", "R3K", "KBAR-32", "Type-2", "Volk", "R-VN", "X-Con", "G-Rail", "Erad"];
    level.SMGNames         = ["FHR-40", "Karma-45", "RPR Evo", "HVR", "VPR", "Trencher", "Raijin-EMX"];
    level.LMGNames         = ["R.A.W.", "Mauler", "Titan", "Auger", "Atlas"];
    level.SniperNames      = ["KBS Longbow", "EBR-800", "Widowmaker", "DMR-1", "Trek-50", "Proteus"];
    level.ShotgunNames     = ["Reaver", "Banshee", "DCM-8", "Rack-9", "M.2187"];
    level.PistolNames      = ["EMC", "Oni", "Kendall 44", "Hailstorm", "UDM", "Stallion 44"];
    level.LauncherNames    = ["Spartan SA3", "Howitzer", "P-Law"];
    level.ClassicNames     = ["M1", "Hornet", "MacTav-45", "S-Ravage", "OSA", "TF-141"];
    level.MeleeNames       = ["Axe"];
    level.SpecialNames     = ["Eraser", "Ballista EM3", "Steel Dragon", "Claw", "Gravity Vortex Gun", "Arm-2 Akimbo", "Turdlet"];
    level.SpacelandWeaps   = ["iw7_forgefreeze_zm+forgefreezealtfire", "iw7_dischord_zm", "iw7_facemelter_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_spaceland_wmd"];
    level.SpacelandNames   = ["Forge Freeze", "Dischord", "Face Melter", "Head Cutter", "Shredder", "NX 2.0"];
    level.RaveWeaps        = ["iw7_golf_club_mp", "iw7_spiked_bat_mp", "iw7_two_headed_axe_mp", "iw7_machete_mp", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm+akimbo", "iw7_harpoon4_zm"];
    level.RaveNames        = ["Golf Club", "Spiked Bat", "2 Headed Axe", "Machete", "Acid Rain", "Ben Franklin", "Trap o Matic", "Whirlwind EF5"];
    level.ShaolinWeaps     = ["iw7_katana_zm", "iw7_nunchucks_zm", "iw7_fists_zm_crane", "iw7_fists_zm_snake", "iw7_fists_zm_dragon", "iw7_fists_zm_tiger", "iw7_fists_zm_monkey"];
    level.ShaolinNames     = ["Katana", "Nunchucks", "Crane Chi", "Snake Chi", "Dragon Chi", "Tiger Chi", "Monkey Chi"];
    level.AttackWeaps      = ["iw7_cutie_zm", "iw7_knife_zm_crowbar","iw7_fists_zm_cleaver"];
    level.AttackNames      = ["Modular Atomic Disintegrator", "Crowbar", "Cleaver"];
    level.BeastWeaps       = ["iw7_venomx_zm"];                                   
    level.BeastNames       = ["Venom-X"];
    level.otherWeaps       = ["iw7_fists_zm", "iw7_entangler_zm"];
    level.OtherNames       = ["Fists", "Entangler"];
    level.papCamoSL        = ["+camo1","+camo4"];
    level.papCamoRR        = ["+camo204","+camo205"];
    level.papCamoSS        = ["+camo211","+camo212"];
    level.papCamoRT        = ["+camo92","+camo93"];
    level.papCamoBB        = ["+camo32","+camo34"];
    level.pickupLoot       = ["power_bioSpike","power_c4","power_clusterGrenade","power_concussionGrenade","power_frag","power_gasGrenade","power_semtex","power_splashGrenade"];
    level.pickupLootName   = ["Bio Spikes","C4","Cluster Grenades","Concussion Grenades","Frag Grenades","Gas Grenades","Semtex Grenades", "Splash Grenades"];
    level.pickupPowers     = ["power_speedBoost","power_teleport","power_transponder","power_cloak","power_barrier","power_mortarMount"];
    level.trapNames        = ["Sentry Turret","Fireworks Trap","Medusa Device","Electric Trap","Boombox","Revocator","Kindle Pops","Lazer Window Trap"];
    if(level.script == "cp_zmb"){ level.jailPos = (3356.53,-996.361, -195.873); level.freePos = (640.463,919.658,0.126336); level.EESong = "mus_pa_mw2_80s_cover";} else if(level.script == "cp_rave") { level.EESong = "mus_pa_rave_hidden_track"; } else if(level.script == "cp_disco") { level.EESong = "mus_pa_disco_hidden_track"; }
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
    hud[0] = self createText("objective", 1.35, "CENTER", "CENTER", -500, 120 + 60, 10, 1, message);
    hud[1] = self createText("objective", 1.35, "CENTER", "CENTER", 500, 140 + 60, 10, 1, message2);

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

iPrintLnAlt(String)
{
    if (!isDefined(self.printMsgs))
        self.printMsgs = [];

    // If already 5 messages, remove the oldest (last in array)
    if (self.printMsgs.size >= 5)
    {
    oldest = self.printMsgs[self.printMsgs.size - 1];
    if (isDefined(oldest))
        oldest destroy();

    // Rebuild array without the last element
    newArr = [];
    for (i = 0; i < self.printMsgs.size - 1; i++)
        newArr[i] = self.printMsgs[i];

    self.printMsgs = newArr;
    }

    // Create new text element
    newMsg       = self createText("objective", 1, "left", "bottom", 0, -125, 3, 1, String, (1,1,1));
    newMsg.alpha = 1;
    newArr       = [];
    newArr[0] = newMsg;
    for (i = 0; i < self.printMsgs.size; i++)
        newArr[i + 1] = self.printMsgs[i];

    self.printMsgs = newArr;

    // Reposition all messages (stack them upward)
    for (i = 0; i < self.printMsgs.size; i++)
    {
        self.printMsgs[i].y = -125 - (i * 20);
    }

    // Fade out after 4 seconds
    newMsg thread hudfade(0, 4);

    // Remove it from the array after fading
    newMsg thread removeAfterFade(self);
}

removeAfterFade(player)
{
    wait 4;
    if (isDefined(self))
    {
        self destroy();
        player.printMsgs = txtarray_remove(player.printMsgs, self);
    }
}

txtarray_remove(arr, elem)
{
    newArr = [];
    for (i = 0; i < arr.size; i++)
        if (arr[i] != elem)
            newArr[newArr.size] = arr[i];
    return newArr;
}

GetTehMap()
{
    if(level.script == "cp_zmb") {return "Zombies in Spaceland";}
    if(level.script == "cp_rave") {return "Rave in the Redwoods";}
    if(level.script == "cp_disco") {return "Shaolin Shuffle";}
    if(level.script == "cp_town") {return "Radioactive Thing";}
    if(level.script == "cp_final") {return "Beast from Beyond";}
}

FastRestartGame()
{
    map_restart(0);
}

test()
{
    
    self iPrintLnAlt("Testing");
}

CompleteGnS()
{
    self lib_0D59::use_activate_gns_machine("activate_gns_machine");
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);//notifyactivationprogress
}

MaxBank()
{
    level.var_2416 = 2147483647;//level.var_2416 = level.atm_amount_deposited
    self iPrintLnAlt("The Bank is ^2BURSTING! ^0Balance Set to: ^2$2147483647");
}

CompleteAllKungFu(player)
{
    if(!isDefined(player)) return;
    kungFuArray = ["crane","tiger","dragon","snake","monkey"];
    foreach(kungFu in kungFuArray){
        self.kung_fu_progression.disciplines_level[kungFu] = 3;
    }
}

PrintMenuControls()
{
    self endon("disconnect");
    self endon("game_ended");
    info = [];
    info[0]="YetAnotherModMenu IW Edition";
    info[1] = "Press [{+speed_throw}] & [{+melee}] To Open";
    info[2] = "Press [{+speed_throw}] & [{+attack}] to Scroll";
    info[3] = "Press [{+activate}] to Select, [{+melee}] to Go Back";
    info[4] = "For Rank Sliders, Use [{+smoke}] and [{+frag}] To Scroll";
    for(;;)
    {
        for(i=0;i<5;i++)
        {
            self iPrintLnAlt(info[i]);
            wait 5;
        }
        wait .2;
    }
}

EndGameHost()
{
    foreach(client in level.players) client iPrintLnAlt("^2Sorry, "+self.name+" Ended The Game");
    level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
}

returnZombieTeam()
{
    return scripts\mp\_mp_agent::func_7DB0("axis");
}
EditRound(newRoundNum)
{
    if(level.wave_num < 1) {self iPrintLnAlt("Fool, wait for the round to start"); return;}
    else{
        self iPrintLnAlt("Round Changing to: "+newRoundNum+" in TWO SECONDS!");
        wait 2;
        level.wave_num = newRoundNum;
        thread killAllZombies();
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

MaxRound()
{
    if(level.wave_num < 1) {self iPrintLnAlt("Fool, wait for the round to start"); return;}
    else{
        level notify("wave_complete");
        self iPrintLnAlt("Round Changing to: 2147483647 in TWO SECONDS!");
        wait 2;
        level.wave_num = 2147483646;
        thread killAllZombies();
    }
}
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
        timer               = self createText("small",1.5,"left","bottom",0,0,1,1,"Lobby Ends In:",level.rainbowColour);
        timer2              = self createText("small",1.5,"left","bottom",105,2,1,1,undefined, level.rainbowColour);
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
    self iPrintLnBold("Timer Set To: "+time+" Minutes");
}
KeyGiving()
{
    self scripts\cp\_persistence::func_830F(500);
    self iPrintLnAlt("You should have 500 Keys");
}

NoMovingWheel()
{
    level.noMoveBox = !bool(level.noMoveBox);
    if(level.NoMoveBox){
        self iPrintLnAlt("Wheel no Move ^2Enabled");
        self thread LoopBox();
    }
    else
    {
        self iPrintLn("Wheel no Move ^1Disabled");
        level.var_B162  = 1;
        level.var_13D01 = 4;//set to 4 so it moves next spin
        level notify("stop_box");
    }
}
LoopBox()
{
    self endon("death");
    self endon("disconnect");
    self endon("stop_box");
    for(;;)
    {
        level.var_13D01 = 0;//set box spins at 0, since the check runs if > than 4 spins took place.
        wait 1;
    }
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

GiveTickets(Amount)
{
    self scripts\cp\zombies\arcade_game_utility::func_8317(self, Amount);
    self iPrintLnAlt("Awarded ^1"+amount+" Tickets");
}   

TurnOnPower()
{
    foreach(generator in level.var_773B)//foreach(generator in level.generators)
    {
        thread lib_0D51::func_7757(generator);//func_7757 = generic_generator(generator);
        wait(0.1);
    }
    if(level.script == "cp_town")
    {
        flag_set("found_missing_handle");
        zomPart = getstructarray("mpq_zom_body_part","script_noteworthy");
    }
    if(isdefined(level.fast_travel_spots))//activate fast travel spots :)
    {
        foreach(var_05 in level.fast_travel_spots)
        {
            var_05.activated = 1;
            var_05.var_13068 = 1;
            if(isDefined(var_05.var_C626)) {
                var_05.var_C626 = 0;
            }
            if(level.script == "cp_zmb")
            { 
                flag_set("pap_portal_used");
            }
        }
    }
}

ClearDoorsAndDebris()
{
    doorArray = ["door_buy","chi_door"];
    foreach(door in doorArray)
    {
        switch(door)
        {
            case "door_buy" : doors = getentarray(door, "targetname"); foreach(door2 in doors){ door2 notify("trigger","open_sesame");wait .01;} break;
            case "chi_door" : chidoors = getentarray(door,"targetname"); foreach(chidoor in chidoors){ chidoor.physics_capsulecast notify("damage",undefined, "open_sesame"); wait .01;} break;
        }
    }
    level.moon_donations   = 3;
    level.kepler_donations = 3;
    level.triton_donations = 3;
    if(isDefined(level.team_killdoors))
    {
        foreach(teamDoor in level.team_killdoors)
        {
            teamDoor thread lib_0D4C::open_team_killdoor(level.players[0]);
        }
    }
    doorInteracts = getstructarray("interaction","targetname");
    foreach(interact in doorInteracts)
    {
        doorTrigger = getstructarray(interact.script_noteworthy,"script_noteworthy");
        foreach(trigger in doorTrigger)
        {
            if(isDefined(trigger.target) && isDefined(interact.trigger))
            {
                if(trigger.target == interact.target && trigger != interact)
                {
                    if(scripts\common\utility::func_2286(doorInteracts,trigger))
                    {
                        doorInteracts = scripts\common\utility::func_22A9(doorInteracts,trigger);
                    }
                }
            }
        }
        if(scripts\cp\_interaction::func_9A18(interact))
        {
            if(!isDefined(interact.script_noteworthy))
            {
                continue;
            }
            if(interact.script_noteworthy == "team_door_switch")
            {
                scripts\cp\zombies\interaction_openareas::func_1302F(interact,level.players[0]);
            }
        }
    }
    if(scripts\common\utility::func_6E34("restorepower_step1"))
    {
        flag_set("restorepower_step1");
    }
    self iPrintLnAlt("Doors ^2Opened");
}

PlayAudioToClients(audioFile)
{
    foreach(player in level.players)
    {
        if(level.script == "cp_zmb")
        { 
            level thread [[level.force_song_func]](undefined,audioFile,undefined,undefined,undefined,undefined); 
        }
        else{
            level thread force_song((649,683,254),audioFile);
        }
    }
}

force_song(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
    level endon("game_ended");
    level endon("add_hidden_song_to_playlist");
    level endon("add_hidden_song_2_to_playlist");
    level notify("force_new_song");
    level endon("force_new_song");
    if(isdefined(param_05))
    {
        level.var_72AB[param_05] = param_05;
    }

    var_07 = spawnstruct();
    var_07.var_10406 = param_01;
    var_07.var_5747 = "";
    var_07.var_5748 = "";
    var_07.var_5745 = "";
    var_07.var_7783 = "music";
    level.var_A4BD[level.var_A4BD.size] = var_07;
    scripts\common\utility::func_CE2C("zmb_jukebox_on",param_00, (0,0,0));

    var_08 = spawn("script_origin",param_00);
    var_08 playloopsound(param_01);
    level.var_4B67 = param_01;
    var_08 thread earlyendon(var_08);
    var_09 = lookupsoundlength(param_01) / 1000;
    waittill_any_timeout_1(var_09,"skip_song");
    var_08 stoploopsound();
    if(istrue(param_06))
    {
        parse_music_genre_table();
    }

    level thread scripts\cp\zombies\zombie_jukebox::func_A4BE((649,683,254),1);
}
func_CE2C(param_00,param_01,param_02,param_03,param_04)
{
    var_05 = spawn("script_origin",(0,0,1));
    if(!isdefined(param_01))
    {
        param_01 = self.origin;
    }

    var_05.origin = param_01;
    var_05.angles = param_02;
    if(isdefined(param_04))
    {
        var_05 linkto(param_04);
    }
    if(isdefined(param_03) && param_03)
    {
        var_05 playsoundasmaster(param_00);
    }
    else
    {
        var_05 playsound(param_00);
    }

    var_05 delete();
}

//Function Number: 152
play_sound_in_space(param_00,param_01,param_02,param_03)
{
    func_CE2C(param_00,param_01,(0,0,0),param_02,param_03);
}
waittill_any_timeout_1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
    self endon("death");

    var_07 = spawnstruct();
    if(isdefined(param_01))
    {
        thread func_13806(param_01,var_07);
    }

    var_07 thread func_1428(param_00);
    var_07 waittill("returned",var_08);
    var_07 notify("die");
    return var_08;
}

func_13806(param_00,param_01)
{
    if(param_00 != "death")
    {
        self endon("death");
    }

    param_01 endon("die");
    self waittill(param_00);
    param_01 notify("returned",param_00);
}

func_1428(param_00)
{
    self endon("die");
    wait(param_00);
    self notify("returned","timeout");
}

istrue(param_00)
{
    if(isdefined(param_00) && param_00)
    {
        return 1;
    }

    return 0;
}
flag_init(param_00)
{
    if(!isdefined(level.flag))
    {
        func_95E2();
    }

    level.flag[param_00] = 0;
    func_978C();
    if(!isdefined(level.var_12745[param_00]))
    {
        level.var_12745[param_00] = [];
    }

    if(getsubstr(param_00,0,3) == "aa_")
    {
        thread [[ level.var_74C2["sp_stat_tracking_func"] ]](param_00);
    }
}
flag_set(param_00,param_01)
{
    level.flag[param_00] = 1;
    if(isdefined(param_01))
    {
        level notify(param_00,param_01);
        return;
    }

    level notify(param_00);
}
func_95E2()
{
    level.flag = [];
    level.var_6E6E = [];
    level.var_7763 = 0;
    func_95C6("sp_stat_tracking_func");
    level.var_6E46 = spawnstruct();
    level.var_6E46 func_23D9();
}
func_23D9()
{
    self.var_12BA3 = "generic" + level.var_7763;
    level.var_7763++;
}

func_16DC(param_00,param_01)
{
    if(!isdefined(level.var_74C2))
    {
        level.var_74C2 = [];
    }

    level.var_74C2[param_00] = param_01;
}

//Function Number: 187
func_95C6(param_00)
{
    if(!isdefined(level.var_74C2))
    {
        level.var_74C2 = [];
    }

    if(!isdefined(level.var_74C2[param_00]))
    {
        func_16DC(param_00,::func_61B9);
    }
}
func_61B9(param_00)
{
}
func_978C()
{

    level.var_12745 = [];
    level.var_12749[1] = ::trigger_onOverride;
    level.var_12749[0] = ::trigger_offOverride;
}
//Function Number: 45
trigger_onOverride(param_00,param_01)
{
    if(isdefined(param_00) && isdefined(param_01))
    {
        var_02 = getentarray(param_00,param_01);
        return;
    }

    func_1277B();
}
//Function Number: 46
func_1277B()
{
    if(isdefined(self.var_DD8D))
    {
        self.origin = self.var_DD8D;
    }

    self.trigger_off = undefined;
}

//Function Number: 47
trigger_offOverride(param_00,param_01)
{
    if(isdefined(param_00) && isdefined(param_01))
    {
        var_02 = getentarray(param_00,param_01);
        return;
    }

    func_12779();
}

earlyendon(param_00)
{
    level endon("game_ended");
    level waittill_any_3("add_hidden_song_to_playlist","add_hidden_song_2_to_playlist","force_new_song");
    param_00 stoploopsound();
    wait(2);
    if(isdefined(param_00))
    {
        param_00 delete();
    }
}
//Function Number: 48
func_12779()
{
    if(!isdefined(self.var_DD8D))
    {
        self.var_DD8D = self.origin;
    }

    if(self.origin == self.var_DD8D)
    {
        self.origin = self.origin + (0,0,-10000);
    }

    self.trigger_off = 1;
    self notify("trigger_off");
}
waittill_any_3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
    if(isdefined(param_01))
    {
        self endon(param_01);
    }

    if(isdefined(param_02))
    {
        self endon(param_02);
    }

    if(isdefined(param_03))
    {
        self endon(param_03);
    }

    if(isdefined(param_04))
    {
        self endon(param_04);
    }

    if(isdefined(param_05))
    {
        self endon(param_05);
    }

    if(isdefined(param_06))
    {
        self endon(param_06);
    }

    if(isdefined(param_07))
    {
        self endon(param_07);
    }

    self waittill(param_00);
}
parse_music_genre_table()
{
    flag_init("jukebox_paused");
    level.var_A4BD = [];
    level.var_72AB = [];
    level.var_689D = ["mus_pa_sp_knightrider","mus_pa_mw1_80s_cover","mus_pa_mw2_80s_cover"];
    level.var_10405 = 0;
    level.var_BF50 = 0;
    level.songs_played = 0;
    if(isdefined(level.var_A4BF))
    {
        var_00 = level.var_A4BF;
    }
    else
    {
        var_00 = "cp/zombies/cp_zmb_music_genre.csv";
    }

    var_01 = 0;
    for(;;)
    {
        var_02 = tablelookupbyrow(var_00,var_01,1);
        if(var_02 == "")
        {
            break;
        }

        if(func_2286(level.var_689D,var_02))
        {
            var_01++;
            continue;
        }

        var_03 = tablelookupbyrow(var_00,var_01,2);
        var_04 = tablelookupbyrow(var_00,var_01,3);
        var_05 = tablelookupbyrow(var_00,var_01,4);
        var_06 = tablelookupbyrow(var_00,var_01,5);
        var_07 = spawnstruct();
        var_07.var_10406 = var_02;
        var_07.var_5747 = var_04;
        var_07.var_5748 = var_05;
        var_07.var_5745 = var_06;
        var_07.var_7783 = var_03;
        level.var_A4BD[level.var_A4BD.size] = var_07;
        var_01++;
    }
}

func_2286(param_00,param_01)
{
    if(param_00.size <= 0)
    {
        return 0;
    }

    foreach(var_03 in param_00)
    {
        if(var_03 == param_01)
        {
            return 1;
        }
    }

    return 0;
}
set_quest_icon(param_00)
{
    setomnvarbit("zombie_quest_piece",param_00,1);
    setclientmatchdata("questPieces","quest_piece_" + param_00,1);
    if(!isdefined(level.num_of_quest_pieces_completed))
    {
        level.num_of_quest_pieces_completed = 0;
    }

    level.num_of_quest_pieces_completed++;
}
GrabSetiComParts(){
    self pick_up_djquest_part("dj_quest_part_1","zmb_frequency_device_radio");
    self pick_up_djquest_part("dj_quest_part_2","zmb_frequency_device_calculator");
    self pick_up_djquest_part("dj_quest_part_3","zmb_frequency_device_umbrella_ground");
}

GrabTheSeticom()
{
    flag_set("dj_request_defense_done");
    foreach(player in level.players)
    {
        player setclientomnvar("zm_special_item",3);
    }
}
pick_up_djquest_part(tagName,quest_part)
{
    if(level.var_5738 == true && level.var_5739 == true && level.var_573A == true)
    {
        flag_set("dj_fetch_quest_completed");
    }
    var1 = 0;
    if(tagName == "dj_quest_part_3") var1 = 24;
    else if(tagName == "dj_quest_part_2") var1 = 23; 
    else if(tagName == "dj_quest_part_1") var1 = 22; 

    playfx(level._effect["souvenir_pickup"],tagName.part_model.origin);
    quest_part playlocalsound("part_pickup");
    thread scripts\cp\zombies\zombie_analytics::func_AF6F(level.wave_num,tagName.groupname,tagName.part_model.model);
    tagName.part_model delete();
    level set_quest_icon(var1);
}
has_zombie_perk(param_00)
{
    if(!isdefined(self.zombies_perks))
    {
        return 0;
    }

    return istrue(self.zombies_perks[param_00]);
}
GiveWeaponToPlayer(weapon, player) {
    if(isDefined(self.give_packed_weapon) && self.give_packed_weapon == 1 || isDefined(self.give_double_packed_weapon) && self.give_double_packed_weapon == 1)
    {
        papText  = undefined;
        papCamo  = undefined;
        papLevel = undefined;
        if(isDefined(self.give_packed_weapon) && self.give_packed_weapon == 1){
            papText = "pap1";
            if(level.script == "cp_zmb"){ papCamo ="+camo1";}else if(level.script == "cp_rave") { papCamo = "+camo204";} else if(level.script == "cp_disco"){ papCamo = "+camo211";} else if(level.script == "cp_town"){ papCamo = "+camo92";} else if(level.script == "cp_final"){ papCamo = "+camo32";}
            papLevel = "1";
        }
        else if(isDefined(self.give_double_packed_weapon) && self.give_double_packed_weapon == 1)
        {
            papText = "pap2";
            if(level.script == "cp_zmb"){ papCamo ="+camo4";}else if(level.script == "cp_rave") { papCamo = "+camo205";} else if(level.script == "cp_disco"){ papCamo = "+camo212";} else if(level.script == "cp_town"){ papCamo = "+camo93";} else if(level.script == "cp_final"){ papCamo = "+camo34";}
            papLevel = "2";
        }
        if(weapon == "iw7_axe_zm") 
        {
            weapon += "_pap" + papLevel + "+axe" + papText;
        } 
        else if(weapon == "iw7_dischord_zm") 
        {
            weapon += "_pap1+dischordpap1+camo20";
        } 
        else if(weapon == "iw7_facemelter_zm") 
        {
            weapon += "_pap1+fmpap1+camo22";
        } 
        else if(weapon == "iw7_headcutter_zm") 
        {
            weapon += "_pap1+hcpap1+camo21";
        } 
        else if(weapon == "iw7_shredder_zm") 
        {
            weapon += "_pap1+shredderpap1+camo23";
        } 
        else if(weapon == "iw7_katana_zm") 
        {
            weapon += "_pap" + papLevel + "+camo222";
        } 
        else if(weapon == "iw7_nunchucks_zm") 
        {
            weapon += "_pap" + papLevel + "+camo222";
        } 
        else if(weapon == "iw7_forgefreeze_zm+forgefreezealtfire") 
        {
            weapon += "+freeze" + papText;
        } 
        else if(weapon == "iw7_spaceland_wmd" || weapon == "iw7_fists_zm" || weapon == "iw7_entangler_zm" || weapon == "iw7_atomizer_mp" || weapon == "iw7_penetrationrail_mp+penetrationrailscope" || weapon == "iw7_steeldragon_mp" || weapon == "iw7_claw_mp" || weapon == "iw7_blackholegun_mp+blackholegunscope" || weapon == "iw7_cutie_zm") 
        {
        
        } 
        else 
        {
            weapon = build_custom_weapon(weapon, papCamo, papText);
        }
    } 
    else 
    {
        switch(weapon) {
            case "iw7_axe_zm":
            case "iw7_dischord_zm":
            case "iw7_facemelter_zm":
            case "iw7_headcutter_zm":
            case "iw7_shredder_zm":
            case "iw7_golf_club_mp":
            case "iw7_spiked_bat_mp":
            case "iw7_two_headed_axe_mp":
            case "iw7_machete_mp":
            case "iw7_harpoon1_zm":
            case "iw7_harpoon2_zm":
            case "iw7_harpoon3_zm+akimbo":
            case "iw7_harpoon4_zm":
            case "iw7_katana_zm":
            case "iw7_nunchucks_zm":
            case "iw7_venomx_zm":
            case "iw7_forgefreeze_zm+forgefreezealtfire":
            case "iw7_spaceland_wmd":
            case "iw7_cutie_zm":
            case "iw7_fists_zm":
            case "iw7_entangler_zm":
            case "iw7_atomizer_mp":
            case "iw7_penetrationrail_mp+penetrationrailscope":
            case "iw7_steeldragon_mp":
            case "iw7_claw_mp":
            case "iw7_blackholegun_mp+blackholegunscope":
                break;
            default:
                weapon = build_custom_weapon(weapon, undefined, undefined);
        }
    }
    if(player getCurrentWeapon() != weapon && player getWeaponsListPrimaries()[1] != weapon && player getWeaponsListPrimaries()[2] != weapon && player getWeaponsListPrimaries()[3] != weapon&& player getWeaponsListPrimaries()[4] != weapon) {
        if(self has_zombie_perk("perk_machine_more")) maxWeapons = 4; else maxWeapons = 3;
        if(self getWeaponsListPrimaries().size >= maxWeapons) self takeWeapon(self getCurrentWeapon());
        if(weapon == "iw7_spaceland_wmd" || weapon == "iw7_fists_zm" || weapon == "iw7_entangler_zm" || weapon == "iw7_atomizer_mp" || weapon == "iw7_penetrationrail_mp+penetrationrailscope" || weapon == "iw7_steeldragon_mp" || weapon == "iw7_claw_mp" || weapon == "iw7_blackholegun_mp+blackholegunscope" || weapon == "iw7_cutie_zm") {
            player giveWeapon(weapon);
            player switchToWeapon(weapon);
            wait 1;
            player setWeaponAmmoClip(player getCurrentWeapon(), 999);
            player setWeaponAmmoClip(player getCurrentWeapon(), 999, "left");
            player setWeaponAmmoClip(player getCurrentWeapon(), 999, "right");
            
        } else {
            cusWeap = scripts\cp\_weapon::func_E469(weapon);
            player giveWeapon(cusWeap);
            player switchToWeapon(cusWeap);
            wait 1;
            player setWeaponAmmoClip(player getCurrentWeapon(), 999);
            player setWeaponAmmoClip(player getCurrentWeapon(), 999, "left");
            player setWeaponAmmoClip(player getCurrentWeapon(), 999, "right");
        }
    } else {
        cusWeap = scripts\cp\_weapon::func_E469(weapon);
        player switchtoweapon(cusWeap);
        wait 1;
        player setWeaponAmmoClip(player getCurrentWeapon(), 999);
        player setWeaponAmmoClip(player getCurrentWeapon(), 999, "left");
        player setWeaponAmmoClip(player getCurrentWeapon(), 999, "right");
    }
}

    
CompleteChallenges(player)
{
    merits = GetArrayKeys(level.var_B684);
        
    if(!isDefined(merits) || !merits.size)
        return;
       
    foreach(merit in merits)
    {
        targetVal       = level.var_B684[merit]["targetval"];
        currentState    = player GetPlayerData("cp", "meritState", merit);
        currentProgress = player GetPlayerData("cp", "meritProgress", merit);
            
        if(!isDefined(targetVal))
            continue;
            
        if(currentState < targetVal.size || currentProgress < targetVal[(targetVal.size - 1)])
        {
            if(currentProgress < targetVal[(targetVal.size - 1)])
                player SetPlayerData("cp", "meritProgress", merit, targetVal[(targetVal.size - 1)]);
                
            if(currentState < targetVal.size)
                player SetPlayerData("cp", "meritState", merit, targetVal.size);
                
            wait 0.01;
        }
    }
    player iPrintLnAlt("Hey, you just got ^2UNLOCK ALL");
}

CompleteActiveContracts(player)
{
    contracts = GetArrayKeys(self.contracts);
    
    if(!isDefined(contracts) || !contracts.size)
        return;
    
    foreach(contract in contracts)
    {
        target = player.contracts[contract].target;

        mode = "cp";
        
        
        progress = player GetPlayerData(mode, "contracts", "challenges", contract, "progress");
        
        if(!isDefined(progress) || !isDefined(target) || progress >= target)
            continue;
        
        player SetPlayerData(mode, "contracts", "challenges", contract, "progress", target);
        player SetPlayerData(mode, "contracts", "challenges", contract, "completed", 1);
        
        wait 0.01;
    }
    player iPrintLnAlt("^2Your Contracts are now Complete. Sweet Keys and Salvage");
}

SetPlayerRank(rank, player)
{
    rank = (rank - 1);
        mode  = "cp";
        table = "cp/zombies/rankTable.csv";
    
    player SetPlayerData(mode, "progression", "playerLevel", "xp", Int(TableLookup(table, 0, rank, (rank == Int(TableLookup(table, 0, "maxrank", 1))) ? 7 : 2)));
    player iPrintLnAlt("You are now Level "+rank);
}

SetPlayerPrestige(prestige, player)
{
    player SetPlayerData("cp", "progression", "playerLevel", "prestige", prestige);
    player iPrintLnAlt("You are now Prestige "+prestige);
}

SetPlayerMaxWeaponRanks(player)
{
    for(a = 1; a < 62; a++)
    {
        weapon = TableLookup("mp/statstable.csv", 0, a, 4);
        
        if(!isDefined(weapon) || weapon == "")
            continue;
        
            player SetPlayerData("common", "sharedProgression", "weaponLevel", weapon, "cpXP", 54300);
        player SetPlayerData("common", "sharedProgression", "weaponLevel", weapon, "prestige", 3);
        
        wait 0.01;
    }
}


UnlockDC(player)
{
    player setplayerdata("cp","dc", 1);
    self iPrintLnAlt("^2Director's cut given to "+player.name);
}


PrintCoords()
{
    self iPrintLnAlt("Current Coords: "+self.origin);
}

getstructarray(param_00,param_01)
{
    var_02 = level.var_1115C[param_01][param_00];
    if(!isdefined(var_02))
    {
        return [];
    }

    return var_02;
}

beast_open_sesame() { //credit syndishanx, I was lazy.
    flag_set("neil_head_found");
    flag_set("neil_head_placed");
    flag_set("restorepower_step1");
    flag_set("power_on");
    level notify("power_on");
    
    set_quest_icon(6);
    var_00 = getstructarray("neil_head","script_noteworthy");
    foreach(var_02 in var_00) {
        if(isDefined(var_02.var_8C98)) {
            var_02.var_8C98 delete();
        }
    }
    
    foreach(door in level.allslidingdoors) {
        door.player_opened = 1;
        thread [[level.interactions[door.script_noteworthy].activation_func]](door,undefined);
    }
}

CombineArrays(param_00,param_01,param_02,param_03)
{
    var_04 = [];
    if(isdefined(param_00))
    {
        foreach(var_06 in param_00)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_01))
    {
        foreach(var_06 in param_01)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_02))
    {
        foreach(var_06 in param_02)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_03))
    {
        foreach(var_06 in param_03)
        {
            var_04[var_04.size] = var_06;
        }
    }
}

build_custom_weapon(weapon, camo, extra_attachments) {
    weapon_name = scripts\cp\_utility::func_80D8(weapon);
    
    if (isDefined(self.var_13C00[weapon_name])) {
        weapon_model       = self.var_13C00[weapon_name];
        weapon_attachments = scripts\cp\_utility::func_8217(weapon_model);
        weapon_build       = CombineArrays(extra_attachments, weapon_attachments);
        weapon_custom      = self scripts\cp\_weapon::func_E469(getweaponbasename(weapon), undefined, weapon_build, 1, camo);
        return weapon_custom;
    } else {
        weapon_custom = CombineArrays(extra_attachments, weapon);
        return weapon_custom;
    }
}

UnlockTalismans(player)
{
    if(level.script == "cp_zmb")
    {
        player scripts\cp\_merits::func_D9AD("mt_tali_1"); 
  
    }
    else if(level.script == "cp_rave")
    {
        player scripts\cp\_merits::func_D9AD("mt_tali_2");
    }
    else if(level.script == "cp_disco")
    {
        player scripts\cp\_merits::func_D9AD("mt_tali_3");
    }
    else if(level.script == "cp_town")
    {
        player scripts\cp\_merits::func_D9AD("mt_tali_4");
    }
    else if(level.script == "cp_final")
    {
        player scripts\cp\_merits::func_D9AD("mt_tali_5");
    }
    player setplayerdata("cp","haveItems","item_1",1);
    player setplayerdata("cp","haveItems","item_2",1);
    player setplayerdata("cp","haveItems","item_3",1);
    player setplayerdata("cp","haveItems","item_4",1);
    player setplayerdata("cp","haveItems","item_5",1);
    player iPrintln("All Talismans ^2Unlocked");
}
setPlayerAtPoint(origin, angles) {
    self setOrigin(origin);
    self setPlayerAngles(angles);
}
SoulKeyUnlock(player)
{
     player getplayerdata("cp","haveSoulKeys","soul_key_1");
      player getplayerdata("cp","haveSoulKeys","soul_key_2");
      player getplayerdata("cp","haveSoulKeys","soul_key_3");
      player getplayerdata("cp","haveSoulKeys","soul_key_4");
      player getplayerdata("cp","haveSoulKeys","soul_key_5");
      player setplayerdata("cp","haveSoulKeys","soul_key_1",1);
      player setplayerdata("cp","haveSoulKeys","soul_key_2",1);
      player setplayerdata("cp","haveSoulKeys","soul_key_3",1);
      player setplayerdata("cp","haveSoulKeys","soul_key_4",1);
      player setplayerdata("cp","haveSoulKeys","soul_key_5",1);
      player iPrintLnAlt("You Now have ^2ALL Soul Keys");
      wait 1;
      player thread setPlayerAtPoint((-10250, 875, -1630), (0, 90, 0));
      player iPrintLnAlt("Interact with the ^2Soul Jar^7 to Unlock Directors Cut ^5Permanently");
}
    
outline_zombies() {
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

outline_zombies_loop() {
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

set_outline_color(value) {
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

givePillagedLoot( equipment )
{
    thread scripts\cp\powers\coop_powers::func_8397(equipment, "primary", undefined, undefined, undefined, 0, 1);
    self playlocalsound("grenade_pickup");
}

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
        self iPrintln("Wait For The Current Sky Trip To Finish");
}
    
SetXPScale(scale)
{
    self.var_13E26 = scale;
    self iPrintLnAlt("XP Scale Set To: "+scale);
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

remove_from_current_interaction_list(item)
{
    if(func_2286(level.current_interaction_structs,item))
    {
        level.current_interaction_structs = func_22A9(level.current_interaction_structs,item);
    }
}

GetNeilPart(partNum)
{
    switch(partNum)
    {
        case 0 : self playlocalsound("neil_part_pickup"); remove_from_current_interaction_list(level.var_BEC5);level.var_BEC5.var_BEC5 delete();level.var_BEC7 = 1;set_quest_icon(7); break;
        case 1 : self playLocalSound("neil_part_pickup"); playfx(level._effect["souvenir_pickup"],level.var_BEAE.part.origin);remove_from_current_interaction_list(level.var_BEAE);level.var_BEAE.part delete();level.var_BEB0 = 1; set_quest_icon(8); break;
        case 2 : self playlocalsound("neil_part_pickup");playfx(level._effect["souvenir_pickup"],level.var_BEC1.part.origin);remove_from_current_interaction_list(level.var_BEC1);level.var_BEC1.part delete();level.var_BEC3 = 1;set_quest_icon(9); break;
    }
}
func_22A9(param_00,param_01)
{
    var_02 = [];
    foreach(var_04 in param_00)
    {
        if(var_04 != param_01)
        {
            var_02[var_02.size] = var_04;
        }
    }

    return var_02;
}

GetThoseSpeakers()
{
    if(isdefined(level.current_speaker))
    {
        level.current_speaker = undefined;
    }

    foreach(var_04 in level.players)
    {
        var_04 notify("speaker_defense_completed");
        level notify("speaker_defense_completed");
    }
    flag_set("dj_request_defense_done");
    foreach(var_01 in level.players)
    {
        var_01 setclientomnvar("zm_special_item",5);
    }
    flag_set("tone_generators_given");
}

ToggleForceHost()
{
    self.ForcingHost = !bool(self.ForcingHost);
    if(self.ForcingHost)
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
        self iPrintLnAlt("Force Host ^2Enabled");
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
        self iPrintLnAlt("Force Host ^1Disabled");
    }
}

dropweapon(player)
{
    player method_80B8(player getcurrentweapon());//method_80B8 = DropItem
    player iPrintLnAlt("^2Oops, you ^1Dropped ^2Something");
}
