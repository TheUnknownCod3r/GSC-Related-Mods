/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : An empty canvas for anything you want!
*    Date : 14/09/2025 03:32:22
*
*/

GiveWeaponToPlayer(weapon, player) 
{
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
        if(self scripts\cp\_utility::has_zombie_perk("perk_machine_more")) maxWeapons = 4; else maxWeapons = 3;
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


build_custom_weapon(weapon, camo, extra_attachments) 
{
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

dropweapon(player)
{
    player method_80B8(player getcurrentweapon());//method_80B8 = DropItem
    player iPrintLnAlt("^2Oops, you ^1Dropped ^2Something");
}

FillFAF()
{   
    self notify("meter_full");
    self.var_4561 = 1;
    self setclientomnvar("zm_dpad_up_activated",1);
    self.var_4563 = get_max_meter();
    self setclientomnvar("zm_dpad_up_fill",5000);
    self setweaponammoclip("super_default_zm",1);
    self thread lightbar_on();
    self.var_4561 = 1;
    self setclientomnvar("zm_consumable_selection_ready",1);
    self lib_0D59::func_5B00();
    self iPrintLnAlt("Fate and Fortune Filled. Buy something to Update");
}

get_max_meter() {
    var_00 = 1250;
    if(self.var_3A52 == 1) {
        var_00 = 3000;
    }
    else if(self.var_3A52 >= 2) {
        var_00 = 5000;
    }

    return var_00;
}

givePillagedLoot( equipment )
{
    thread scripts\cp\powers\coop_powers::func_8397(equipment, "primary", undefined, undefined, undefined, 0, 1);
    self playlocalsound("grenade_pickup");
}

lightbar_on() {
    self setclientomnvar("lb_gsc_controlled",1);
    self setclientomnvar("lb_color",0);
    self setclientomnvar("lb_pulse_time",1);
}