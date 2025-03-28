MaxRank()
{
    if(self.pers["plevel"] > 10)
    {
        self SetRank(1000);
        self S("Level 1000 ^2Set");
    }
    else{
        #ifdef ZM
        self SetRank(35);
        self S("Level 35 Set");
        #endif
        #ifdef MP
        self SetRank(55);
        self S("Level 55 ^2Set");
        #endif
    }
}
SetRank(value)
{
    #ifdef MP
    if(value > 55)
    {
        xpTable = int(tableLookup("gamedata/tables/mp/mp_paragonranktable.csv", 0, value - 56, ((value == 1000) ? 7 : 2)));
        old     = int(self GetDStat("playerstatslist", "paragon_rankxp", "statValue"));
    }
    else 
    {
        xpTable = int(tableLookup("gamedata/tables/mp/mp_ranktable.csv", 0, value - 1, ((value == 55) ? 7 : 2)));
        old     = int(self GetDStat("playerstatslist", "rankxp", "statValue"));
    }
    #endif

    #ifdef ZM
    if(value > 35)
    {
        xpTable = int(tableLookup("gamedata/tables/zm/zm_paragonranktable.csv", 0, value - 36, ((value == 1000) ? 7 : 2)));
        old = int(self GetDStat("playerstatslist", "paragon_rankxp", "statValue"));
    }
    else 
    {
        xpTable = int(tableLookup("gamedata/tables/zm/zm_ranktable.csv", 0, value - 1, ((value == 35) ? 7 : 2)));
        old = int(self GetDStat("playerstatslist", "rankxp", "statValue"));
    }
    #endif
    self AddRankXPValue("win", xpTable - old);
    wait .1;
    UploadStats(self);
    self updateCurrentMenu();
}

GetPlayerData(stat)
{
    return self GetDStat("playerstatslist", stat, "statValue");
}

SetPrestige(Prestige)
{
    self SetDStat("playerstatslist", "plevel", "StatValue", Prestige);
    self S("Prestige Set To: "+Prestige);
}

getCurrentRank()
{
    if(self.pers["plevel"] > 10 && self GetDStat("playerstatslist", "paragon_rank", "StatValue") >= 1)
    {
        return self GetDStat("playerstatslist", "paragon_rank", "StatValue") + 56;
        self.MaxRank = true;
    }
    else
    {
        return self GetDStat("playerstatslist", "rank", "StatValue") + 1;
    }
}

MaxPrestige()
{
    if(self.pers["plevel"] > 10)
    {
        self SetRank(1000);
    }
    else
    {
        #ifdef ZM self SetDStat( "playerstatslist", "rankxp", "statValue", 1375000 );self SetDStat( "playerstatslist", "rank", "statValue", 34 );self SetDStat( "playerstatslist", "pLevel", "StatValue", 10 ); #endif
        #ifdef MP self SetDStat( "playerstatslist", "rankxp", "statValue", 1457200 );self SetDStat( "playerstatslist", "rank", "statValue", 54 );self SetDStat( "playerstatslist", "plevel", "StatValue", 10 ); #endif
    }
    self S("Max Prestige ^2Awarded");
}

#ifdef ZM


