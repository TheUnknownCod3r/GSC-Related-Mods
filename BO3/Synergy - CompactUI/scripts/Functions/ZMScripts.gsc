#ifdef ZM

GiveBGB(BGBid)
{
    BGBid = level._SynBGB[BGBid];
    self thread bgb::func_b107a7f3(BGBid, 0);
    self S("Gobblegum ^2Awarded");
}
iPrintLn(String)
{
    self.iPrintLn notify("StopFade");
    self.iPrintLn.alpha = 1;
    self.iPrintLn SetText(String);
    self.iPrintLn thread hudFade(0, 4);
}  

GiveAllPerksZM()
{
	a_str_perks = getarraykeys(level._custom_perks);
	foreach(str_perk in a_str_perks)
	{
		if(!self hasperk(str_perk))
		{
			self zm_perks::give_perk(str_perk, 0);
			if(isdefined(level.perk_bought_func))
			{
				self [[level.perk_bought_func]](str_perk);
			}
		}
        wait .1;
	}
    self S("All Perks ^2Given");
}

noTarget()
{
    self.ignoreme = !bool(self.ignoreme);
    self.ignorme_count = self.ignoreMe * 999;
    self S("No Target " + (!self.ignoreme ? "^1OFF" : "^2ON") );
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
    self endon("gameModeChanged");

    self PlayLocalSound("mus_egg_intro");
    self.hasUnlocked = false;
    self thread welcomeMessage("^4Old School ^3Prestige Lobby", "^5Made by ^6"+level.creatorName);
    wait 2;
    self S("^1Get a Kill to get Max Prestige And All Unlocks");
    for(;;)
    {
        self waittill("zom_kill");
        if(self.hasUnlocked == false)
        {
            self S("^2MAX PRESTIGE WAS JUST AWARDED");
            self SetDStat("playerstatslist", "plevel", "statvalue", 11);
            self SetDStat("playerstatslist", "paragon_rank", "statvalue", 964);
            self SetDStat("playerstatslist", "paragon_rankxp", "statvalue", 52345460);
            wait 2;
            self thread grab_stats_from_table(self);
            self.hasUnlocked = true;
        }
    }wait .02;
}
OldSchoolChallenges()
{
    self S("Unlock All ^2Started");
    self SetDStat("playerstatslist", "kills", "StatValue", randomIntRange(1000000, 3000000));
    self SetDStat("playerstatslist", "melee_kills", "StatValue", randomIntRange(10000, 30000));
    self SetDStat("playerstatslist", "grenade_kills", "StatValue", randomIntRange(10000, 30000));
    self SetDStat("playerstatslist", "revives", "StatValue", randomIntRange(1000, 3000));
    self SetDStat("playerstatslist", "headshots", "StatValue", randomIntRange(100000, 700000));
    self SetDStat("playerstatslist", "hits", "StatValue", randomIntRange(10000000, 30000000));
    self SetDStat("playerstatslist", "misses", "StatValue", randomIntRange(1000000, 30000000));
    self SetDStat("playerstatslist", "total_shots", "StatValue", randomIntRange(10000000, 30000000));
    self SetDStat("playerstatslist", "time_played_total", "StatValue", randomIntRange(1000000, 3000000));
    self SetDStat("playerstatslist", "perks_drank", "StatValue", randomIntRange(10000, 30000));
    for(value=512;value<642;value++)
    {
        stat       = spawnStruct();
        stat.value = int(tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 2));
        stat.type  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 3);
        stat.name  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 4);
        stat.split = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 13);
        self P( stat.type+ " "+ stat.name+ " ^2"+ stat.value );
        switch(stat.type)
        {
            case "global":
                self setDStat("playerstatslist", stat.name, "statValue", stat.value);
                self setDStat("playerstatslist", stat.name, "challengevalue", stat.value);
            break;

            case "attachment":
                foreach(attachment in strTok(stat.split, " "))
                {
                    self SetDStat("attachments", attachment, "stats", stat.name, "statValue", stat.value);
                    self SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", stat.value);
                    for(i = 1; i < 8; i++)
                    {
                        self SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", stat.value);
                        self SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", stat.value);
                    }
                }
            break;

            default:
                foreach(weapon in strTok(stat.split, " "))
                {               
                    self addWeaponStat(GetWeapon(weapon), stat.name, stat.value); 
                    self addRankXp("kill", GetWeapon(weapon), undefined, undefined, 1, stat.value * 2);
                }
            break;
        }
        wait .1;
    }
    UploadStats(self);
    self SetDStat("playerstatslist", "DARKOPS_GENESIS_SUPER_EE", "StatValue", 1);
    self addplayerstat("DARKOPS_GENESIS_SUPER_EE", 1);
    self addplayerstat("darkops_zod_ee", 1);
    self addplayerstat("darkops_factory_ee", 1);
    self addplayerstat("darkops_castle_ee", 1);
    self addplayerstat("darkops_island_ee", 1);
    self addplayerstat("darkops_stalingrad_ee", 1);
    self addplayerstat("darkops_genesis_ee", 1);
    self addplayerstat("darkops_zod_super_ee", 1);
    self addplayerstat("darkops_factory_super_ee", 1);
    self addplayerstat("darkops_castle_super_ee", 1);
    self addplayerstat("darkops_island_super_ee", 1);
    self addplayerstat("darkops_stalingrad_super_ee", 1);
    wait .1;
    for(i = 0; i < 255; i++)
    {
        self SetDStat("itemstats", i, "stats", "used", "statvalue", randomIntRange(50, 400));
    }
    maps = ["zm_zod", "zm_castle", "zm_island", "zm_stalingrad", "zm_genesis", "zm_factory", "zm_tomb", "zm_theater", "zm_prototype", "zm_asylum", "zm_moon", "zm_sumpf", "zm_cosmodrome", "zm_temple"]; // thx feb for this array

    foreach(map in maps)
    {
        self setdstat("playerstatsbymap", map, "stats", "total_rounds_survived", "statvalue", randomIntRange(1000, 2000));
        self setdstat("playerstatsbymap", map, "stats", "highest_round_reached", "statvalue", randomIntRange(60, 130));
        self setdstat("playerstatsbymap", map, "stats", "total_downs", "statvalue", randomIntRange(100, 500));
        self setdstat("playerstatsbymap", map, "stats", "total_games_played", "statvalue", randomIntRange(100, 500));
    }
    self S("Unlock All ^2Completed! You may now End The Game");
    UploadStats(self);
}

