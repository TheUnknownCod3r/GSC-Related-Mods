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
#include scripts\engine\_utility;
#include scripts\cp\_interaction;
#include scripts\cp\_vo;
//Preprocessor definition chaining

init()
{
    level thread InitializeMenu();
    level thread onPlayerConnect();
    level.mapName             = level.script;
    level.cycle_reward_scalar = 99999;
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
        if(!isDefined(level.notifyQueue))
            level.notifyQueue = [];
        setDvar("sv_cheats", 1);
        if(!isDefined(level.notifyQueue[player]))
            level.notifyQueue[player] = [];
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
patchCallback() 
{
    level.callback_player_damage_stub    = level.callbackplayerdamage;
    level.callbackplayerdamage           = ::callback_player_damage_stub;
    level.callback_player_killed_stub    = level.callbackplayerkilled;
    level.callbackplayerkilled           = ::callback_player_killed_stub;
    level.callback_player_laststand_stub = level.callbackplayerlaststand;
    level.callbackplayerlaststand        = ::callback_player_laststand_stub;
}

callback_player_damage_stub( inflictor, attacker, damage, flag, death_cause, weapon, point, direction, hit_location, time_offset ) 
{
    if( bool( self.godmode ) )
        return;
    
    [[ level.callback_player_damage_stub ]]( inflictor, attacker, damage, flag, death_cause, weapon, point, direction, hit_location, time_offset );
}


callback_player_killed_stub( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration ) 
{
    [[ level.callback_player_killed_stub ]]( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration );
}

callback_player_laststand_stub( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration ) 
{
    self notify( "player_downed" );
    [[ level.callback_player_laststand_stub ]]( inflictor, attacker, damage, death_cause, weapon, direction, hit_location, time_offset, death_duration );
}

InitializeMenu()
{
    level.Status            = ["^1Unverified", "^3Verified", "^4VIP", "^6Admin", "^5Co-Host", "^2Host"];
    level.RGB               = ["Red", "Green", "Blue"];
    level.patchName         = "YetAnotherModMenu";
    level.creatorName       = "TheUnknownCoder";
    level.TimerTime         = "Not Set";
    level.CustomWeapsCategs = ["Assault Rifles","Tactical Rifles","Light Machine Guns","Misc Weapons","Pistols","Projectile Weapons","Shields","Shotguns","Submachine Guns","Sniper Rifles"];
    level._MenuWeapons      = getArrayKeys(level.var_B15E);//level.var_1BED = level.all_magic_weapons, level.var_B15E = level.magic_weapons
    level.WeaponCategories  = ["Assault Rifles", "Sub Machine Guns", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Classic Weapons", "Melee Weapons", "Specialist Weapons", "Map Specific Weapons", "Other Weapons"];
    level.Assault           = ["iw7_m4_zm", "iw7_sdfar_zm", "iw7_ar57_zm", "iw7_fmg_zm+akimbofmg_zm", "iw7_ake_zmr", "iw7_rvn_zm+meleervn", "iw7_vr_zm", "iw7_gauss_zm", "iw7_erad_zm"];
    level.SMG               = ["iw7_fhr_zm", "iw7_crb_zml+crblscope_camo", "iw7_ripper_zmr", "iw7_ump45_zml+ump45lscope_camo", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_tacburst_zm+gltacburst"];
    level.LMG               = ["iw7_sdflmg_zm", "iw7_mauler_zm", "iw7_lmg03_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm"];
    level.Snipers           = ["iw7_kbs_zm", "iw7_m8_zm", "iw7_cheytac_zmr", "iw7_m1_zm", "iw7_ba50cal_zm", "iw7_longshot_zm+longshotlscope_zm"];
    level.Shotguns          = ["iw7_devastator_zm", "iw7_sonic_zmr", "iw7_sdfshotty_zm+sdfshottyscope_camo", "iw7_spas_zmr", "iw7_mod2187_zm"];
    level.Pistols           = ["iw7_emc_zm", "iw7_nrg_zm", "iw7_g18_zmr", "iw7_revolver_zm", "iw7_udm45_zm+udm45scope", "iw7_mag_zm"];
    level.Launchers         = ["iw7_lockon_zm", "iw7_glprox_zm", "iw7_chargeshot_zm+chargeshotscope_camo"];
    level.Classics          = ["iw7_m1c_zm", "iw7_g18c_zm", "iw7_ump45c_zm", "iw7_spasc_zm", "iw7_arclassic_zm", "iw7_cheytacc_zm"];
    level.Melee             = ["iw7_axe_zm"];
    level.Specials          = ["iw7_atomizer_mp", "iw7_penetrationrail_mp+penetrationrailscope", "iw7_steeldragon_mp", "iw7_claw_mp", "iw7_blackholegun_mp+blackholegunscope"];
    level.ARNames           = ["NV4", "R3K", "KBAR-32", "Type-2", "Volk", "R-VN", "X-Con", "G-Rail", "Erad"];
    level.SMGNames          = ["FHR-40", "Karma-45", "RPR Evo", "HVR", "VPR", "Trencher", "Raijin-EMX"];
    level.LMGNames          = ["R.A.W.", "Mauler", "Titan", "Auger", "Atlas"];
    level.SniperNames       = ["KBS Longbow", "EBR-800", "Widowmaker", "DMR-1", "Trek-50", "Proteus"];
    level.ShotgunNames      = ["Reaver", "Banshee", "DCM-8", "Rack-9", "M.2187"];
    level.PistolNames       = ["EMC", "Oni", "Kendall 44", "Hailstorm", "UDM", "Stallion 44"];
    level.LauncherNames     = ["Spartan SA3", "Howitzer", "P-Law"];
    level.ClassicNames      = ["M1", "Hornet", "MacTav-45", "S-Ravage", "OSA", "TF-141"];
    level.MeleeNames        = ["Axe"];
    level.SpecialNames      = ["Eraser", "Ballista EM3", "Steel Dragon", "Claw", "Gravity Vortex Gun", "Arm-2 Akimbo", "Turdlet"];
    level.SpacelandWeaps    = ["iw7_forgefreeze_zm+forgefreezealtfire", "iw7_dischord_zm", "iw7_facemelter_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_spaceland_wmd"];
    level.SpacelandNames    = ["Forge Freeze", "Dischord", "Face Melter", "Head Cutter", "Shredder", "NX 2.0"];
    level.RaveWeaps         = ["iw7_golf_club_mp", "iw7_spiked_bat_mp", "iw7_two_headed_axe_mp", "iw7_machete_mp", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm+akimbo", "iw7_harpoon4_zm"];
    level.RaveNames         = ["Golf Club", "Spiked Bat", "2 Headed Axe", "Machete", "Acid Rain", "Ben Franklin", "Trap o Matic", "Whirlwind EF5"];
    level.ShaolinWeaps      = ["iw7_katana_zm", "iw7_nunchucks_zm", "iw7_fists_zm_crane", "iw7_fists_zm_snake", "iw7_fists_zm_dragon", "iw7_fists_zm_tiger", "iw7_fists_zm_monkey"];
    level.ShaolinNames      = ["Katana", "Nunchucks", "Crane Chi", "Snake Chi", "Dragon Chi", "Tiger Chi", "Monkey Chi"];
    level.AttackWeaps       = ["iw7_cutie_zm", "iw7_knife_zm_crowbar","iw7_fists_zm_cleaver"];
    level.AttackNames       = ["Modular Atomic Disintegrator", "Crowbar", "Cleaver"];
    level.BeastWeaps        = ["iw7_venomx_zm"];                                   
    level.BeastNames        = ["Venom-X"];
    level.otherWeaps        = ["iw7_fists_zm", "iw7_entangler_zm"];
    level.OtherNames        = ["Fists", "Entangler"];
    level.papCamoSL         = ["+camo1","+camo4"];
    level.papCamoRR         = ["+camo204","+camo205"];
    level.papCamoSS         = ["+camo211","+camo212"];
    level.papCamoRT         = ["+camo92","+camo93"];
    level.papCamoBB         = ["+camo32","+camo34"];
    level.pickupLoot        = ["power_bioSpike","power_c4","power_clusterGrenade","power_concussionGrenade","power_frag","power_gasGrenade","power_semtex","power_splashGrenade"];
    level.pickupLootName    = ["Bio Spikes","C4","Cluster Grenades","Concussion Grenades","Frag Grenades","Gas Grenades","Semtex Grenades", "Splash Grenades"];
    level.pickupPowers      = ["power_speedBoost","power_teleport","power_transponder","power_cloak","power_barrier","power_mortarMount"];
    level.trapNames         = ["Sentry Turret","Fireworks Trap","Medusa Device","Electric Trap","Boombox","Revocator","Kindle Pops","Lazer Window Trap"];
    if(level.script == "cp_zmb"){ level.jailPos = (3356.53,-996.361, -195.873); level.freePos = (640.463,919.658,0.126336); level.EESong = "mus_pa_mw2_80s_cover";} else if(level.script == "cp_rave") { level.EESong = "mus_pa_rave_hidden_track"; } else if(level.script == "cp_disco") { level.EESong = "mus_pa_disco_hidden_track"; }
}

welcomeMessage(message, message2)//this needs coords fix, createText hates it.
{
    if (isDefined(self.welcomeMessage))
        while (1) {
            wait .05;
            if (!isDefined(self.welcomeMessage))
                break;
        }
    self.welcomeMessage = true;

    hud = [];
    hud[0] = self createTextWelcome("objective", 1.35, "CENTER", "CENTER", -500, 120 + 60, 10, 1, message);
    hud[1] = self createTextWelcome("objective", 1.35, "CENTER", "CENTER", 500, 140 + 60, 10, 1, message2);

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

    // If already 5 messages, remove the oldest
    if (self.printMsgs.size >= 5)
    {
    oldest = self.printMsgs[self.printMsgs.size - 1];
    if (isDefined(oldest))
        oldest destroy();

        // Rebuild without the oldest message
    newArr = [];
    for (i = 0; i < self.printMsgs.size - 1; i++)
        newArr[i] = self.printMsgs[i];

    self.printMsgs = newArr;
    }

    // Create iPrintLnAlt text
    newMsg       = self createText("objective", 1, "LEFT", "BOTTOM", -420, -185, 3, 0, String, (1, 1, 1));
    newMsg.alpha = 1;
    newArr       = [];
    newArr[0] = newMsg;
    for (i = 0; i < self.printMsgs.size; i++)
        newArr[i + 1] = self.printMsgs[i];

    self.printMsgs = newArr;

    // Push each message up when new ones come in
    for (i = 0; i < self.printMsgs.size; i++)
    {
        self.printMsgs[i].y = -125 - (i * 20);
    }

    // fade in 4s
    newMsg thread hudfade(0, 4);

    // Fade and remove
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

test()
{
    
    self iPrintLnAlt("Testing");
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
modelSpawner(origin, model, angles, time)
{
    if(isDefined(time))
        wait time;
    obj = spawn("script_model", origin);
    obj setModel(model);
    if(isDefined(angles))
        obj.angles = angles;
    if(getentarray().size >= 2000)
    {
        self iPrintLnAlt("^1Error^7: Please delete some other structures");
        obj delete();
    }
    return obj;
}

KeyGiving()//doesnt work, ugh
{
    self setplayerdata("cp", "alienSession", "kills", 99999);
    self setplayerdata("cp","alienSession","time",99999);
    self setplayerdata("cp","alienSession","score",99999);
    self scripts\cp\_persistence::func_830F(500);
    self iPrintLnAlt("You should have 500 Keys");
}

setPlayerAtPoint(origin, angles)
{
    self setOrigin(origin);
    self setPlayerAngles(angles);
}
   