grab_stats_from_table(player)
{
    player endon("disconnect");
    player.Isunlockingall = true;
    self S("Unlocking All Challenges");
    if(player GetDStat("playerstatslist", "plevel", "statValue") < 10 && player GetDStat( "playerstatslist", "paragon_rank", "statValue" ) < 964)
    {
        player SetDStat( "playerstatslist", "rankxp", "statValue", 1375000 );
        player SetDStat( "playerstatslist", "rank", "statValue", 34 );
        player SetDStat( "playerstatslist", "pLevel", "StatValue", 11 );
        player SetDStat( "playerstatslist", "paragon_rankxp", "statValue", 52345460 );
        player SetDStat( "playerstatslist", "paragon_rank", "statValue", 964 );
        UploadStats(player);
        wait 1;
    }
    
    for(value=512;value<642;value++)
    {
        stat       = spawnStruct();
        stat.value = int( tableLookup( "gamedata/stats/zm/statsmilestones3.csv", 0, value, 2 ) );
        stat.type  = tableLookup( "gamedata/stats/zm/statsmilestones3.csv", 0, value, 3 );
        stat.name  = tableLookup( "gamedata/stats/zm/statsmilestones3.csv", 0, value, 4 );
        stat.split = tableLookup( "gamedata/stats/zm/statsmilestones3.csv", 0, value, 13 );
        self P( stat.type+ " "+ stat.name+ " ^2"+ stat.value );
        switch( stat.type )
        {
            case "global":
                player setDStat("playerstatslist", stat.name, "statValue", stat.value);
                player setDStat("playerstatslist", stat.name, "challengevalue", stat.value);
            break;

            case "attachment":
                foreach( attachment in strTok(stat.split, " ") )
                {
                    player SetDStat("attachments", attachment, "stats", stat.name, "statValue", stat.value);
                    player SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", stat.value);
                    for(i = 1; i < 8; i++)
                    {
                        player SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", stat.value);
                        player SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", stat.value);
                    }
                }
            break;

            default:
                foreach( weapon in strTok(stat.split, " ") )
                {               
                    player addWeaponStat( GetWeapon( weapon ), stat.name, stat.value ); 
                    player addRankXp("kill", GetWeapon( weapon ), undefined, undefined, 1, stat.value * 2 );
                }
            break;
        }
        wait .1;
    }
    UploadStats(player);
    player CompleteMapEE(player);
    self S("Unlock all has been ^2completed");
    player.Isunlockingall = undefined;
}

CompleteMapEE(player)
{
    player endon("disconnect");
    Maps = array("zod", "castle", "island", "stalingrad", "genesis", "factory", "tomb", "theater", "prototype", "asylum", "moon", "sumpf", "cosmodrome", "temple");
    foreach(map in Maps)
    {
        player AddPlayerStat("darkops_" + map + "_ee", 1);
        player AddPlayerStat("darkops_" + map + "_super_ee", 1);
    }
}
#endif
#ifdef MP
grab_stats_from_table(player)
{
    player endon("disconnect");
    self S("^2Unlocking All Challenges");
    player.IsRunningUnlocks = true;
    if( player GetDStat( "playerstatslist", "paragon_rankxp", "statValue" ) != 52542000 )
    {
        player SetDStat( "playerstatslist", "rankxp", "statValue", 1457200 );
        player SetDStat( "playerstatslist", "rank", "statValue", 54 );
        player SetDStat( "playerstatslist", "plevel", "StatValue", 11 );
        player SetDStat( "playerstatslist", "paragon_rankxp", "statValue", 52542000 );
        player SetDStat( "playerstatslist", "paragon_rank", "statValue", 944 );
    }

    sort_stats_from_table( "mp_statstable", 0, 256, 9, 2, 3 );
    sort_stats_from_table( "statsmilestones1", 1, 239 );
    sort_stats_from_table( "statsmilestones2", 256, 483 );
    sort_stats_from_table( "statsmilestones3", 512, 767 );
    sort_stats_from_table( "statsmilestones4", 768, 929 );
    sort_stats_from_table( "statsmilestones5", 1024, 1494 );
    sort_stats_from_table( "statsmilestones6", 1500, 1515 ); 

    player unlock_all_challenges();
    player AddPlayerStat("score", 5000000);

    self SetDStat("afteractionreportstats", "lobbypopup", "none");
    self S("Unlock All ^2Done");
    player.IsRunningUnlocks = undefined;
    player.HasUnlockAll=true;
}

