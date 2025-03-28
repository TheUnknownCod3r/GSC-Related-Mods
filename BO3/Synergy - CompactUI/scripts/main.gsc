#ifdef MP
#include scripts\mp\gametypes\_hud_message; //mp only
#include scripts\mp\gametypes\_globallogic_actor; //mp only
#include scripts\mp\gametypes\_globallogic; //mp only
#include scripts\mp\gametypes\_globallogic_player; //mp only
#include scripts\mp\gametypes\_loadout; //mp only
#include scripts\mp\killstreaks\_killstreaks; //mp only
#include scripts\mp\gametypes\_globallogic_score; //mp only
#include scripts\mp\gametypes\_globallogic_ui; //mp only
#include scripts\mp\gametypes\_globallogic_utils; //mp only
#include scripts\mp\_scoreevents; //mp only
#include scripts\mp\_contracts; //mp only
#include scripts\mp\_arena;
#include scripts\mp\_gamerep; //mp only
#include scripts\shared\_oob;
#include scripts\mp\bots\_bot;
#include scripts\mp\bots\_bot_combat;
#include scripts\mp\teams\_teams;
#include scripts\shared\bots\_bot;
#include scripts\shared\bots\_bot_combat;
#include scripts\shared\bots\bot_buttons;
#include scripts\shared\bots\bot_traversals;
#include scripts\codescripts\struct; //Shared over both
#include scripts\shared\callbacks_shared; //Shared over both
#include scripts\shared\clientfield_shared; //Shared over both
#include scripts\shared\math_shared; //Shared over both
#include scripts\shared\system_shared; //Shared over both
#include scripts\shared\util_shared; //Shared over both
#include scripts\shared\hud_util_shared; //Shared over both
#include scripts\shared\hud_message_shared; //Shared over both
#include scripts\shared\hud_shared; //Shared over both
#include scripts\shared\array_shared; //Shared over both
#include scripts\shared\rank_shared;
#include scripts\shared\killstreaks_shared; //Shared over both
#include scripts\shared\flag_shared; //Shared over both
#include scripts\shared\load_shared;
#include scripts\shared\weapons\_weapons;
#include scripts\shared\persistence_shared;
#include scripts\shared\music_shared; //shared over both
#include scripts\shared\audio_shared;
#include scripts\shared\weapons_shared;
#include scripts\shared\laststand_shared;
#namespace synergybo3;
#endif

#ifdef ZM
#include scripts\codescripts\struct; //Shared over both
#include scripts\shared\callbacks_shared; //Shared over both
#include scripts\shared\clientfield_shared; //Shared over both
#include scripts\shared\math_shared; //Shared over both
#include scripts\shared\system_shared; //Shared over both
#include scripts\shared\util_shared; //Shared over both
#include scripts\shared\hud_util_shared; //Shared over both
#include scripts\shared\hud_message_shared; //Shared over both
#include scripts\shared\hud_shared; //Shared over both
#include scripts\shared\array_shared; //Shared over both
#include scripts\shared\rank_shared; //Shared over both
#include scripts\shared\flag_shared; //Shared over both
#include scripts\shared\music_shared; //shared over both
#include scripts\shared\audio_shared;
#include scripts\shared\weapons_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\aat_shared; //zm only
#include scripts\zm\_util; //zm only
#include scripts\zm\_zm_utility; //zm only
#include scripts\shared\scoreevents_shared;  //zm?
#include scripts\shared\lui_shared; //zm only
#include scripts\shared\scene_shared; //zm only?
#include scripts\shared\vehicle_ai_shared; //zm only
#include scripts\shared\vehicle_shared; //zm only
#include scripts\shared\exploder_shared; //zm only
#include scripts\shared\ai_shared; //zm only
#include scripts\shared\doors_shared; //zm only
#include scripts\shared\gameskill_shared; //zm only
#include scripts\shared\spawner_shared; //zm only
#include scripts\shared\visionset_mgr_shared; //zm only
#include scripts\shared\ai\zombie_utility; //zm only
#include scripts\shared\ai\systems\gib; //zm only
#include scripts\shared\tweakables_shared; //zm only
#include scripts\shared\ai\systems\shared; //zm only
#include scripts\shared\ai\systems\blackboard; //zm only
#include scripts\shared\ai\systems\ai_interface; //zm only
#include scripts\zm\_zm_score; 
#include scripts\zm\_zm_bgb;
#include scripts\zm\bgbs\_zm_bgb_shopping_free;
#include scripts\zm\bgbs\_zm_bgb_round_robbin;
#include scripts\zm\_zm_audio;
#include scripts\zm\_zm_powerup_fire_sale;
#include scripts\zm\_zm_pack_a_punch_util;
#include scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_zonemgr;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_magicbox;
#include scripts\zm\_zm_powerups;
#include scripts\zm\_zm_power;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_blockers;
#include scripts\zm\_zm;
#include scripts\zm\gametypes\_globallogic;
#include scripts\zm\gametypes\_globallogic_score;
#include scripts\zm\_zm_weapons;
#include scripts\zm\craftables\_zm_craftables;
#include scripts\shared\ai\zombie_death;
#include scripts\shared\ai\zombie_shared;
#include scripts\zm\_zm_unitrigger;
#include scripts\zm\_zm_traps;
#namespace synergybo3;
#endif