ChangeTehRound( target_round )
{
    level notify("restart_round");

    target_round -= 1;
    if(target_round < 1)
        target_round = 1;
        
    level.zombie_total = 0;
    zombie_utility::ai_calculate_health(target_round);
    world.var_48b0db18 = target_round ^ 115;
    level killAllZombies();
}

killAllZombies()
{
    level notify("restart_round");
    zombies = getAIArray();
    if(isdefined(zombies))
    {
        for(i = 0; i < zombies.size; i++)
            zombies[i] DoDamage(zombies[i].health + 1, zombies[i].origin);
    }
}

toggle_all_boxes()
{
    if(!isDefined(level.show_all_boxes))
    {
        level.show_all_boxes = true;
        self S("Show All Magic Boxes ^2ON");
        Array::thread_all(level.chests, ::show_mystery_box);
        Array::thread_all(level.chests, ::enable_all_chests);
        Array::thread_all(level.chests, ::fire_sale_box_fix);

        if(GetDvarString("magic_chest_movable") == "1")
            setDvar("magic_chest_movable", "0");
    }   
    else if(level.show_all_boxes != "waiting")
    {
        self S("Show All Magic Boxes ^1OFF");
        level notify("stop_showing_all_boxes");
        level.show_all_boxes = "waiting";

        Array::thread_all(level.chests, ::remove_mystery_box);
        if(!isDefined(level.BoxCantMove))
            setDvar("magic_chest_movable", "1");
    }
}
     
fire_sale_box_fix()
{
    level endon("stop_showing_all_boxes");
    while(true)
    {
        level waittill("fire_sale_off");
        self.was_temp = undefined;
    }
}

enable_all_chests()
{
    level endon("stop_showing_all_boxes");
    while(isDefined(self)) 
    {
        self.zbarrier waittill("closed");
        thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, zm_magicbox::magicbox_unitrigger_think);
    }
}

