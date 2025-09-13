/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : theunknowncod3r
*    Game : Call of Duty: Infinite Warfare
*    Description : Main Mods GSC File
*    Date : 13/09/2025 01:05:50
*
*/

Godmode()
{
    self.godmode = !bool(self.godmode);
    if(self.godmode)
    {
        self iPrintLnAlt("Godmode ^2Enabled");
    }
    else{
        self iPrintLnAlt("Godmode ^1Disabled");
    }
}

no_clip() {
    self.noclip = !bool(self.noclip);
    if(self.noclip) {
        self iPrintLnAlt("No Clip [^2ON^7]");
        thread UpdateSessionState("spectator");
    } else {
    self iPrintLnAlt("No Clip [^1OFF^7]");
    thread UpdateSessionState("playing");
    }
}
UpdateSessionState(param_00,param_01)
{
    self.sessionstate = param_00;
    if(!isdefined(param_01))
    {
        param_01 = "";
    }

    self.var_2C7 = param_01;
    self setclientomnvar("ui_session_state",param_00);
}

ToggleAmmo() {
    self.UnlimAmmo = !bool(self.UnlimAmmo);
    if(self.UnlimAmmo) {
        self iPrintLnAlt("Infinite Ammo [^2ON^7]");
        enable_infinite_ammo(self.UnlimAmmo);
    } else {
        self iPrintLnAlt("Infinite Ammo [^1OFF^7]");
        enable_infinite_ammo(self.UnlimAmmo);
    }
    while (self.UnlimAmmo)
    {
        self setWeaponAmmoClip(self getCurrentWeapon(), 999);
        self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
        self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
        self scripts\cp\powers\coop_powers::func_D71A(2, "primary", 2);
        self scripts\cp\powers\coop_powers::func_D71A(2, "secondary", 2);
        wait .2;
    }
}
enable_infinite_ammo(param_00)
{
    if(param_00)
    {
        self.infiniteammocounter++;
        self setclientomnvar("zm_ui_unlimited_ammo",1);
        return;
    }

    if(self.infiniteammocounter > 0)
    {
        self.infiniteammocounter--;
    }

    if(!self.infiniteammocounter)
    {
        self setclientomnvar("zm_ui_unlimited_ammo",0);
    }
}

//Function Number: 150
isinfiniteammoenabled()
{
    return self.infiniteammocounter >= 1;
}

 
AddScore(amount, player)
{
    player setplayerdata("cp","alienSession", "currency", player getplayerdata("cp","alienSession","currency") + int(amount));
    player iPrintLnAlt("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}
TakeScore(amount, player)
{
    player setplayerdata("cp","alienSession", "currency", player getplayerdata("cp","alienSession","currency") - int(amount) );
    player iPrintLnAlt("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}
MaxScore( player )
{
    player setplayerdata("cp","alienSession", "currency", self.var_B48A );
    player iPrintLnAlt("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}

ActivateFAF(card, player)
{
    switch(card)
    {
        case "anywhere_but_here" : player thread lib_0D59::func_12FA2(undefined); break;
    }
}

AllPerks()
{
    self thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_5FB7(self);
    self iPrintLnAlt("^2All perks have been given");
}
SpeedToggle()//per player speed
{
    self.speedToggle = !bool(self.speedToggle);
    if(self.speedToggle){
        self iPrintLnAlt("Speed Toggle Enabled");
        self thread MonitorSpeed();//have to do this cause the game resets movespeedscale on frames
    }
    else{
        self IprintLnAlt("Speed Toggle ^1Disabled");
        self setmovespeedscale(1);
        self notify("end_speed");
    }
}

EditSpeed(speed)
{
    if(!self.speedToggle){ self iPrintLnAlt("Error, Speed Toggle Not Enabled"); return;}
    self.speedValue = speed;
    self iPrintLnAlt("Player Speed Set to "+speed);
}
MonitorSpeed()
{
    self endon("disconnect");
    self endon("end_speed");
    if(!isDefined(self.speedValue)) self.speedValue = 1;
    for(;;)
    {
        self setmovespeedscale(self.speedValue);//have to loop since speed resets per frames
        wait 1;
    }
}
