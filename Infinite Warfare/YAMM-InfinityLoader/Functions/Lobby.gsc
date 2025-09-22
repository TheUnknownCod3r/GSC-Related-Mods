/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Lobby Mods for YAMM
*    Date : 21/09/2025 19:47:18
*
*/


NoMovingWheel()
{
    level.noMoveBox = !bool(level.noMoveBox);
    if(level.NoMoveBox){
        self iPrintLnAlt("Wheel no Move ^2Enabled");
        self thread LoopBox();
    }
    else
    {
        self iPrintLnAlt("Wheel no Move ^1Disabled");
        level.var_B162  = 1;//box ready to move
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
        if(isDefined(level.var_13d01) && level.var_13D01 > 0)//lets only run if the spins count greater than 0
            level.var_13D01 = 0;//set box spins at 0, since the check runs if > than 4 spins took place.
        wait 1;
    }
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
        scripts\common\utility::flag_set("found_missing_handle");
        zomPart = scripts\common\utility::getstructarray("mpq_zom_body_part","script_noteworthy");
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
                scripts\common\utility::flag_set("pap_portal_used");
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
    doorInteracts = scripts\common\utility::getstructarray("interaction","targetname");
    foreach(interact in doorInteracts)
    {
        doorTrigger = scripts\common\utility::getstructarray(interact.script_noteworthy,"script_noteworthy");
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
        scripts\common\utility::flag_set("restorepower_step1");
    }
    self iPrintLnAlt("Doors ^2Opened");
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

MaxBank()
{
    level.var_2416 = 2147483647;//level.var_2416 = level.atm_amount_deposited
    self iPrintLnAlt("The Bank is ^2BURSTING! ^0Balance Set to: ^2$2147483647");
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