get_chest_index()
{
    foreach(index, chest in level.chests)
    {
        if(self == chest)
            return index;
    }
    return undefined;
}

show_mystery_box()
{
    if(self zm_magicbox::is_chest_active() || self get_chest_index() == level.chest_index)
        return;
        
    self thread zm_magicbox::show_chest(); 
}

DownClient(player)
{
    if(isDefined(player.godmode))
        player thread Godmode();
    wait .1;
    player notify("entering_last_stand");
    player.maxhealth = 0;
    player.health    = player.maxhealth;
    player doDamage(self.health + 1, player.origin);
    self S(player.name+" ^2Downed!");
}


remove_mystery_box(chest_index = self get_chest_index())
{
    if(chest_index == level.chest_index)
        return;
    if(!isDefined(level.removing_count))
        level.removing_count = 0;
    
    while(self.hidden)
        wait .1;

    level.chests[chest_index].was_temp = 1;
    zm_powerup_fire_sale::remove_temp_chest(chest_index);

    level.removing_count++;
    if(level.removing_count == level.chests.size - 1)
    {
        level.show_all_boxes = undefined;
        level.removing_count = 0;
    }
}

ChangeBoxPrice(i)
{
    switch(i)
    {
        case 0: foreach(box in level.chests) box.zombie_cost = 0; self S("Box Price Set To: ^2Free");break;
        case 1: foreach(box in level.chests) box.zombie_cost = 950; self S("Box Set To ^1Default Price");break;
        case 2: foreach(box in level.chests) box.zombie_cost = -1337; self S("Box Price Set To: ^2-1337");break;
        case 3: foreach(box in level.chests) box.zombie_cost = 1337; self S("Box Price Set To: ^11337");break;
        case 4: foreach(box in level.chests) box.zombie_cost = 5000; self S("Box Price Set To: ^15000");break;
        case 5: foreach(box in level.chests) box.zombie_cost = -5000; self S("Box Price Set To: ^2-5000");break;
        case 6: foreach(box in level.chests) box.zombie_cost = 10; self S("Box Price Set To: ^110");break;
        case 7: foreach(box in level.chests) box.zombie_cost = -10; self S("Box Price Set To: ^2-10");break;
    }
}

FreezeTheBox()
{
    if(!isDefined(level.BoxCantMove))
    {
        level.BoxCantMove=true;
        self S("Mystery Box ^2Frozen in Place!");
        setDvar("magic_chest_movable", "0");
    }
    else
    {
        level.BoxCantMove=undefined;
        self S("Mystery Box ^1No longer Frozen");
        setDvar("magic_chest_movable", "0");
    }
}

EditScore(Val, Func, player)
{
    if(Func == "Give")
    {
        player zm_score::add_to_player_score(Val);
        player S("Score Set To: ^2"+Val);
    }
    else if(Func == "Take")
    {
        player zm_score::minus_to_player_score(Val);
        player S("Score Set To Negative Value Of: ^1"+Val);
    }
}
OpenAllDoors()//Open_Sesame from zm_devgui altered
{
	setdvar("zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 1);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int + 1);
		}
	}
	players = getplayers();
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
		{
			zombie_doors[i] notify("trigger", players[0]);
			if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
			{
				zombie_doors[i] notify("power_on");
			}
			wait(0.05);
		}
		zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
		for(i = 0; i < zombie_airlock_doors.size; i++)
		{
			zombie_airlock_doors[i] notify("trigger", players[0]);
			wait(0.05);
		}
		zombie_debris = getentarray("zombie_debris", "targetname");
		for(i = 0; i < zombie_debris.size; i++)
		{
			if(isdefined(zombie_debris[i]))
			{
				zombie_debris[i] notify("trigger", players[0]);
			}
			wait(0.05);
		}
		level notify("open_sesame");
		wait(1);
		setdvar("zombie_unlock_all", 0);
    self S("Doors ^2Opened");
}

UpgradeWeapon(player, weapon)
{
    player TakeWeapon(weapon);
    wait .1;
    player GiveWeapon( player zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon) ) );
    player SwitchToWeapon( player zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon) ) );
    player S("Your current weapon has been upgraded!");
}