sort_stats_from_table( table, sIndex, eIndex, value_column = 2, type_column = 3, name_column = 4, split_column = 13 )
{
    self endon("disconnect");
    
    if( !isDefined( level.custom_stats ) )
        level.custom_stats = [];
        
    level.custom_stats[ table ] = [];
    previous = "";

    for(value=sIndex;value<eIndex+1;value++)
    {
        stat         = spawnStruct();
        stat.value   = int( tableLookup( "gamedata/stats/mp/" + table + ".csv", 0, value, value_column ) );
        stat.type    = tableLookup( "gamedata/stats/mp/" + table + ".csv", 0, value, type_column );
        stat.name    = tableLookup( "gamedata/stats/mp/" + table + ".csv", 0, value, name_column );
        stat.index   = int( tableLookup( "gamedata/stats/mp/" + table + ".csv", 0, value, 0 ) );
        
        split = tableLookup( "gamedata/stats/mp/" + table + ".csv", 0, value, split_column );
        if( isDefined( split ) && split != "" )       
            stat.split = split;

        if( previous.type != stat.type || previous.name != stat.name || previous.value > stat.value )
        {
            if( isDefined( previous ) && previous != "" )
            {
                if( previous.type != "" && previous.name != "" && previous.value > 0 )
                    level.custom_stats[ table ][ level.custom_stats[ table ].size ] = previous;
            }
        }
        previous = stat;
    }
}

unlock_all_challenges()
{
    self endon("disconnect");

    tables       = [];
    stats        = ["kills", "kills_ability", "kills_weapon", "multikill_ability", "multikill_weapon", "kill_one_game_ability", "kill_one_game_weapon", "challenge1", "challenge2", "challenge3", "challenge4", "challenge5"];
    heroes       = ["heroes_mercenary", "heroes_outrider", "heroes_technomancer", "heroes_battery", "heroes_enforcer", "heroes_trapper", "heroes_reaper", "heroes_spectre", "heroes_firebreak"];
    hero_weapons = ["HERO_MINIGUN", "HERO_LIGHTNINGGUN", "HERO_GRAVITYSPIKES", "HERO_ARMBLADE", "HERO_ANNIHILATOR", "HERO_PINEAPPLEGUN", "HERO_BOWLAUNCHER", "HERO_CHEMICALGELGUN", "HERO_FLAMETHROWER"];
    weapons      = ["smg_fastfire", "lmg_heavy", "ar_standard", "pistol_burst", "sniper_fastbolt", "shotgun_fullauto"];
    
    for(i=1;i<6;i++)
    {
        self SetDStat("prestigetokens", i, "tokentype", "prestige_extra_cac", 1);
        self SetDStat("prestigetokens", i, "tokenspent", 1);
    }

    _setStats = 0;
    for(table=1;table<7;table++)
    {
        foreach( stat in level.custom_stats[ "statsmilestones" + table ] )
        {
            self P( stat.type+ " "+ stat.name+ " ^2"+ stat.value );
            if( stat.name == "" || stat.type == "" || stat.value == 0 )
                continue;

            switch( stat.type )
            {
                case "global":
                    self SetDStat("playerstatslist", stat.name, "statValue", stat.value);
                    self SetDStat("playerstatslist", stat.name, "challengevalue", stat.value);
                    _setStats += 2;
                break;

                case "gamemode":
                    foreach( gametype in strTok(stat.split, " ") )
                    {
                        self SetDStat("PlayerStatsByGameType", gametype, stat.name, "StatValue", stat.value);
                        self SetDStat("PlayerStatsByGameType", gametype, stat.name, "challengevalue", stat.value);
                        _setStats += 2;
                    }
                break;

                case "group":
                    foreach( group_name in strTok(stat.split, " ") )
                    {
                        self SetDStat("groupstats", group_name, "stats", stat.name, "challengevalue", stat.value);
                        _setStats += 1;
                    }
                break;

                case "killstreak":
                    foreach(streak_name in strTok(stat.split + " killstreak_autoturret killstreak_helicopter_gunner", " ") )
                    {
                        self addWeaponStat(level.killstreaks[ GetSubStr( streak_name, 11 ) ].weapon, stat.name, stat.value);
                        _setStats += 1;
                    }
                break;

                case isWeapon_category( stat.type ):
                    foreach( weapon in strTok(stat.split, " ") )
                    {               
                        self addWeaponStat( GetWeapon( weapon ), stat.name, stat.value ); 
                        self addRankXp("kill", GetWeapon( weapon ), undefined, undefined, 1, stat.value * 2 );
                        wait .2;
                        
                        index = GetBaseWeaponItemIndex( GetWeapon( weapon ) );
                        if(self GetDStat("itemstats", index, "plevel") != 15)
                        {
                            self SetDStat("itemstats", index, "plevel", 15);
                            for(i = 0; i < 3; i++)
                                self SetDStat("itemstats", index, "isproversionunlocked", i, 1);
                        }
                        _setStats += 8;
                    }
                break;

                case "attachment":
                    foreach( attachment in strTok(stat.split, " ") )
                    {
                        self SetDStat("attachments", attachment, "stats", stat.name, "statValue", stat.value);
                        self SetDStat("attachments", attachment, "stats", stat.name, "challengeValue", stat.value);
                        for(i = 1; i < 8; i++)
                        {
                            self SetDStat("attachments", attachment, "stats", "challenge" + i, "statValue", stat.value);
                            self SetDStat("attachments", attachment, "stats", "challenge" + i, "challengeValue", stat.value);
                        }
                        _setStats += 20;
                    }
                break;

                case "specialist":
                    foreach( specialist in strTok(stat.split, " ") )
                    {
                        self SetDStat("specialiststats", getIndexFromName( specialist, heroes ), "stats", stat.name, "statValue", stat.value);
                        self SetDStat("specialiststats", getIndexFromName( specialist, heroes ), "stats", stat.name, "challengeValue", stat.value);
                        _setStats += 2;
                    }
                    foreach( hero_weapon in hero_weapons )
                    {
                        self addWeaponStat(GetWeapon( hero_weapon ), stat.name, stat.value);
                        self addweaponstat(GetWeapon( hero_weapon ), "used", stat.value);
                        _setStats += 2;
                    }
                break;

                case "hero":
                    break; 

                case "bonuscard":
                    for(e=178;e<188;e++)
                    {
                        self SetDStat("itemstats", e, "stats", stat.name, "statvalue", 300);
                        self SetDStat("itemstats", e, "stats", stat.name, "challengevalue", 300);
                        _setStats += 2;
                    }
                break; 

                default:
                    self P( "Unknown Data Type: "+ stat.type );
                break;
            }

            if( _setStats > 170 )
            {
                _setStats = 0;
                uploadStats( self );
                wait .2;
            }
            wait .1;
        }
        uploadStats( self );
        wait 1;
    }
}