autoexec __init__system__()
{
    system::register("synergybo3", ::__init__, undefined, undefined);
}



__init__()
{
    callback::on_start_gametype(::init);
    callback::on_connect(::onPlayerConnect);
    callback::on_spawned(::onPlayerSpawned);
}

init()
{
    level.player_out_of_playable_area_monitor = undefined;
    level thread RainbowColor();
    level.Status        = ["^1Unverified", "^3Verified", "^4VIP", "^6Admin", "^5Co-Host", "^2Host"];
    level.RGB           = ["Red", "Green", "Blue"];
    level.patchName     = "Synergy V3";
    level.creatorName   = "TheUnknownCoder";
    level.WeaponCategories = ["Assault Rifles", "Submachine Guns", "Shotguns", "Light Machine Guns", "Sniper Rifles", "Launcher", "Pistols", "Specials"];
    level._Achievements = ["CP_COMPLETE_PROLOGUE", "CP_COMPLETE_NEWWORLD", "CP_COMPLETE_BLACKSTATION", "CP_COMPLETE_BIODOMES", "CP_COMPLETE_SGEN", "CP_COMPLETE_VENGEANCE", "CP_COMPLETE_RAMSES", "CP_COMPLETE_INFECTION", "CP_COMPLETE_AQUIFER", "CP_COMPLETE_LOTUS", "CP_HARD_COMPLETE", "CP_REALISTIC_COMPLETE","CP_CAMPAIGN_COMPLETE", "CP_FIREFLIES_KILL", "CP_UNSTOPPABLE_KILL", "CP_FLYING_WASP_KILL", "CP_TIMED_KILL", "CP_ALL_COLLECTIBLES", "CP_DIFFERENT_GUN_KILL", "CP_ALL_DECORATIONS", "CP_ALL_WEAPON_CAMOS", "CP_CONTROL_QUAD", "CP_MISSION_COLLECTIBLES",  "CP_DISTANCE_KILL", "CP_OBSTRUCTED_KILL", "CP_MELEE_COMBO_KILL", "CP_COMPLETE_WALL_RUN", "CP_TRAINING_GOLD", "CP_COMBAT_ROBOT_KILL", "CP_KILL_WASPS", "CP_CYBERCORE_UPGRADE", "CP_ALL_WEAPON_ATTACHMENTS", "CP_TIMED_STUNNED_KILL", "CP_UNLOCK_DOA", "ZM_COMPLETE_RITUALS", "ZM_SPOT_SHADOWMAN", "ZM_GOBBLE_GUM", "ZM_STORE_KILL", "ZM_ROCKET_SHIELD_KILL", "ZM_CIVIL_PROTECTOR", "ZM_WINE_GRENADE_KILL", "ZM_MARGWA_KILL", "ZM_PARASITE_KILL", "MP_REACH_SERGEANT", "MP_REACH_ARENA", "MP_SPECIALIST_MEDALS", "MP_MULTI_KILL_MEDALS", "ZM_CASTLE_EE", "ZM_CASTLE_ALL_BOWS", "ZM_CASTLE_MINIGUN_MURDER",   "ZM_CASTLE_UPGRADED_BOW", "ZM_CASTLE_MECH_TRAPPER", "ZM_CASTLE_SPIKE_REVIVE", "ZM_CASTLE_WALL_RUNNER", "ZM_CASTLE_ELECTROCUTIONER", "ZM_CASTLE_WUNDER_TOURIST", "ZM_CASTLE_WUNDER_SNIPER", "ZM_ISLAND_COMPLETE_EE", "ZM_ISLAND_DRINK_WINE", "ZM_ISLAND_CLONE_REVIVE", "ZM_ISLAND_OBTAIN_SKULL", "ZM_ISLAND_WONDER_KILL", "ZM_ISLAND_STAY_UNDERWATER", "ZM_ISLAND_THRASHER_RESCUE", "ZM_ISLAND_ELECTRIC_SHIELD", "ZM_ISLAND_DESTROY_WEBS", "ZM_ISLAND_EAT_FRUIT", "ZM_STALINGRAD_NIKOLAI", "ZM_STALINGRAD_WIELD_DRAGON", "ZM_STALINGRAD_TWENTY_ROUNDS", "ZM_STALINGRAD_RIDE_DRAGON", "ZM_STALINGRAD_LOCKDOWN", "ZM_STALINGRAD_SOLO_TRIALS", "ZM_STALINGRAD_BEAM_KILL", "ZM_STALINGRAD_STRIKE_DRAGON", "ZM_STALINGRAD_FAFNIR_KILL", "ZM_STALINGRAD_AIR_ZOMBIES", "ZM_GENESIS_EE", "ZM_GENESIS_SUPER_EE", "ZM_GENESIS_PACKECTOMY", "ZM_GENESIS_KEEPER_ASSIST", "ZM_GENESIS_DEATH_RAY", "ZM_GENESIS_GRAND_TOUR", "ZM_GENESIS_WARDROBE_CHANGE", "ZM_GENESIS_WONDERFUL", "ZM_GENESIS_CONTROLLED_CHAOS", "DLC2_ZOMBIE_ALL_TRAPS", "DLC2_ZOM_LUNARLANDERS", "DLC2_ZOM_FIREMONKEY", "DLC4_ZOM_TEMPLE_SIDEQUEST", "DLC4_ZOM_SMALL_CONSOLATION", "DLC5_ZOM_CRYOGENIC_PARTY", "DLC5_ZOM_GROUND_CONTROL", "ZM_DLC4_TOMB_SIDEQUEST", "ZM_DLC4_OVERACHIEVER", "ZM_PROTOTYPE_I_SAID_WERE_CLOSED", "ZM_ASYLUM_ACTED_ALONE", "ZM_THEATER_IVE_SEEN_SOME_THINGS"];
    #ifdef MP
    level._Weapons             = EnumerateWeapons("weapon");
    #endif

    #ifdef ZM
    level._SynPerks               = getArrayKeys(level._custom_perks);
    level._SynPowerUps            = getArrayKeys(level.zombie_powerups);
    level._SynWeapons             = getArrayKeys(level.zombie_weapons);
    level._SynBGB          = getArrayKeys(level.bgb);
    level thread CacheGobbleGums();
    #endif
    level thread CacheWeapons();

}