GetTehMap()
{
    if(level.script == "zm_prototype")return "nzp"; //nacht der untoten nzp//zetsubou no shima nzs// verruckt nza//shi no numa nzs//Credits  cred//The giant nzf//der eisendrache de//Revelations rev//gorod krovi gk//Shadows of Evil soe//Origins origins// Moon moon// ascension ascen//Kino der toten kino//Shangri la shang
    if(level.script == "zm_asylum")return "nza"; 
    if(level.script == "zm_sumpf")return "nzs"; 
    if(level.script == "credits")return "cred"; 
    if(level.script == "zm_factory")return "nzf"; 
    if(level.script == "zm_castle")return "de"; 
    if(level.script == "zm_island")return "zns"; 
    if(level.script == "zm_genesis")return "rev"; 
    if(level.script == "zm_stalingrad")return "gk"; 
    if(level.script == "zm_zod")return "soe"; 
    if(level.script == "zm_tomb")return "origins"; 
    if(level.script == "zm_moon")return "moon"; 
    if(level.script == "zm_cosmodrome")return "ascen"; 
    if(level.script == "zm_theater")return "kino"; 
    if(level.script == "zm_temple")return "shang"; 
}

GunGameInit()
{
    self thread ChangeTehRound(15);
    wait .2;
    foreach(client in level.players)
    {
        client thread GunGameStart();
    }
}

GunGameStart()//Credit Partially to Zeiiken for his BO2 Gun Game for Gr3zz
{
    self endon("disconnect");
    self endon("game_ended");
    self endon("death");
    self thread welcomeMessage("^1Welcome ^4to ^2Gun ^4Game", "^6Created ^1By ^3"+level.creatorName);
    wait 4;
    WeapKeys = getArrayKeys(level.zombie_weapons);
    Weaps = array::randomize(WeapKeys);
    self takeAllWeapons();
    wait .1;
    self giveWeapon(Weaps[0]);
    self switchToWeapon(Weaps[0]);
    for(w=1;w<Weaps.size-1;w++)
    {
        self waittill("zom_kill");
        self S("^3You Got A Kill!, ^2Weapon Awarded: ^1"+Weaps[w].name+ ", ^4Kill Count: ^6"+w);
        self takeAllWeapons();
        self GiveWeapon(Weaps[w]);
        self switchToWeapon(Weaps[w]);
    }
}

EndGameGG(winner)
{
    foreach(client in level.players)
        client S("^1Gun ^2Game ^4ENDED! ^6Winner Is: "+winner.name);
    wait 2;
    level notify("end_game");
}

shadowsuishow(val)
{
    self clientfield::set_player_uimodel(val, 1);
    wait 3.5;
    self clientfield::set_player_uimodel(val, 0);
}

ShadowsEEAll(step)
{
    level.shadowsEESteps = ["Pack a Punch", "Eggs", "Swords", "Swords Upgraded", "Flag Step", "Boss Fight", "Full Egg"];
    foreach(prereq in level.shadowsEESteps)
    {
        ShadowsEE(prereq);
        wait .25;
        if(step == prereq)
            break;
    }
    self iPrintLnBold("Step achieved");
}
CustomDiviniumSlider(Amount, player)
{
    player thread GiveLiquidDiviniums(Amount);
}

LiquidDiviniums()
{
    self.var_f191a1fc = self.var_f191a1fc + 250;
    self ReportLootReward("3", 250);
    uploadstats(self);
    wait 1;
}