getIndexFromName( string, array )
{
    foreach(index, name in array)
    {
        if( name == string )
            return index;
    }
    return undefined;
}

isWeapon_category( weapon )
{
    return isSubStr( weapon, "weapon_" ) ? weapon : "  ";
}
#endif


CustomKeyboard(Title = "Keyboard")
{
    KBKeys=[];
    KBKeys[0] = ["0","A","N",":"];
    KBKeys[1] = ["1","B","O",";"];
    KBKeys[2] = ["2","C","P", ">"];
    KBKeys[3] = ["3","D","Q", "$"];
    KBKeys[4] = ["4","E","R", " "];
    KBKeys[5] = ["5","F","S", "-"];
    KBKeys[6] = ["6","G","T", "*"];
    KBKeys[7] = ["7","H","U", "+"];
    KBKeys[8] = ["8","I","V", "@"];
    KBKeys[9] = ["9","J","W", "/"];
    KBKeys[10] = ["^","K","X", "_"];
    KBKeys[11] = ["!","L","Y", "{"];
    KBKeys[12] = ["?","M","Z", "}"];

    KbUI=[];
    for(i=0;i<13;i++)
    {
        KeyRow="";
        for(e=0;e<4;e++)
            KeyRow+=KBKeys[i][e]+"\n";
        KbUI["KbKeys_"+i] = createText("objective", 1.2, "LEFT", "CENTER", -125 + (i*20), -30, 4, 1, KeyRow,(1,1,1));
    }
    KbUI["Title"] = createText("objective", 1.4, "TOP", "CENTER", 0, -82, 4, 1, Title, (1,1,1));
    KbUI["Preview"] = createText("objective", 1.2, "TOP", "CENTER", 0, -55, 4,1, "", (1,1,1));
    KbUI["Instruct1"] = createText( "objective", 1, "TOP", "CENTER", 0, 30, 4, 1, "Capitals - [{+frag}] : Backspace - [{+melee}] : Confirm - [{+gostand}] : Cancel - [{+stance}]", (1,1,1) );
    KbUI["Instruct2"] = createText( "objective", 1, "TOP", "CENTER", 0, 40, 4, 1, "Up - [{+actionslot 1}] : Down - [{+actionslot 2}] : Left - [{+actionslot 3}] : Right [{+actionslot 4}]", (1,1,1) );
    KbUI["BG"] = createRectangle( "TOP", "CENTER", 0, -90, 300, 120, (0,0,0), "white", 0, .7 );
    KbUI["Result"] = createRectangle( "TOP", "CENTER", 0, -59, 300, 20, (0,0,0), "white", 1, .7 );
    KbUI["Cursor"] = createRectangle( "LEFT", "CENTER", KbUI["KbKeys_0"].x - 1, KbUI["KbKeys_0"].y, 14, 14, (1,0,0), "white", 2, .7 );
    
    result   = "";
    cursX   = 0;
    cursY   = 0;
    capitals = 1;

    while(true)
    {
        if( self ActionSlotThreeButtonPressed() )         cursX = KBCurDec( cursX, 0, 12 ); 
        else if( self ActionSlotFourButtonPressed() )     cursX = KBCurInc( cursX, 0, 12 );
        else if( self ActionSlotOneButtonPressed() )      cursY = KBCurDec( cursY, 0, 3 );
        else if( self ActionSlotTwoButtonPressed() )      cursY = KBCurInc( cursY, 0, 3 );
        else if( self JumpButtonPressed() )
            break; 
        else if( self StanceButtonPressed() )
            return self destroyAll( KbUI );
        if( self UseButtonPressed() )
        {
            result += (capitals ? toLower( KBKeys[cursX][cursY] ) : KBKeys[cursX][cursY] );
            wait .2;
        }
        else if( self MeleeButtonPressed() && result.size > 0 )
        {
            temp = "";
            for(e=0;e<result.size-1;e++)
                temp += result[e];
            result = temp;
            wait .2;
        }
        else if( self FragButtonPressed() ) 
        {
            capitals = capitals ? 0 : 1;
            for(i=0;i<13;i++)
            {
                KeyRow = "";
                for(e=0;e<4;e++)
                    KeyRow += (capitals ? (toLower( KBKeys[i][e] ) + " \n") : (KBKeys[i][e] + "\n") );
                KbUI["KbKeys_"+i] setText( KeyRow );
            }
            wait .2;
        }
        
        KbUI["Cursor"].x = KbUI["KbKeys_" + cursX].x - 4;
        KbUI["Cursor"].y = KbUI["KbKeys_0"].y + (cursY * 14.5);
        KbUI["Preview"] setText( result );
        wait .05;
    }
    self destroyAll( KbUI );
    return result;
}

KBCurInc( curs, min, max ) //12 - 3
{
    curs++;
    if( curs > max )
        curs = min;
    wait .2; 
    return curs;
}

KBCurDec( curs, max, min ) //12 - 0
{
    curs--;
    if( curs < max )
        curs = min;
    wait .2; 
    return curs;    
}

CustomTagEditor(Tag, Name)
{
    if(!IsDefined( Tag ))
    {
        self thread menuClose();
        wait .2;
        Tag = self CustomKeyboard("Clan Tag Editor");
        wait .2;
    }
    if(Tag.size == 0 && name != "None") return;
    self setDStat("clanTagStats", "clanName", Tag);
    self S("^4Clan Tag Set To: ^2"+Tag);
}