onPlayerConnect()
{
    level._WeaponsMP     = StrTok("ar_standard;ar_accurate;ar_cqb;ar_damage;ar_longburst;ar_marksman;ar_fastburst;smg_standard;smg_versatile;smg_capacity;smg_fastfire;smg_burst;smg_longrange;shotgun_pump;shotgun_semiauto;shotgun_fullauto;shotgun_precision;lmg_light;lmg_cqb;lmg_slowfire;lmg_heavy;sniper_fastsemi;sniper_fastbolt;sniper_chargeshot;sniper_powerbolt;pistol_standard;pistol_burst;pistol_fullauto;launcher_standard;launcher_lockonly;knife;knife_loadout",";");
    level.TrackNames       = strTok("Samantha's Lullaby;Dead Ended;Blood of Stalingrad;King of the Hill;Samantha's Sorrow;Damned;Damned 100AE;Damned 3;The Gift;Archangel;Dead Again;The Gift;WTF;Aether;Blood Red Moon;Death Bell;Desolation;High Noon;Mask Walk;Ouest Noir;Richtofen's Delight;Samantha's Desire;Short Arm of the Law;Buried (Theme);Undone;Revelations;A Rising Power;One Way Out;Flesh and Bone;Crypt;Samantha's Journey;Remember Forever;The End Is Near;Nightmare;Not Ready To Die;Shepherd of Fire;Platform of Dreams;Legendary;Skulls of the Damned;Arachnophobia;Betrayal;Zetsubou No Shima;Through The Trees;Snake Skin Boots;Cold Hard Cash;Snake Skin Boots (Instrumental);Lullaby For a Dead Man;The One;Beauty Of Annihilation;115;Abra Cadavre;Pareidolia;Coming Home;Carrion;We All Fall Down;Always Running;Where Are We Going;Archangel;Beauty Of Annihilation (Giant Mix);Damned 3;", ";");
    level.Tracks          = strTok("mus_samanthas_lullaby_magicmix_intro;mus_dead_ended_intro;mus_blood_of_stalingrad_intro;mus_king_of_the_hill_intro;mus_samanthas_sorrow_intro;mus_damned_intro;mus_damned_2_intro;mus_damned_25_intro;mus_the_gift_intro;mus_archangel_theatrical_mix_intro;mus_dead_again_theatrical_mix_intro;mus_the_gift_theatrical_intro;mus_wtf_intro;mus_aether_intro;mus_blood_red_moon_intro;mus_death_bell_intro;mus_desolation_intro;mus_high_noon_intro;mus_maskwalk_intro;mus_quest_noir_intro;mus_richtofans_delight_intro;mus_samanthas_desire_intro;mus_short_arm_of_the_law_intro;mus_theme_from_buried_intro;mus_undone_intro;mus_revelations_intro;mus_a_rising_power_intro;mus_one_way_out_intro;mus_flesh_and_bone_intro;mus_crypt_intro;mus_sam_journey_intro;mus_remember_forever_intro;mus_the_end_is_near_intro;mus_nightmare_intro;mus_not_ready_to_die_intro;mus_shepherd_of_fire_intro;mus_platform_of_dreams_intro;mus_legendary_intro;mus_skulls_of_the_damned_intro;mus_arachnophobia_intro;mus_betrayal_intro;mus_zetsubou_no_shima_intro;mus_through_the_trees_intro;mus_snake_skin_boots_intro;mus_cold_hard_cash_intro;mus_snake_skin_intrumental_intro;mus_lullaby_for_a_dead_man_intro;mus_the_one_intro;mus_beauty_of_annihilation_intro;mus_115_intro;mus_abra_cadavre_intro;mus_pareidolia_intro;mus_coming_home_intro;mus_carrion_intro;mus_we_all_fall_down_intro;mus_always_running_intro;mus_where_are_we_going_intro;mus_archangel_intro;mus_beauty_the_giant_mix_intro;mus_zm_lobby_intro;", ";");
    
    #ifdef ZM 
    self.iPrintLn = self createText("default", 1, "LEFT", "BOTTOM", -400, -185, 3, 0, "", (1, 1, 1));
    if(isDefined(level.player_too_many_weapons_monitor))
        level.player_too_many_weapons_monitor = false; 
    #endif
}