GiveLiquidDiviniums(amount)
{
    ammount = amount / 250;
    for(e=0;e<ammount;e++)
        self LiquidDiviniums();
    self iPrintLnBold("^1DEBUG: ^7Liquid Diviniums Done");
    level.players[0] iPrintLnBold("[^1HOST^7] Liquid Done for Client");
}
DoStats(which, player)
{
    switch(which)
    {
        case 0:     player SetDStat("playerstatslist", "kills", "StatValue", randomIntRange(100000, 300000));player SetDStat("playerstatslist", "melee_kills", "StatValue", randomIntRange(10000, 30000));player SetDStat("playerstatslist", "grenade_kills", "StatValue", randomIntRange(10000, 30000));player SetDStat("playerstatslist", "revives", "StatValue", randomIntRange(1000, 3000));player SetDStat("playerstatslist", "headshots", "StatValue", randomIntRange(10000, 70000));player SetDStat("playerstatslist", "hits", "StatValue", randomIntRange(10000000, 30000000));player SetDStat("playerstatslist", "misses", "StatValue", randomIntRange(100000, 3000000));player SetDStat("playerstatslist", "total_shots", "StatValue", randomIntRange(1000000, 3000000));player SetDStat("playerstatslist", "time_played_total", "StatValue", randomIntRange(100000, 300000));player SetDStat("playerstatslist", "perks_drank", "StatValue", randomIntRange(10000, 30000));for(value=512;value<642;value++){stat       = spawnStruct();stat.value = int(tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 2));stat.type  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 3);stat.name  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 4);stat.split = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 13);switch(stat.type){case "global":player setDStat("playerstatslist", stat.name, "statValue", stat.value);player setDStat("playerstatslist", stat.name, "challengevalue", stat.value);break;case "attachment":foreach(attachment in strTok(stat.split, " ")){player SetDStat("attachments", attachment, "stats", stat.name, "statValue", stat.value);player SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", stat.value);for(i = 1; i < 8; i++){player SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", stat.value);player SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", stat.value);}}break;default:foreach(weapon in strTok(stat.split, " ")){player addWeaponStat(GetWeapon(weapon), stat.name, randomIntRange(10000, 30000)); player addRankXp("kill", GetWeapon(weapon), undefined, undefined, 1, stat.value * 2);}break;}wait .1;}UploadStats(player);player SetDStat("playerstatslist", "DARKOPS_GENESIS_SUPER_EE", "StatValue", 1);player addplayerstat("DARKOPS_GENESIS_SUPER_EE", 1);player addplayerstat("darkops_zod_ee", 1);player addplayerstat("darkops_factory_ee", 1);player addplayerstat("darkops_castle_ee", 1);player addplayerstat("darkops_island_ee", 1);player addplayerstat("darkops_stalingrad_ee", 1);player addplayerstat("darkops_genesis_ee", 1);player addplayerstat("darkops_zod_super_ee", 1);player addplayerstat("darkops_factory_super_ee", 1);player addplayerstat("darkops_castle_super_ee", 1);player addplayerstat("darkops_island_super_ee", 1);player addplayerstat("darkops_stalingrad_super_ee", 1);wait .1;for(i = 0; i < 255; i++){player SetDStat("itemstats", i, "stats", "used", "statvalue", randomIntRange(50, 400));}maps = ["zm_zod", "zm_castle", "zm_island", "zm_stalingrad", "zm_genesis", "zm_factory", "zm_tomb", "zm_theater", "zm_prototype", "zm_asylum", "zm_moon", "zm_sumpf", "zm_cosmodrome", "zm_temple"]; foreach(map in maps){player setdstat("playerstatsbymap", map, "stats", "total_rounds_survived", "statvalue", randomIntRange(1000, 2000));player setdstat("playerstatsbymap", map, "stats", "highest_round_reached", "statvalue", randomIntRange(30, 130));player setdstat("playerstatsbymap", map, "stats", "total_downs", "statvalue", randomIntRange(100, 500));player setdstat("playerstatsbymap", map, "stats", "total_games_played", "statvalue", randomIntRange(100, 500));}player iPrintLnBold("Legit Stats ^2Set");UploadStats(player); break;
        case 1:     player SetDStat("playerstatslist", "kills", "StatValue", randomIntRange(1000000, 3000000));player SetDStat("playerstatslist", "melee_kills", "StatValue", randomIntRange(10000, 300000));player SetDStat("playerstatslist", "grenade_kills", "StatValue", randomIntRange(10000, 300000));player SetDStat("playerstatslist", "revives", "StatValue", randomIntRange(10000, 30000));player SetDStat("playerstatslist", "headshots", "StatValue", randomIntRange(100000, 700000));player SetDStat("playerstatslist", "hits", "StatValue", randomIntRange(10000000, 3000000000));player SetDStat("playerstatslist", "misses", "StatValue", randomIntRange(1000000, 30000000));player SetDStat("playerstatslist", "total_shots", "StatValue", randomIntRange(1000000, 30000000));player SetDStat("playerstatslist", "time_played_total", "StatValue", randomIntRange(1000000, 3000000));player SetDStat("playerstatslist", "perks_drank", "StatValue", randomIntRange(100000, 300000));for(value=512;value<642;value++){stat       = spawnStruct();stat.value = int(tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 2));stat.type  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 3);stat.name  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 4);stat.split = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 13);switch(stat.type){case "global":player setDStat("playerstatslist", stat.name, "statValue", stat.value);player setDStat("playerstatslist", stat.name, "challengevalue", stat.value);break;case "attachment":foreach(attachment in strTok(stat.split, " ")){player SetDStat("attachments", attachment, "stats", stat.name, "statValue", stat.value);player SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", stat.value);for(i = 1; i < 8; i++){player SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", stat.value);player SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", stat.value);}}break;default:foreach(weapon in strTok(stat.split, " ")){player addWeaponStat(GetWeapon(weapon), stat.name, randomIntRange(100000, 300000)); player addRankXp("kill", GetWeapon(weapon), undefined, undefined, 1, stat.value * 2);}break;}wait .1;}UploadStats(player);player SetDStat("playerstatslist", "DARKOPS_GENESIS_SUPER_EE", "StatValue", 1);player addplayerstat("DARKOPS_GENESIS_SUPER_EE", 1);player addplayerstat("darkops_zod_ee", 1);player addplayerstat("darkops_factory_ee", 1);player addplayerstat("darkops_castle_ee", 1);player addplayerstat("darkops_island_ee", 1);player addplayerstat("darkops_stalingrad_ee", 1);player addplayerstat("darkops_genesis_ee", 1);player addplayerstat("darkops_zod_super_ee", 1);player addplayerstat("darkops_factory_super_ee", 1);player addplayerstat("darkops_castle_super_ee", 1);player addplayerstat("darkops_island_super_ee", 1);player addplayerstat("darkops_stalingrad_super_ee", 1);wait .1;for(i = 0; i < 255; i++){player SetDStat("itemstats", i, "stats", "used", "statvalue", randomIntRange(500, 4000));}maps = ["zm_zod", "zm_castle", "zm_island", "zm_stalingrad", "zm_genesis", "zm_factory", "zm_tomb", "zm_theater", "zm_prototype", "zm_asylum", "zm_moon", "zm_sumpf", "zm_cosmodrome", "zm_temple"];foreach(map in maps){player setdstat("playerstatsbymap", map, "stats", "total_rounds_survived", "statvalue", randomIntRange(10000, 32000));player setdstat("playerstatsbymap", map, "stats", "highest_round_reached", "statvalue", randomIntRange(110, 180));player setdstat("playerstatsbymap", map, "stats", "total_downs", "statvalue", randomIntRange(1000, 6000));player setdstat("playerstatsbymap", map, "stats", "total_games_played", "statvalue", randomIntRange(1000, 15000));}player iPrintLnBold("Professional Stats ^2Set");UploadStats(player);break;
        case 2:     player SetDStat("playerstatslist", "kills", "StatValue", 2147483647);player SetDStat("playerstatslist", "melee_kills", "StatValue", 2147483647);player SetDStat("playerstatslist", "grenade_kills", "StatValue", 2147483647);player SetDStat("playerstatslist", "revives", "StatValue", 2147483647);player SetDStat("playerstatslist", "headshots", "StatValue", 2147483647);player SetDStat("playerstatslist", "hits", "StatValue", 2147483647);player SetDStat("playerstatslist", "misses", "StatValue", 2147483647);player SetDStat("playerstatslist", "total_shots", "StatValue", 2147483647);player SetDStat("playerstatslist", "time_played_total", "StatValue", 2147483647);player SetDStat("playerstatslist", "perks_drank", "StatValue", 2147483647);for(value=512;value<642;value++){stat       = spawnStruct();stat.value = int(tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 2));stat.type  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 3);stat.name  = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 4);stat.split = tableLookup("gamedata/stats/zm/statsmilestones3.csv", 0, value, 13);switch(stat.type){case "global":player setDStat("playerstatslist", stat.name, "statValue", 2147483647);player setDStat("playerstatslist", stat.name, "challengevalue", 2147483647);break;case "attachment":foreach(attachment in strTok(stat.split, " ")){player SetDStat("attachments", attachment, "stats", stat.name, "statValue", 2147483647);player SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", 2147483647);for(i = 1; i < 8; i++){player SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", 2147483647);player SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", 2147483647);}}break;default:foreach(weapon in strTok(stat.split, " ")){player addWeaponStat(GetWeapon(weapon), stat.name, 2147483647); player addRankXp("kill", GetWeapon(weapon), undefined, undefined, 1, 2147483647);}break;}wait .1;}UploadStats(player);player SetDStat("playerstatslist", "DARKOPS_GENESIS_SUPER_EE", "StatValue", 1);player addplayerstat("DARKOPS_GENESIS_SUPER_EE", 1);player addplayerstat("darkops_zod_ee", 1);player addplayerstat("darkops_factory_ee", 1);player addplayerstat("darkops_castle_ee", 1);player addplayerstat("darkops_island_ee", 1);player addplayerstat("darkops_stalingrad_ee", 1);player addplayerstat("darkops_genesis_ee", 1);player addplayerstat("darkops_zod_super_ee", 1);player addplayerstat("darkops_factory_super_ee", 1);player addplayerstat("darkops_castle_super_ee", 1);player addplayerstat("darkops_island_super_ee", 1);player addplayerstat("darkops_stalingrad_super_ee", 1);wait .1;for(i = 0; i < 255; i++){player SetDStat("itemstats", i, "stats", "used", "statvalue", 2147483647);}maps = ["zm_zod", "zm_castle", "zm_island", "zm_stalingrad", "zm_genesis", "zm_factory", "zm_tomb", "zm_theater", "zm_prototype", "zm_asylum", "zm_moon", "zm_sumpf", "zm_cosmodrome", "zm_temple"];foreach(map in maps){player setdstat("playerstatsbymap", map, "stats", "total_rounds_survived", "statvalue", 2147483647);player setdstat("playerstatsbymap", map, "stats", "highest_round_reached", "statvalue", 2147483647);player setdstat("playerstatsbymap", map, "stats", "total_downs", "statvalue", 2147483647);player setdstat("playerstatsbymap", map, "stats", "total_games_played", "statvalue", 2147483647);}player iPrintLnBold("Insane Stats ^2Set");UploadStats(player);break;
    }
}

