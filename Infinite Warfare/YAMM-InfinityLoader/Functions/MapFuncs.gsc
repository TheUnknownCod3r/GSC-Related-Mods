/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : Map Specific Opts for IW
*    Date : 21/09/2025 18:00:18
*
*/

PlayAudioToClients(audioFile)
{
    foreach(player in level.players)
    {
        if(level.script == "cp_zmb")
        { 
            level thread [[level.force_song_func]](undefined,audioFile,undefined,undefined,undefined,undefined); 
        }
        else{
            level thread scripts\cp\zombies\zombie_jukebox::force_song((649,683,254),audioFile);
        }
    }
}

CompleteGnS()
{
    self lib_0D59::use_activate_gns_machine("activate_gns_machine");
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);//notifyactivationprogress
}



GetNeilPart(partNum)
{
    switch(partNum)
    {
        case 0 : self playlocalsound("neil_part_pickup"); scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEC5);level.var_BEC5.var_BEC5 delete();level.var_BEC7 = 1;set_quest_icon(7); break;
        case 1 : self playLocalSound("neil_part_pickup"); playfx(level._effect["souvenir_pickup"],level.var_BEAE.part.origin);scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEAE);level.var_BEAE.part delete();level.var_BEB0 = 1; set_quest_icon(8); break;
        case 2 : self playlocalsound("neil_part_pickup");playfx(level._effect["souvenir_pickup"],level.var_BEC1.part.origin);scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEC1);level.var_BEC1.part delete();level.var_BEC3 = 1;set_quest_icon(9); break;
    }
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
    scripts\common\utility::flag_set("dj_request_defense_done");
    foreach(var_01 in level.players)
    {
        var_01 setclientomnvar("zm_special_item",5);
    }
    scripts\common\utility::flag_set("tone_generators_given");
}

beast_open_sesame() 
{ //credit syndishanx, I was lazy.
    scripts\common\utility::flag_set("neil_head_found");
    scripts\common\utility::flag_set("neil_head_placed");
    scripts\common\utility::flag_set("restorepower_step1");
    scripts\common\utility::flag_set("power_on");
    level notify("power_on");
    
    set_quest_icon(6);
    var_00 = scripts\common\utility::getstructarray("neil_head","script_noteworthy");
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

GrabSetiComParts()
{
    self pick_up_djquest_part("dj_quest_part_1","zmb_frequency_device_radio");
    self pick_up_djquest_part("dj_quest_part_2","zmb_frequency_device_calculator");
    self pick_up_djquest_part("dj_quest_part_3","zmb_frequency_device_umbrella_ground");
}

GrabTheSeticom()
{
    scripts\common\utility::flag_set("dj_request_defense_done");
    foreach(player in level.players)
    {
        player setclientomnvar("zm_special_item",3);
    }
}

pick_up_djquest_part(tagName,quest_part)
{
    if(level.var_5738 == true && level.var_5739 == true && level.var_573A == true)
    {
        scripts\common\utility::flag_set("dj_fetch_quest_completed");
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

GiveTickets(Amount)
{
    self scripts\cp\zombies\arcade_game_utility::func_8317(self, Amount);
    self iPrintLnAlt("Awarded ^1"+amount+" Tickets");
}   

//shaolin Stuff

mahjong_win_sequence(param_00)
{
    clear_outline_for_all_players(param_00);
    wait(0.5);
    var_01 = spawn("script_model",param_00.origin);
    var_01 setmodel("sb_quest_origin");
    var_01 setscriptablepartstate("vfx","fireworks_sparks");
    playsoundatpos(param_00.origin,"mahjong_success_fireworks");
    wait(3);
    var_01 delete();
    level notify("mahjong_won_sequence_complete");
}

clear_outline_for_all_players(player)
{
    foreach(client in level.players)
    {
        for(i = 1;i <= 14;i++)
        {
            player.mahjong_set[i].mahjong_tile hudoutlinedisableforclient(client);//engine call, safe as is
        }
    }
}