onPlayerSpawned()
{
    #ifdef ZM
    if(isDefined(level.player_too_many_weapons_monitor))
        level.player_too_many_weapons_monitor = false;
    level flag::wait_till("initial_blackscreen_passed");
    #endif
    if(self IsHost()){
        self FreezeControls(false);
        self thread initializeSetup(5, self);
        wait 2;
        self thread welcomeMessage("^2Welcome ^4"+self.name+" To: ^5Synergy V3", "^2Your Access Level: ^1Host^3 | ^4Created By: ^5"+level.creatorName);
    }else{ self.access = 0;}
}

#ifdef ZM
CacheWeapons()
{
    level.Weapons = [];
    weapNames     = [];
    weapon_types  = ["assault", "smg", "cqb", "lmg", "sniper", "launcher", "pistol", "special"];

    foreach(weapon in level._SynWeapons)
        weapNames[weapNames.size] = weapon.name;

    for(i=0;i<weapon_types.size;i++)
    {
        level.Weapons[i] = [];
        for(e=1;e<100;e++)
        {
            weapon_categ = tableLookup("gamedata/stats/zm/zm_statstable.csv", 0, e, 2);
            weapon_name = TableLookupIString("gamedata/stats/zm/zm_statstable.csv", 0, e, 3);
            weapon_id = tableLookup("gamedata/stats/zm/zm_statstable.csv", 0, e, 4);
            if(weapon_categ == "weapon_" + weapon_types[i])
            {
                if(IsInArray(weapNames, weapon_id))
                {
                    weapon = spawnStruct();
                    weapon.name = weapon_name;
                    weapon.id = weapon_id;
                    level.Weapons[i][level.Weapons[i].size] = weapon;
                }
            }
        }
    }

    foreach(weapon in level._SynWeapons)
    {
        isInArray = false;
        for(e=0;e<level.Weapons.size;e++)
        {
            for(i=0;i<level.Weapons[e].size;i++)
                if(isDefined(level.Weapons[e][i]) && level.Weapons[e][i].id == weapon.name)
                    isInArray = true;
        } 
        if(!isInArray && weapon.displayname != "")
        {
            weapons = spawnStruct();
            weapons.name = MakeLocalizedString(weapon.displayname);
            weapons.id = weapon.name;
            level.Weapons[7][level.Weapons[7].size] = weapons;
        }
    }

    extras = ["zombie_beast_grapple_dwr", "defaultweapon", "tesla_gun"];
    extrasNames = ["Beast Weapon", "Default Weapon", "The Undead-Zapper"];
    foreach(index, extra in extras)
    {
        weapons = spawnStruct();
        weapons.name = extrasNames[index];
        weapons.id = extra;
        level.Weapons[7][level.Weapons[7].size] = weapons;
    }
}