SKeyGrab(player)
{
    level clientfield::set("quest_key");
    level flag::set("quest_key_found");
    level.var_c913a45f = 1;
    location = player geteye() + VectorScale(anglesToForward(player getplayerangles()), 10);

    key = GetEnt("quest_key_pickup", "targetname");
    key.origin = location;
    key.unitrigger_stub.origin = location;
    while(!isdefined(level._unitriggers.trigger_pool[player GetEntityNumber()]))
        wait .025;
    
    level._unitriggers.trigger_pool[player GetEntityNumber()] notify("trigger", player);
    player thread shadowsuishow("zmInventory.widget_quest_items");
    
    self iPrintLnBold("Obtained the Summoning Key!");
}

ShadowsEE(step)
{
    switch(step)
    {
        case "Pack a Punch":
        if(isdefined(level.var_c0091dc4["pap"].var_46491092))
        {
            foreach(person in Array("boxer", "detective", "femme", "magician"))
                level thread [[ level.var_c0091dc4[person].var_46491092 ]](person);

            foreach(var_c8d6ad34 in Array("pap_basin_1", "pap_basin_2", "pap_basin_3", "pap_basin_4"))
                level flag::set(var_c8d6ad34);

            level flag::set("pap_altar");
            level thread [[ level.var_c0091dc4["pap"].var_46491092 ]]("pap");
        }
        break;
        case "Eggs":
            locker = level.var_ca7eab3b;
            locker.var_116811f0 = 3;
            foreach(var_22f3c343 in locker.var_5475b2f6)
                var_22f3c343 ghost();
            
            for(i = 0; i < 10; i++)
            {
                if(isdefined(locker.var_2c51c4a[i]))
                    [[locker.var_2c51c4a[i]]]();
            }

            foreach(correct in locker.var_75a61704)
            {
                correct notify("trigger", self);
            }
        break;
        case "Swords":
            foreach(player in level.players)
            {
                if(player.sessionstate == "spectator")
                {
                    if (isDefined(player.spectate_hud))
                    {
                        player.spectate_hud destroy();
                    }
                    player [[ level.spawnplayer ]]();
                    wait 1;
                }
                AdjustPlayerSword(player, "Normal", false);
            }
            wait .25;
        break;
        case "Swords Upgraded":
            foreach(player in level.players)
            {
                if(player.sessionstate == "spectator")
                {
                    if (isDefined(player.spectate_hud))
                    {
                        player.spectate_hud destroy();
                    }
                    player [[ level.spawnplayer ]]();
                    wait 1;
                }
                AdjustPlayerSword(player, "Upgraded", false);
            }
            level flag::set("ee_begin");
        break;
        case "Flag Step":
            level flag::set("ee_book");
            level clientfield::set("ee_keeper_boxer_state", 1);
            level clientfield::set("ee_keeper_detective_state", 1);
            level clientfield::set("ee_keeper_femme_state", 1);
            level clientfield::set("ee_keeper_magician_state", 1);
            wait .25;
            foreach(person in Array("boxer", "detective", "femme", "magician"))
            {
                level flag::set("ee_keeper_" + person + "_resurrected");
                level clientfield::set("ee_keeper_" + person + "_state", 3);
            }
            wait 7.5;
        break;
        case "Boss Fight":
            level.var_421ff75e = 1; //ensure solo easter egg is possible
            FinishBossfight();
        break;
        case "Full Egg":
            while(!(level flag::get("ee_superworm_present")))
                wait 1;
            wait 2;
            level clientfield::set("ee_superworm_state", 2);
            foreach(flag in Array("ee_district_rail_electrified_1", "ee_district_rail_electrified_2", "ee_district_rail_electrified_3", "ee_final_boss_keeper_electricity_0", "ee_final_boss_keeper_electricity_1", "ee_final_boss_keeper_electricity_2"))
            {
                level flag::set(flag);
            }
            level flag::clear("ee_superworm_present");
        break;
    }

}