CacheGobbleGums()
{
    level._BGBNames = [];
    for(e=0;e<level._SynBGB.size;e++)
        level._BGBNames[e] = constructString(replaceChar(getSubStr(level._SynBGB[e], 7), "_", " "));
}
#endif

#ifdef MP
CacheWeapons()
{
    level.Weapons = [];
    weapNames = [];
    weapon_types = array("assault", "smg", "cqb", "lmg", "sniper", "launcher", "pistol", "special");

    foreach(weapon in level._Weapons)
        weapNames[weapNames.size] = weapon.name;

    for(i=0;i<weapon_types.size;i++)
    {
        level.Weapons[i] = [];
        for(e=1;e<147;e++)
        {
            weapon_categ = tableLookup("gamedata/stats/mp/mp_statstable.csv", 0, e, 2);
            weapon_name  = TableLookupIString("gamedata/stats/mp/mp_statstable.csv", 0, e, 3);
            weapon_id    = tableLookup("gamedata/stats/mp/mp_statstable.csv", 0, e, 4);
            if(weapon_categ == "weapon_" + weapon_types[i])
            {
                if(IsInArray(weapNames, weapon_id))
                {
                    weapon = spawnStruct();
                    weapon.name = weapon_name;
                    weapon.id = weapon_id;
                    level.Weapons[i][level.Weapons[i].size] = weapon;
                }
            }
        }
    }

    foreach(weapon in level._Weapons)
    {
        if((killstreaks::is_killstreak_weapon(weapon) || !weapons::is_primary_weapon(weapon) || !weapons::is_side_arm(weapon)) && !IsSubStr("melee_", weapon.name))
            continue;
            
        isInArray = false;
        for(e=0;e<level.Weapons.size;e++)
        {
            for(i=0;i<level.Weapons[e].size;i++)
            {
                if(isDefined(level.Weapons[e][i]) && level.Weapons[e][i].id == weapon.name)
                {
                    isInArray = true;
                    break;
                }
            }
        } 
        if(!isInArray && weapon.displayname != "")
        {
            weapons      = spawnStruct();
            weapons.name = MakeLocalizedString(weapon.displayname);
            weapons.id   = weapon.name;
            level.Weapons[7][level.Weapons[7].size] = weapons;
        }
    }
    
    extras      = ["defaultweapon", "baseweapon"];
    extrasNames = ["Default Weapon", "Base Weapon"];
    foreach(index, extra in extras)
    {
        weapons = spawnStruct();
        weapons.name = extrasNames[index];
        weapons.id = extra;
        level.Weapons[7][level.Weapons[7].size] = weapons;
    }
}
#endif

CacheCamos()
{
    level._Camos = [];
    for(e=0;e<290;e++)
    {
        row = TableLookupRow("gamedata/weapons/common/weaponoptions.csv", e);
        
        if(!isdefined(row) || !isdefined(row.size) || row.size < 3)
            continue;
            
        if(row[1] != "camo")
            continue;
            
        level._Camos[level._Camos.size] = constructString(replaceChar(row[2], "_", " "));
    }
}

replaceChar(string, substring, replace)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(string[e] == substring)
            final += replace;
        else 
            final += string[e];
    }
    return final;
}

constructString(string)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(e == 0)
            final += toUpper(string[e]);
        else if(string[e-1] == " ")
            final += toUpper(string[e]);
        else 
            final += string[e];
    }
    return final;
}