FinishBossfight()
{
    level flag::set("ee_boss_defeated");
    level notify(#"hash_a881e3fa");
    level notify(#"hash_fbc505ba");
    if(isdefined(level.var_dbc3a0ef) && isdefined(level.var_dbc3a0ef.var_93dad597))
    {
        level.var_dbc3a0ef.var_93dad597 delete();
    }
    foreach(person in Array("boxer", "detective", "femme", "magician"))
    {
        if(isdefined(level.var_f86952c7["boss_1_" + person]))
        {
            zm_unitrigger::unregister_unitrigger(level.var_f86952c7["boss_1_" + person]);
        }
        level clientfield::set( "ee_keeper_" + person + "_state", 7);
        wait 0.1;
    }
}


AdjustPlayerSword(player, type, noprint=false)
{
    if(!isdefined(level.var_15954023.weapons))
        level.var_15954023.weapons = [];

    if(!isDefined(level.var_15954023.weapons[player.originalindex]))
    {
        return;
    }
    
    weapon = level.var_15954023.weapons[player.originalindex][1];
    switch(type)
    {
        case "Normal":
             weapon = level.var_15954023.weapons[player.originalindex][1];
        break;

        case "Upgraded":
            weapon = level.var_15954023.weapons[player.originalindex][2];
        break;

        default:
            player takeWeapon(level.var_15954023.weapons[player.originalindex][1]);
            player takeWeapon(level.var_15954023.weapons[player.originalindex][2]);
            if(!noprint)
                self iPrintLnBold("Sword Updated");
            return;
    }

    player.sword_power = 1;
    player notify(#"hash_b29853d8");
    if(isdefined(player.var_c0d25105))
    {
        player.var_c0d25105 notify("returned_to_owner");
    }
    player.var_86a785ad = 1;
    player notify(#"hash_b29853d8");
    player zm_weapons::weapon_give(weapon, 0, 0, 1);
    player GadgetPowerSet(0, 100);
    player.current_sword = player.current_hero_weapon;

    if(!noprint)
        self iPrintLnBold("Sword Updated");
}
    
SoloEE(player)
{
    level.var_421ff75e = true;
    self iPrintLnBold("Solo egg enabled");
}
#endif