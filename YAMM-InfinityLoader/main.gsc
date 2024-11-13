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
#include scripts\cp\zombies\direct_boss_fight;
#include scripts\cp\zombies\zombie_jukebox;
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
        self thread on_event();
        self thread on_ended();
        level thread RainbowColor();
    }
}
on_event() {
    self endOn("disconnect");
    while (true) {
        if(self isHost())
        {
            level.hostname = self.name;
            self freezeControls(false);
            self thread initializeSetup(5, self);
            self thread welcomeMessage("^4Welcome ^2"+self.name+" ^7to ^5"+level.patchName, "^4Your Access Level: ^2"+GetAccessName(self.access)+"^7, ^1Created by: ^5"+level.creatorName);
            
        }
        else { self.access = 0;}
        break;
    }
}

on_ended() {
    level waitTill("game_ended");
    
    level notify("on_close_ended");
    level endOn("on_close_ended");
}
InitializeMenu()
{
    level.Status           = ["^1Unverified", "^3Verified", "^4VIP", "^6Admin", "^5Co-Host", "^2Host"];
    level.RGB              = ["Red", "Green", "Blue"];
    level.patchName        = "YetAnotherModMenu";
    level.creatorName      = "TheUnknownCoder";
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
    level.RaveNames        = ["Golf Club", "Spiked Bat", "2 Headed Axe", "Machete", "Harpoon Gun 1", "Harpoon Gun 2", "Harpoon Gun 3", "Harpoon Gun 4"];
    level.ShaolinWeaps     = ["iw7_katana_zm", "iw7_nunchucks_zm", "iw7_fists_zm_crane", "iw7_fists_zm_snake", "iw7_fists_zm_dragon", "iw7_fists_zm_tiger", "iw7_fists_zm_monkey"];
    level.ShaolinNames     = ["Katana", "Nunchucks", "Crane Chi", "Snake Chi", "Dragon Chi", "Tiger Chi", "Monkey Chi"];
    level.AttackWeaps      = ["iw7_cutie_zm"];
    level.AttackNames      = ["Modular Atomic Disintegrator"];
    level.BeastWeaps       = ["iw7_venomx_zm"];                                   
    level.BeastNames       = ["Venom-X"];
    level.otherWeaps       = ["iw7_fists_zm", "iw7_entangler_zm"];
    level.OtherNames       = ["Fists", "Entangler"];
    level.trapNames        = ["Sentry Turret","Fireworks Trap","Medusa Device","Electric Trap","Boombox","Revocator","Kindle Pops","Lazer Window Trap"];
    if(level.script == "cp_zmb"){ level.jailPos = (3356.53,-996.361, -195.873); level.freePos = (640.463,919.658,0.126336);} else if(level.script == "cp_rave") { } else if(level.script == "cp_disco") { }
}

iPrintLnAlt(String)
{
    if(!isDefined(self.iPrintLnAlt)) { self.iPrintLnAlt = self createText("objective", 1, "left", "bottom",0, -185, 3, 1, String, (1, 1, 1));}
    else { self.iPrintLnAlt setText(String); }
    self.iPrintLnAlt.alpha = 1;
    self.iPrintLnAlt thread hudfade(0,4);
}  

createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, movescale, isLevel)
{  
    textElem = (isDefined(isLevel) ? newClientHudElem(self) : newHudElem());
    textElem.font = font;
    textElem.fontscale = fontScale;
    textElem.alpha = alpha;
    textElem.sort = sort;
    textElem.foreground = true;
    textElem.hideWhenInMenu = (self.menuSetting["MenuStealth"] ? true : false);
    textElem.archived = (self.menuSetting["MenuStealth"] ? false : true);
    if(IsDefined(movescale))
        x += self.menuSetting["MenuX"];
        
    if(IsDefined(movescale))
        y += self.menuSetting["MenuY"];
    textElem.x = x;
    textElem.y = y;
    textElem.alignX = align;
    textElem.alignY = relative;
    textElem.horzAlign = align;
    textElem.vertAlign = relative;
    //textElem scripts\cp\utility::setpoint(align, relative, x, y);//Doesn't seem to work? Sadge
    if(color != "rainbow")
        textElem.color = color;
    else
        textElem.color = level.rainbowColour;
    textElem.text = text;
    textElem setText(text);
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, movescale, isLevel)
{
    boxElem = (isDefined(isLevel) ? newClientHudElem(self) : newHudElem());
    boxElem.elemType="icon";
    boxElem.children=[];
    if(IsDefined(movescale))
        x += self.menuSetting["MenuX"];
        
    if(IsDefined(movescale))
        y += self.menuSetting["MenuY"];
    boxElem.alpha=alpha;
    boxElem.sort = sort;
    boxElem.archived       = (self.menuSetting["MenuStealth"] ? false : true);
    boxElem.foreground = true;
    boxElem.hidden = false;
    boxElem.hideWhenInMenu = true;
    boxElem.x = x;
    boxElem.y = y;
    boxElem.alignX = align;
    boxElem.alignY = relative;
    boxElem.horzAlign = align;
    boxElem.vertAlign = relative;
    //boxElem scripts\cp\utility::setpoint(align, relative, x, y);
    if(color != "rainbow")
        boxElem.color = color;
    else
        boxElem thread doRainbow();
    
    boxElem setShader(shader, width, height);
    return boxElem;
}

affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
        
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}

hudMoveX(x, time)
{
    self moveOverTime(time);
    self.x = x;
    wait time;
}
hudFade(alpha, time)
{
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

fadeToColor(colour, time)
{
    self endon("colors_over");
    self fadeOverTime(time);
    self.color = colour;
}

GetPresetColours(ID)
{
    RGB = [(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 0), (0, 1, 1), (1, .5, 0), (1, 0, 1), (1, 1, 1)];
    return RGB[ID];
}
GetTrapNames()
{
    return "sentry|fireworks|medusa|electric|boombox|revocator|gascan|windowtrap";
}
GetColoursSlider(Bool)
{
    return (IsDefined(Bool) ? "|Red|Green|Blue|Yellow|Cyan|Orange|Purple|White" : "Black|Red|Green|Blue|Yellow|Cyan|Orange|Purple|White");
}

getName()
{
    return self.name;
}

round(val)
{
    val = val + "";
    new_val = "";
    for(e=0;e<val.size;e++)
    {
        new_val += val[e];
        if(val[e-1] == "." && e > 1)
            return new_val;
    }
    return val;
}

ArrayRandomize(array)
{
    for(i=0;i<array.size;i++)
    {
        j    = RandomInt(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

bool(variable)
{
    return isdefined(variable) && int(variable);
}

GetFloatString(String)
{
  setDvar("Temp", String);
  return GetDvarFloat("Temp");
}

doRainbow(Fade)
{
    if(self.shader == "gradient_fadein")
    {
        if(IsDefined(Fade))
            self fadeToColor(level.GradRain, .5);
        else
            self.color = level.GradRain;
    }
    else
    {
        if(IsDefined(Fade))
            self fadeToColor(level.NonGradRain, .5);
        else
            self.color = level.NonGradRain;
    }
    
    wait .1;
    
    self endon("StopRainbow");
    while(IsDefined(self))
    {
        if(self.shader == "gradient_fadein")
            wait 1.3;
            
        self thread fadeToColor(level.rainbowColour, 1);
        wait 1;
    }
}

RainbowChecks()
{
    while(true)
    {
        level.GradRain = level.rainbowColour;
        wait 1.3;
        level.NonGradRain = level.rainbowColour;
        wait 1;
    }
}

RainbowColor()
{
    rainbow = spawnStruct();
    rainbow.r = 255;
    rainbow.g = 0;
    rainbow.b = 0;
    rainbow.stage = 0;
    time = 5;
    level.rainbowColour = (0, 0, 0);
    thread RainbowChecks();
    for(;;)
    {
        if(rainbow.stage == 0)
        {
            rainbow.b += time;
            if(rainbow.b == 255)
                rainbow.stage = 1;
        }
        else if(rainbow.stage == 1)
        {
            rainbow.r -= time;
            if(rainbow.r == 0)
                rainbow.stage = 2;
        }
        else if(rainbow.stage == 2)
        {
            rainbow.g += time;
            if(rainbow.g == 255)
                rainbow.stage = 3;
        }
        else if(rainbow.stage == 3)
        {
            rainbow.b -= time;
            if(rainbow.b == 0)
                rainbow.stage = 4;
        }
        else if(rainbow.stage == 4)
        {
            rainbow.r += time;
            if(rainbow.r == 255)
                rainbow.stage = 5;
        }
        else if(rainbow.stage == 5)
        {
            rainbow.g -= time;
            if(rainbow.g == 0)
                rainbow.stage = 0;
        }
        level.rainbowColour = (rainbow.r / 255, rainbow.g / 255, rainbow.b / 255);
        wait .05;
    }
}

destroyAll(array)
{
    if(!isDefined(array))
        return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
    if(isDefined(array[keys[a]][0]))
        for(e=0;e<array[keys[a]].size;e++)
            array[keys[a]][e] destroy();
    else
        array[keys[a]] destroy();
}

IsInArray(array, element)
{
   if(!isdefined(element))
        return false;
        
   foreach(e in array)
        if(e == element)
            return true;
}

initializeSetup(access, player, allaccess)
{
    if(access == player.access && !IsDefined(player.isHost) && isDefined(player.access))
        return;
        
    if(isDefined(player.access) && player.access == 5)
        return; 
        
    player notify("end_menu");
    
    if(bool(player.menu["isOpen"]))
        player menuClose();
        
    player.menu         = [];
    player.previousMenu = [];
    player.PlayerHuds   = [];
    player.menu["isOpen"] = false;
    player.menu["isLocked"] = false;
    
    if(!isDefined(player.menu["current"]))
        player.menu["current"] = "main";
        
    player.access = access;
    
    if(player.access != 0)
    {
        player thread menuMonitor();
        player menuOptions();
        player.menuSetting["HUDEdit"] = true;
        player thread MenuLoad();
        player iPrintLn("You have Been Given "+GetAccessName(access));
        //player thread PrintMenuControls();
    }
}

AllPlayersAccess(access)
{
    foreach(player in level.players)
    {
        if(player IsHost() || player == self)
            continue;
            
        self thread initializeSetup(access, player, true);
        
        wait .1;
    }
}

GetAccessName(Val)
{
    Status = ["Unverified", "Verified", "VIP", "Admin", "Co-Host", "Host"];
    return Status[Val];
}

MenuSave()
{
    SaveDesgin = 
        SetMenuBool(self.menuSetting["MenuFreeze"]) +";"+
        SetMenuBool(self.menuSetting["MenuStealth"]) +";"+
        (self.menuSetting["BannerGradRainbow"] != "rainbow" ? 0 : "1") +";"+
        (self.menuSetting["ScrollerGradRainbow"] != "rainbow" ? 0 : "1") +";"+
        (self.menuSetting["BackgroundGradRainbow"] != "rainbow" ? 0 : "1") +";"+
        (self.menuSetting["BannerNoneRainbow"] != "rainbow" ? 0 : "1") +";"+
        round(self.menuSetting["ScrollerGradColor0"]) +";"+
        round(self.menuSetting["ScrollerGradColor1"]) +";"+
        round(self.menuSetting["ScrollerGradColor2"]) +";"+
        round(self.menuSetting["BackgroundGradColor0"]) +";"+
        round(self.menuSetting["BackgroundGradColor1"]) +";"+
        round(self.menuSetting["BackgroundGradColor2"]) +";"+
        round(self.menuSetting["BannerNoneColor0"]) +";"+
        round(self.menuSetting["BannerNoneColor1"]) +";"+
        round(self.menuSetting["BannerNoneColor2"]) +";"+
        round(self.menuSetting["BannerGradColor0"]) +";"+
        round(self.menuSetting["BannerGradColor1"]) +";"+
        round(self.menuSetting["BannerGradColor2"]) +";"+
        self.menuSetting["MenuX"] +";"+
        self.menuSetting["MenuY"] +";"+
        SetMenuBool(self.menuSetting["MenuGodmode"]) +";"+
        SetMenuBool(self.menuSetting["ShowClientINFO"]);
    
    setDvar(self getName() + "MenuDesign", SaveDesgin);
}

MenuLoad(Val)
{  
    if(!isdefined(self.menuSetting))
        self.menuSetting = [];
        
    MenuDefaults = strTok("0;1;1;1;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;1",";");
    
    if(!IsDefined(Val) || IsDefined(Val) && Val == 0)
    {
        
        if(GetDvar(self getName() + "MenuDesign").size > 0)
        {
            dvar         = GetDvar(self getName() + "MenuDesign"); 
            MenuDefaults = strTok(dvar, ";");
        }
    }
    
    self.menuSetting["MenuFreeze"] = GetMenuBool(MenuDefaults[0]);
    self.menuSetting["MenuGodmode"] = GetMenuBool(MenuDefaults[20]);
    self.menuSetting["MenuStealth"] = GetMenuBool(MenuDefaults[1]);
    self.menuSetting["ShowClientINFO"] = GetMenuBool(MenuDefaults[21]);
    
    self.menuSetting["ScrollerGradColor0"] = int(MenuDefaults[6]);
    self.menuSetting["ScrollerGradColor1"] = int(MenuDefaults[7]);
    self.menuSetting["ScrollerGradColor2"] = int(MenuDefaults[8]);
    
    self.menuSetting["BackgroundGradColor0"] = int(MenuDefaults[9]);
    self.menuSetting["BackgroundGradColor1"] = int(MenuDefaults[10]);
    self.menuSetting["BackgroundGradColor2"] = int(MenuDefaults[11]);
    
    self.menuSetting["BannerNoneColor0"] = int(MenuDefaults[12]);
    self.menuSetting["BannerNoneColor1"] = int(MenuDefaults[13]);
    self.menuSetting["BannerNoneColor2"] = int(MenuDefaults[14]);
    
    self.menuSetting["BannerGradColor0"] = int(MenuDefaults[15]);
    self.menuSetting["BannerGradColor1"] = int(MenuDefaults[16]);
    self.menuSetting["BannerGradColor2"] = int(MenuDefaults[17]);
    
    self.menuSetting["BannerGradRainbow"] = (MenuDefaults[2] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[15]), GetFloatString(MenuDefaults[16]), GetFloatString(MenuDefaults[17])));
    self.menuSetting["ScrollerGradRainbow"] = (MenuDefaults[3] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[6]), GetFloatString(MenuDefaults[7]), GetFloatString(MenuDefaults[8])));
    self.menuSetting["BackgroundGradRainbow"] = (MenuDefaults[4] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[9]), GetFloatString(MenuDefaults[10]), GetFloatString(MenuDefaults[11])));
    self.menuSetting["BannerNoneRainbow"] = (MenuDefaults[5] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[12]), GetFloatString(MenuDefaults[13]), GetFloatString(MenuDefaults[14])));
    
    self.menuSetting["MenuX"] = int(MenuDefaults[18]);
    self.menuSetting["MenuY"] = int(MenuDefaults[19]);
    
    if(IsDefined(Val) && Val == 1 || IsDefined(Val) && Val == 0)
    {
        self menuClose();
        waittillframeend;
        self menuOpen();
    }
}

GetMenuBool(String)
{
    return (String == "1" ? true : false);
}

SetMenuBool(variable)
{
    return (isdefined(variable) && int(variable) ? "1" : "0");
}

FreezeInMenu()
{
    self.menuSetting["MenuFreeze"] = !bool(self.menuSetting["MenuFreeze"]);
    self FreezeControls(self.menuSetting["MenuFreeze"] ? true : false);
}

MenuStealth()
{
    self.menuSetting["MenuStealth"] = !bool(self.menuSetting["MenuStealth"]);
}

MenuGodmode()
{
    self.menuSetting["MenuGodmode"] = !bool(self.menuSetting["MenuGodmode"]);
}

ShowClientINFO()
{
    self.menuSetting["ShowClientINFO"] = !bool(self.menuSetting["ShowClientINFO"]);
}

MoveMenu()
{
    self menuClose();
    
    MenuVisTemp = [];
    
    MenuVisTemp["BG"] = self createRectangle("LEFT", "TOP", 0, 90, 170, int(7*15) + 45, (0,0,0), "white", 0, .6, true);
    MenuVisTemp["TITLE"] = self createText("objective", 1.5, "CENTER", "TOP", -340, 95, 0, 1, "Menu Reposition", (1, 1, 1), true);
    MenuVisTemp["INFO0"] = self createText("objective", 1.2, "CENTER", "TOP", -340, 120, 0, 1, "Movement Controls", (1, 1, 1), true);
    MenuVisTemp["INFO1"] = self createText("objective", 1, "CENTER", "TOP", -340, 140, 0, 1, "UP - [{+attack}] DOWN - [{+speed_throw}]", (1, 1, 1), true);
    MenuVisTemp["INFO2"] = self createText("objective", 1, "CENTER", "TOP", -340, 160, 0, 1, "LEFT - [{+smoke}] RIGHT - [{+frag}]", (1, 1, 1), true);
    MenuVisTemp["INFO3"] = self createText("objective", 1, "CENTER", "TOP", -340, 180, 0, 1, "CONFIRM PLACEMENT - [{+activate}]", (1, 1, 1), true);
    MenuVisTemp["INFO4"] = self createText("objective", 1, "CENTER", "TOP", -340, 200, 0, 1, "DISCARD CHANGES - [{+melee}]", (1, 1, 1), true);
    
    X = self.menuSetting["MenuX"];
    Y = self.menuSetting["MenuY"];
    
    while(self useButtonPressed())
        wait .05;
    
    while(!self meleeButtonPressed())
    {
        if(self attackButtonPressed())
        {
            Y += 10;
            foreach(HUD in MenuVisTemp)
                HUD.y += 10;
                
            wait .15;
        }
            
        if(self adsButtonPressed())
        {
            Y -= 10;
            foreach(HUD in MenuVisTemp)
                HUD.y -= 10;
                
            wait .15;
        }
       
        if(self FragButtonPressed())
        {
            X += 10;
            foreach(HUD in MenuVisTemp)
                HUD.x += 10;
                
            wait .15;
        }
            
        if(self SecondaryOffhandButtonPressed())
        {
            X -= 10;
            foreach(HUD in MenuVisTemp)
                HUD.x -= 10;
                
            wait .15;
        }
        
        if(self useButtonPressed())
        {
            self.menuSetting["MenuX"] = X;
            self.menuSetting["MenuY"] = Y;
            break;
        }
        
        wait .05;
    }
    
    while(self useButtonPressed() || self meleeButtonPressed())
        wait .05;
    
    self destroyAll(MenuVisTemp);
    self menuOpen();
}

MenuToggleRainbow(HUD)
{
    if(HUD == "Banner")
    {
        self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")] = (IsString(self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")]) ? 0 : "rainbow");
 
        if(!IsString(self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")]))
        {
            for(e=0;e<3;e++)
                self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneColor" : "GradColor") + e] = level.rainbowColour[e];
                
            self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")] = "rainbow";
        }
        
        if(IsString(self.menuSetting["BannerNoneRainbow"]))
            self.menu["UI"]["BGTitle"] thread doRainbow(true);
            
        if(IsString(self.menuSetting["BannerGradRainbow"]))
            self.menu["UI"]["BGTitle_Grad"] thread doRainbow(true);
    } 
    else
    {
        self.menuSetting[HUD + "GradRainbow"] = (IsString(self.menuSetting[HUD + "GradRainbow"]) ? 0 : "rainbow");
  
        if(!IsString(self.menuSetting[HUD + "GradRainbow"]))
        {
            for(e=0;e<3;e++)
                self.menuSetting[HUD + "GradColor" + e] = level.rainbowColour[e];
                
            self.menuSetting[HUD + "GradRainbow"] = "rainbow";
        }
        
        if(IsString(self.menuSetting["ScrollerGradRainbow"]))
            self.menu["UI"]["SCROLL"] thread doRainbow(true);
            
        if(IsString(self.menuSetting["BackgroundGradRainbow"]))
            self.menu["UI"]["OPT_BG"] thread doRainbow(true);
    }
}

MenuPreSetCol(Val,HUD,Bool)
{
    Size    = (HUD == "Banner" ? 1 : 0);
    SizeMax = (HUD == "Banner" ? 4 : 3);
    menu    = self getCurrentMenu();
    
    if(!IsDefined(Bool))
    {
        RGB = GetPresetColours(Val);
        for(e=Size;e<SizeMax;e++)
            if(IsDefined(self.sliders[menu + "_" + e]))
                self.sliders[menu + "_" + e] = undefined;
    }
    else
    {
        for(e=Size;e<SizeMax;e++)
            if(!IsDefined(self.sliders[menu+"_"+e]))
                self.sliders[menu + "_" + e] = 0;
        
        RGB = (HUD == "Banner" ? (self.sliders[menu + "_1"] / 255, self.sliders[menu + "_2"] / 255, self.sliders[menu+"_3"] / 255) : (self.sliders[menu + "_0"] / 255, self.sliders[menu + "_1"] / 255, self.sliders[menu + "_2"] / 255));
    }
   
    if(HUD == "Background")
    {
        self.menu["UI"]["OPT_BG"] notify("StopRainbow");
        self.menu["UI"]["OPT_BG"] thread fadeToColor(RGB, .5);
    }
        
    if(HUD == "Scroller")
    {
        self.menu["UI"]["SCROLL"] notify("StopRainbow");
        self.menu["UI"]["SCROLL"] thread fadeToColor(RGB, .5);
    }
        
    if(HUD == "Banner")
    {
        SliderCheck = self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")];
        
        if(bool(self.menuSetting["HUDEdit"]))
        {
            self.menu["UI"]["BGTitle"] notify("StopRainbow");
            self.menu["UI"]["BGTitle"] thread fadeToColor(RGB, .3);
        }
        else
        {
            self.menu["UI"]["BGTitle_Grad"] notify("StopRainbow");
            self.menu["UI"]["BGTitle_Grad"] thread fadeToColor(RGB, .3);
        }
        
        for(e=0;e<3;e++)
            self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneColor" : "GradColor") + e] = RGB[e];
            
        self.menuSetting[HUD + (bool(self.menuSetting["HUDEdit"]) ? "NoneRainbow" : "GradRainbow")] = (RGB[0],RGB[1],RGB[2]);
            
        return;
    }
    
    for(e=0;e<3;e++)
        self.menuSetting[HUD + "GradColor" + e] = RGB[e];
        
    self.menuSetting[HUD + "GradRainbow"] = (RGB[0],RGB[1],RGB[2]);
}

drawMenu()
{  
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["UI"]))
        self.menu["UI"] = [];
    self.menu["UI"]["OPT_BG"] = self createRectangle("left", "top", 0, 90, 170, int(numOpts*15) + 45, self.menuSetting["BackgroundGradRainbow"], "white", 0, 1, true);
    self.menu["UI"]["OPT_BG"] affectElement("alpha", .2, .6);
    
    self.menu["UI"]["BGTitle"] = self createRectangle("left", "top", 0, 90, 170, 30, self.menuSetting["BannerNoneRainbow"], "white", 1, 1, true);
    self.menu["UI"]["BGTitle"] affectElement("alpha",.2,.6);
    
    self.menu["UI"]["BGTitle_Grad"] = self createRectangle("left", "top", 0, 90, 170, 30, self.menuSetting["BannerGradRainbow"], "white", 3, 0, true);
    self.menu["UI"]["BGTitle_Grad"] affectElement("alpha", .2, .6);
    
    self.menu["UI"]["CUR_TITLE"] = self createRectangle("left", "center", 0, -112, 170, 15, (0, 0, 0), "white", 4, 0, true);
    self.menu["UI"]["CUR_TITLE"] affectElement("alpha",.2, 1);
    
    self.menu["UI"]["SCROLL"] = self createRectangle("left", "top", 0, -5, 170, 16, self.menuSetting["ScrollerGradRainbow"], "white", 3, 0, true);
    self.menu["UI"]["SCROLL"] affectElement("alpha", .2, .6);
}

drawText()
{
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["OPT"]))
        self.menu["OPT"] = [];
    if(!IsDefined(self.menu["OPT"]["OPTScroll"]))
        self.menu["OPT"]["OPTScroll"] = [];
    self.menu["OPT"]["TITLE"] = self createText("objective", 1.5, "CENTER", "TOP", -340, 95, 10, 0, "YetAnotherModMenu", (1, 1, 1), true);
    self.menu["OPT"]["TITLE"] affectElement("alpha",.4,1);
    
    self.menu["OPT"]["SUB_TITLE"] = self createText("objective", .75, "CENTER", "TOP", -340, 120, 10, 0, self.menuTitle, (1, 1, 1), true);
    self.menu["OPT"]["SUB_TITLE"] affectElement("alpha", .4, 1);
    
    self.menu["OPT"]["OPTSize"] = self createText("objective", .75, "center", "TOP", -270, 120, 10, 0, self getCursor() + 1 + "/" + self.eMenu.size, (1, 1, 1), true);
    self.menu["OPT"]["OPTSize"] affectElement("alpha",.4, 1);
    
    for(e=0;e<8;e++)
    {
        self.menu["OPT"][e] = self createText("objective", 1, "left", "TOP", 5, 132 + e*15, 4, 1, "", (1, 1, 1), true);
        self.menu["OPT"][e] affectElement("alpha",.4, 1);
    }

    self setMenuText();
}

setMenuText()
{
    ary = (self getCursor() >= 8 ? self getCursor()-7 : 0);
    for(e=0;e<8;e++)
    {
        if(IsDefined(self.menu["OPT"]["OPTScroll"][e]))
            self.menu["OPT"]["OPTScroll"][e] destroy();
        
        if(isDefined(self.menu["OPT"][e]))
        {
            self.menu["OPT"][e].color = ((isDefined(self.eMenu[ary + e].toggle) && self.eMenu[ary + e].toggle) ? (0, 1, 0) : (1, 1, 1));
            self.menu["OPT"][e] setText(self.eMenu[ary + e].opt);
        }
        if(IsDefined(self.eMenu[ary + e].val)){
            self.menu["OPT"]["OPTScroll"][e] = self createText("objective", 1, "center", "TOP", -285, 132 + e*15, 5, 1, "" + ((!isDefined(self.sliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].val : self.sliders[self getCurrentMenu() + "_" + (ary + e)]), (1, 1, 1), true);
        }
        if(IsDefined(self.eMenu[ary + e].optSlide)){
            self.menu["OPT"]["OPTScroll"][e] = self createText("objective", 1, "center", "TOP", -285, 132 + e*15, 5, 1, ((!isDefined(self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].optSlide[0] + " [" + 1 + "/" + self.eMenu[ary + e].optSlide.size + "]" : self.eMenu[ary + e].optSlide[self.Optsliders[self getCurrentMenu() + "_" + (ary + e)]] + " [" + ((self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])+1) + "/" + self.eMenu[ary + e].optSlide.size + "]"), (1, 1, 1), true);
        }
    }
}

resizeMenu()
{
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    self.menu["UI"]["OPT_BG"] setShader("white", 170, int(numOpts*15) + 45);
}

refreshTitle()
{
    self.menu["OPT"]["SUB_TITLE"] setText(self.menuTitle);
}

refreshOPTSize()
{
    self.menu["OPT"]["OPTSize"] setText(self getCursor() + 1 + "/" + self.eMenu.size);
}

menuMonitor()
{
    self endon("disconnect");
    self endon("end_menu");
    while(self.access != 0)
    {
        if(!self.menu["isLocked"])
        {
            if(!self.menu["isOpen"])
            {
                if(self meleeButtonPressed() && self adsButtonPressed())
                {
                    self playLocalSound("ww_magicbox_laughter");
                    self menuOpen();
                    wait .2;
                }
            }
            else
            {
                if((self attackButtonPressed() || self adsButtonPressed()))
                {
                    CurrentCurs = self getCurrentMenu() + "_cursor";

                    self.menu[CurrentCurs]+= self attackButtonPressed();
                    self.menu[CurrentCurs]-= self adsButtonPressed();
                
                    self scrollingSystem();
                    self PlayLocalSound("mouse_over");
                    wait .2;
                }
            
                if(self FragButtonPressed() || self SecondaryOffhandButtonPressed())
                {
                    Menu = self.eMenu[self getCursor()];
                    if(self SecondaryOffhandButtonPressed())
                    {
                        if(IsDefined(Menu.optSlide))
                        {
                            self updateOptSlider("L2");
                            Func = self.Optsliders;
                        }
                        else if(IsDefined(Menu.val))
                        {
                            self updateSlider("L2");
                            Func = self.sliders;
                        }
                    }
                    if(self FragButtonPressed())
                    {
                        if(IsDefined(Menu.optSlide))
                        {
                            self updateOptSlider("R2");
                            Func = self.Optsliders;
                        }
                        else if(IsDefined(Menu.val))
                        {
                            self updateSlider("R2");
                            Func = self.sliders;
                        }
                    }

                    if(IsDefined(Menu.toggle))
                        self UpdateCurrentMenu();
                  
                    wait .12;
                }
            
                if(self useButtonPressed())
                {
                    Menu = self.eMenu[self getCursor()];
                    self PlayLocalSound("ui_consumable_meter_full");
                
                    if(IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()])){
                        slider = self.sliders[ self getCurrentMenu() + "_" + self getCursor() ];
                        slider = (IsDefined( menu.List1 ) ? menu.List1[slider] : slider);
                        self thread doOption(Menu.func, slider, Menu.p1, Menu.p2, Menu.p3,menu.p4,menu.p5);
                    }
                    else if(IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
                        self thread doOption(Menu.func, self.Optsliders[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                    else
                        self thread doOption(Menu.func, Menu.p1, Menu.p2, Menu.p3, Menu.p4, Menu.p5, Menu.p6);
                    
                    if(IsDefined(Menu.toggle))
                        self UpdateCurrentMenu();
                    
                    wait .2;
                }
            
                if(self meleeButtonPressed())
                {
                    if(self getCurrentMenu() == "main")
                        self menuClose();
                    else
                        self newMenu();
                    
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

doOption(func, p1, p2, p3, p4, p5, p6)
{
    if(!isdefined(func))
        return;
    if(isdefined(p6))
        self thread [[func]](p1,p2,p3,p4,p5,p6);
    else if(isdefined(p5))
        self thread [[func]](p1,p2,p3,p4,p5);
    else if(isdefined(p4))
        self thread [[func]](p1,p2,p3,p4);
    else if(isdefined(p3))
        self thread [[func]](p1,p2,p3);
    else if(isdefined(p2))
        self thread [[func]](p1,p2);
    else if(isdefined(p1))
        self thread [[func]](p1);
    else
        self thread [[func]]();
}

scrollingSystem()
{
    menu = self getCurrentMenu() + "_cursor";
    curs = self getCursor();
    if(curs >= self.eMenu.size || curs <0 || curs == 7 || curs >= 8)
    {
        if(curs <= 0)
            self.menu[menu] = self.eMenu.size -1;
            
        if(curs >= self.eMenu.size)
            self.menu[menu] = 0;
            
        self setMenuText();
    }
    self updateScrollbar();
    self refreshOPTSize();
}

updateScrollbar()
{
    curs = ((self getCursor() >= 8) ? 7 : self getCursor());
    self.menu["UI"]["SCROLL"].y = (self.menu["OPT"][0].y + (curs*15));
    if(IsDefined(self.eMenu[self getCursor()].val))
        self updateSlider();
        
    if(IsDefined(self.eMenu[self getCursor()].optSlide))
        self updateOptSlider();
    if(self getCurrentMenu() == "Clients")
        self.SavePInfo = level.players[self getCursor()];
}

newMenu(menu, Access)
{
    if(IsDefined(Access) && self.access < Access)
        return;
        
    if(!isDefined(menu))
    {
        menu = self.previousMenu[self.previousMenu.size-1];
        self.previousMenu[self.previousMenu.size-1] = undefined;
    }
    else
        self.previousMenu[self.previousMenu.size] = self getCurrentMenu();
    self setCurrentMenu(menu);    
    self menuOptions();
    self setMenuText();
    self refreshTitle();
    self resizeMenu();
    self UpdateCurrentMenu();
    self refreshOPTSize();
    self updateScrollbar();
}

isMenuOpen()
{
    if( !isDefined(self.menu["isOpen"]) || !self.menu["isOpen"] )
        return false;
    return true;
}

lockMenu(which)
{
    if(toLower(which) == "lock")
    {
        if(self isMenuOpen())
            self menuClose();
        self.menu["isLocked"] = true;
    }
    else if (toLower(which) == "unlock")
    {
        if(!self isMenuOpen())
            self menuOpen();
        self.menu["isLocked"] = false;
    }
}

addMenu(menu, title)
{
    self.storeMenu = menu;
    if(self getCurrentMenu() != menu)
        return;
    self.eMenu     = [];
    self.menuTitle = title;
    if(!isDefined(self.menu[menu + "_cursor"]))
        self.menu[menu + "_cursor"] = 0;
}

addOpt(opt, func, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    option      = spawnStruct();
    option.opt  = opt;
    option.func = func;
    option.p1   = p1;
    option.p2   = p2;
    option.p3   = p3;
    option.p4   = p4;
    option.p5   = p5;
    option.p6   = p6;
    self.eMenu[self.eMenu.size] = option;
}

addToggleOpt(opt, func, toggle, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    toggleOpt        = spawnStruct();
    toggleOpt.opt    = opt;
    toggleOpt.func   = func;
    toggleOpt.toggle = (IsDefined(toggle) && toggle);
    toggleOpt.p1     = p1;
    toggleOpt.p2     = p2;
    toggleOpt.p3     = p3;
    toggleOpt.p4     = p4;
    toggleOpt.p5     = p5;
    toggleOpt.p6     = p6;
    self.eMenu[self.eMenu.size] = toggleOpt;
}

addSlider(opt, val, min, max, inc, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    slider          = SpawnStruct();
    slider.opt      = opt;
    slider.val      = val;
    slider.min      = min;
    slider.max      = max;
    slider.inc      = inc;
    slider.func     = func;
    slider.toggle   = (IsDefined(toggle) && toggle);
    slider.autofunc = autofunc;
    slider.p1       = p1;
    slider.p2       = p2;
    slider.p3       = p3;
    self.eMenu[self.eMenu.size] = slider;
}

addOptSlider(opt, strTok, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    Optslider          = SpawnStruct();
    Optslider.opt      = opt;
    Optslider.optSlide = strTok(strTok, "|");
    Optslider.func     = func;
    Optslider.toggle   = (IsDefined(toggle) && toggle);
    Optslider.autofunc = autofunc;
    Optslider.p1       = p1;
    Optslider.p2       = p2;
    Optslider.p3       = p3;
    self.eMenu[self.eMenu.size] = Optslider;
}

addSliderWithString(opt, List1, List2, func, p1, p2, p3, p4, p5)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    optionlist = spawnstruct();
    if(!isDefined(List2))
        List2 = List1;
    optionlist.List1 = (IsArray(List1)) ? List1 : strTok(List1, ";");
    optionlist.List2 = (IsArray(List2)) ? List2 : strTok(List2, ";");
    optionlist.opt = opt;
    optionlist.func = func;
    optionlist.p1   = p1;
    optionlist.p2   = p2;
    optionlist.p3   = p3;
    optionlist.p4   = p4;
    optionlist.p5   = p5;
    self.eMenu[self.eMenu.size] = optionlist;
}

updateSlider(pressed) 
{
    Menu = self.eMenu[self getCursor()];
    if(!IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].val;
        
    curs = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
    if(pressed == "R2")
        curs += Menu.inc;
    if(pressed == "L2")
        curs -= Menu.inc;
    if(curs > Menu.max)
        curs = Menu.min;
    if(curs < Menu.min)
        curs = Menu.max;
    
    
    cur = ((self getCursor() >= 8) ? 7 : self getCursor());
    if(curs != Menu.val)
        self.menu["OPT"]["OPTScroll"][cur] setText("" + curs);
    self.sliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

updateOptSlider(pressed)
{
    Menu = self.eMenu[self getCursor()];
    
    if(!IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = 0;
        
    curs = self.Optsliders[self getCurrentMenu() + "_" + self getCursor()];
    
    if(pressed == "R2")
        curs ++;
    if(pressed == "L2")
        curs --;               
    if(curs > Menu.optSlide.size-1)
        curs = 0;
    if(curs < 0)
        curs = Menu.optSlide.size-1;

    cur = ((self getCursor() >= 8) ? 7 : self getCursor());
    self.menu["OPT"]["OPTScroll"][cur] setText(Menu.optSlide[curs] + " [" + (curs+1) + "/" + Menu.optSlide.size + "]");
    self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

setCurrentMenu(menu)
{
    self.menu["current"] = menu;
}

getCurrentMenu()
{
    return self.menu["current"];
}

getCursor()
{
    return self.menu[self getCurrentMenu()+ "_cursor"];
}

hasMenu()
{
    return (isDefined(self.access) && self.access != 0 ? true : false);
}

UpdateCurrentMenu()
{
    self setCurrentMenu(self getCurrentMenu());
    self menuOptions();
    self setMenuText();
    self updateScrollbar();
    self resizeMenu();
    self refreshOPTSize();
}

menuOpen()
{
    ary = (self getCursor() >= 8 ? self getCursor()-7 : 0);
    self.menu["isOpen"] = true;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(true);
    self menuOptions();
    self drawText();
    self drawMenu();
    self updateScrollbar();
    for(e=0;e<8;e++)
    {
        if(IsDefined(self.eMenu[ary + e].val) || IsDefined(self.eMenu[ary + e].optSlide))
        {
            self.menu["OPT"]["OPTScroll"][e].alpha = 0;
            self.menu["OPT"]["OPTScroll"][e] affectElement("alpha", .4, 1);
        }
    }
}

menuClose()
{
    self.menu["isOpen"] = false;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(false);
    self destroyAll(self.menu["UI"]);
    self destroyAll(self.menu["OPT"]);
    self destroyAll(self.menu["OPT"]["OPTScroll"]);
}

onPlayerDisconnect(player)
{
    self notify("StopPMonitor");
    self endon("StopPMonitor");
    self endon("end_menu");
    self endon("disconnect");
    player waittill("disconnect");
    while(self getCurrentMenu() != "Clients")
        self newMenu();
    self setcursor(0, self getCurrentMenu());
    self UpdateCurrentMenu();
}

setcursor(value, menu)
{
    self.menu[menu + "_cursor"] = value;
}

menuOptions()
{    
    switch(self getCurrentMenu())
    {
        case "main":
            self addMenu("main", "Main Menu");
            self addOpt("Personal Modifications", ::newMenu, "Personal Modifications");
            if(self.access >= 1){//verified stuff
            self addOpt("Menu Customization", ::newMenu, "Menu Customisation", 1);
            self addOpt("Profile Manipulation", ::newMenu, "Profile Manipulation", 1);
            }
            if(self.access >= 2){
            self addOpt("Weapon Manipulation", ::newMenu, "Weapon Manipulation", 2);
            self addOpt("Lobby Manipulation", ::newMenu, "Lobby Manipulation", 2);
            self addOpt(GetTehMap()+" Options", ::newMenu, GetTehMap());
            }
            if (self.access >= 3){
            self addOpt("Clients [^2" + level.players.size + "^7]", ::newMenu, "Clients",4);
            self addOpt("All Clients", ::newMenu, "AllClients",4);
            }
            if(self IsHost()){ self addOpt("Host Debug Menu", ::newMenu, "Host Debug");}
            break;
        case "Personal Modifications":
            self addMenu("Personal Modifications", "Personal Modifications");
            self addToggleOpt("Toggle God Mode", ::Godmode, self.godmode);
            self addToggleOpt("Toggle No Clip", ::no_clip, self.noclip);
            self addToggleOpt("Toggle Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
            self addOpt("Score Menu", ::newMenu, "Score Menu");
            break;
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
            self addSlider("Add Score", self getplayerdata("cp","alienSession","currency"), 0, 9999999, 1000, ::AddScore, undefined, undefined, self);
            self addSlider("Remove Score", self getplayerdata("cp","alienSession","currency"), 0, 9999999, 1000, ::TakeScore, undefined, undefined, self);
                self addOpt("Max Out Score", ::MaxScore, self);
            break;
        case "Menu Customisation":
            self addMenu("Menu Customisation", "Menu Customisation");
                self addOpt("Menu Colours", ::newMenu, "MenuColour");
                self addOpt("Reposition Menu", ::MoveMenu);
            break;
        case "MenuColour":
            self addMenu("MenuColour", "Menu Colours");
                self addOpt("Background", ::newMenu, "BackgroundColour");
                self addOpt("Banner", ::newMenu, "BannerColour");
                self addOpt("Scroller", ::newMenu, "ScrollerColour");
            break;
        case "BackgroundColour":
            self addMenu("BackgroundColour", "Menu Background");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Background", true);
                }
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Background");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["BackgroundGradRainbow"]), "Background");
            break;
            
        case "BannerColour":
            self addMenu("BannerColour", "Menu Banner");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Banner", true);
                    }
                self addOptSlider("Colour Presets", GetColoursSlider(),::MenuPreSetCol, undefined, true, "Banner");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, bool(self.menuSetting["HUDEdit"]) ? IsString(self.menuSetting["BannerNoneRainbow"]) : IsString(self.menuSetting["BannerGradRainbow"]), "Banner");
            break;
            
        case "ScrollerColour":
            self addMenu("ScrollerColour", "Menu Scroller");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Scroller", true);
                    }
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Scroller");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["ScrollerGradRainbow"]), "Scroller");
            break;
        case "Weapon Manipulation":
            self addMenu("Weapon Manipulation", "Weapon Manipulation");
                self addOpt("Weapon Selection", ::newMenu, "Weapon Selection");
                self addOpt("Equipment Menu", ::newMenu, "Equipment Menu");
                self addOptSlider("Give Trap", "sentry|fireworks|medusa|electric|boombox|revocator|gascan|windowtrap", ::giveTrap,undefined, undefined, self);
            break;
        case "Equipment Menu":
        self addMenu("Equipment Menu", "Equipment Selection");
                for(t=0;t<level.trapNames.size;t++)
                self addOpt("Give Trap: "+level.trapNames[t], ::giveTrap, level.trapNames[t], self);
             break;
        case "Weapon Selection":
            self addMenu("Weapon Selection", "Weapon Selection");
                for(e=0;e<level.WeaponCategories.size;e++)
                self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e] );
            break;
        case "Assault Rifles":
            self addMenu(level.WeaponCategories[0], "Assault Rifles");
                for(i=0;i<level.ARNames.size;i++){
                    self addOpt(level.ARNames[i], ::GiveWeaponToPlayer, level.Assault[i], self);
                }
            break;        
        case "Sub Machine Guns":
            self addMenu(level.WeaponCategories[1], "Sub Machine Guns");
                for(i=0;i<level.SMGNames.size;i++){
                    self addOpt(level.SMGNames[i], ::GiveWeaponToPlayer, level.SMG[i], self);
                }
            break;
        case "Shotguns":
            self addMenu(level.WeaponCategories[4], "Shotguns");
                for(i=0;i<level.ShotgunNames.size;i++){
                    self addOpt(level.ShotgunNames[i], ::GiveWeaponToPlayer, level.Shotguns[i], self);
                }
            break;
        case "Light Machine Guns":
            self addMenu(level.WeaponCategories[2], "Light Machine Guns");
                for(i=0;i<level.LMGNames.size;i++){
                    self addOpt(level.LMGNames[i], ::GiveWeaponToPlayer, level.LMG[i], self);
                }
            break;
        case "Sniper Rifles":
            self addMenu(level.WeaponCategories[3], "Sniper Rifles");
                for(i=0;i<level.SniperNames.size;i++){
                    self addOpt( level.SniperNames[i], ::GiveWeaponToPlayer, level.Snipers[i], self ); 
                }
            break;
        case "Launchers":
            self addMenu(level.WeaponCategories[6], "Launchers");
                for(i=0;i<level.LauncherNames.size;i++){
                    self addOpt( level.LauncherNames[i], ::GiveWeaponToPlayer, level.Launchers[i], self ); 
                }
            break;
        case "Pistols":
            self addMenu(level.WeaponCategories[5], "Pistols");
                for(i=0;i<level.PistolNames.size;i++){
                    self addOpt( level.PistolNames[i], ::GiveWeaponToPlayer, level.Pistols[i], self );
                    }
            break;
        case "Classic Weapons":
            self addMenu(level.WeaponCategories[7], "Classic Weapons");
                for(i=0;i<level.ClassicNames.size;i++){
                    self addOpt(level.ClassicNames[i], ::GiveWeaponToPlayer, level.Classics[i], self);
                }
            break;
        case "Melee Weapons":
            self addMenu(level.WeaponCategories[8], "Melee Weapons");
            for(i=0;i<level.MeleeNames.size;i++){
                self addOpt(level.MeleeNames[i], ::GiveWeaponToPlayer, level.Melee[i], self);
            }
            break;
        case "Specialist Weapons":
            self addMenu(level.WeaponCategories[9], "Specialist Weapons");
                for(i=0;i<level.SpecialNames.size;i++){
                    self addOpt(level.SpecialNames[i], ::GiveWeaponToPlayer, level.Specials[i], self);
                }
            break;
        case "Map Specific Weapons":
            self addMenu(level.WeaponCategories[10], "Map Specific Weapons");
                if(level.mapName == "cp_zmb"){
                    for(i=0;i<level.SpacelandNames.size;i++){
                        self addOpt(level.SpacelandNames[i], ::GiveWeaponToPlayer, level.SpacelandWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_rave"){
                    for(i=0;i<level.RaveNames.size;i++){
                        self addOpt(level.RaveNames[i], ::GiveWeaponToPlayer, level.RaveWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_disco"){
                    for(i=0;i<level.ShaolinNames.size;i++){
                        self addOpt(level.ShaolinNames[i], ::GiveWeaponToPlayer, level.ShaolinWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_town"){
                    for(i=0;i<level.AttackNames.size;i++){
                        self addOpt(level.AttackNames[i], ::GiveWeaponToPlayer, level.AttackWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_final")
                {
                    for(i=0;i<level.BeastNames.size;i++){
                        self addOpt(level.BeastNames[i], ::GiveWeaponToPlayer, level.BeastWeaps[i], self);
                    }
                }
            break;
        case "Other Weapons":
            self addMenu(level.WeaponCategories[11], "Other Weapons");
                for(i=0;i<level.OtherNames.size;i++){
                    self addOpt(level.OtherNames[i], ::GiveWeaponToPlayer, level.otherWeaps[i], self);
                }
            break;
        case "Lobby Manipulation":
            self addMenu("Lobby Manipulation", "Lobby Manipulation");
                self addOpt("Max Bank Amount", ::MaxBank);
                self addOpt("Kill All Zombies", ::killAllZombies);
                if(level.script != "cp_town")
                {
                    self addOpt("Open All Doors", ::OpenAllDoors);
                }
                self addSlider("Edit Round", level.wave_num,1,999,1,::EditRound);
                self addOpt("Max Round", ::MaxRound);
                self addToggleOpt("Toggle Outlines", ::outline_zombies, self.outline_zombies);
                self addOpt("Rainbow Outlines", ::RainbowOutlines);
                self addSlider("Set Outline Color", self.outline_color,0,5,1,::ChangeOutlineColor);
                
            break;
            
        case "Profile Manipulation":
            self addMenu("Profile Manipulation", "Profile Manipulation");
                self addOpt("Complete All Challenges", ::CompleteChallenges, self);
                self addOpt("Complete Contracts", ::CompleteActiveContracts, self);
                self addSlider("Edit Rank",0, 0,999,1,::SetPlayerRank, undefined, undefined, self);
                self addOpt("Unlock Directors Cut", ::UnlockDC, self);
                self addOpt("Unlock All Talismans", ::UnlockTalismans, self);
                self addOpt("Give Soul Keys", ::SoulKeyUnlock, self);
            break;
        case "Zombies in Spaceland":
            self addMenu("Zombies in Spaceland", "Zombies in Spaceland");
                self addSlider("Give Tickets", 50,50,950, 50, ::GiveTickets);
                self addOpt("Trigger MW1 Song", ::PlayAudioToClients, "mus_pa_mw1_80s_cover");
                self addOpt("Trigger MW2 Song", ::PlayAudioToClients, "mus_pa_mw2_80s_cover");
                self addOpt("Grab SetiCom Parts", ::GrabSetiComParts);
                self addOpt("Take the Seticom", ::GrabTheSeticom);
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;
        case "Rave in the Redwoods":
            self addMenu("Rave in the Redwoods", "Rave in the Redwoods");
            self addOpt("Play Puppet Strings", ::PlayAudioToClients, "mus_pa_rave_hidden_track");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;
        case "Shaolin Shuffle":
            self addMenu("Shaolin Shuffle", "Shaolin Shuffle");
                self addOpt("Play Beat of the Drum", ::PlayAudioToClients, "mus_pa_disco_hidden_track");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;

        case "Radioactive Thing":
            self addMenu("Radioactive Thing", "Attack of the Radioactive Thing");
                self addOpt("Play Brackyura boogie", ::PlayAudioToClients, "mus_pa_town_hidden_track");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;
        case "Beast from Beyond":
            self addMenu("Beast from Beyond", "Beast from Beyond");
                self addOpt("Play Scattered Lies", ::PlayAudioToClients, "mus_pa_final_hidden_track");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;
        case "AllAccess":
            self addMenu("AllAccess", "Verification Level");
                for(e=0;e<level.Status.size-1;e++)
                    self addOpt(level.Status[e], ::AllPlayersAccess, e);
            break; 
        case "Host Debug":
            self addMenu("Host Debug", "Host Debug Settings");
            self addOpt("Fast Restart", ::FastRestartGame);
            self addOpt("End The Game", ::EndGameHost);
            self addOpt("Print Coords", ::PrintCoords);
            break;
        default:
            self ClientOptions();
            break;
    }
}

ClientOptions()
{
    player = self.SavePInfo;
    Name   = player getName();
    switch(self getCurrentMenu())
    {
         case "Clients":
            self addmenu("Clients","Clients [^2" + level.players.size + "^7]");
            foreach(Client in level.players)
                self addopt(Client getName(), ::newmenu, "PMain");
            break;
            
        case "PMain":
            self addmenu("PMain", Name);
            self addOpt("Verification Level", ::newMenu, "PAccess");
            self addOpt("Personal Modifications", ::newMenu, "Personal Modifications Client");
            self addOpt("Stat Manipulation", ::newMenu, "Stat Manipulation Client");
            self addOpt("Trolling Options", ::newMenu, "Trolling Options");
            self addOpt("Equipment and Weapons", ::newMenu, "Equip Weaps Client");
            break;
        case "Personal Modifications Client":
            self addMenu("Personal Modifications Client", "Personal Modifications "+Name);
            self addToggleOpt("Toggle God Mode", ::ClientHandler, player.Godmode, 1, player);
            self addToggleOpt("Toggle NoClip", ::ClientHandler, player.noclip, 2, player);
            self addToggleOpt("Toggle Infinite Ammo", ::ClientHandler, player.UnlimAmmo, 3, player);
            self addOpt("Max Player Score", ::ClientHandler, 4, player);
            break;
        case "Stat Manipulation Client":
            self addMenu("Stat Manipulation Client", "Stat Manipulation "+name);
            self addOpt("Complete All Challenges", ::CompleteChallenges, player);
            self addOpt("Complete Contracts", ::CompleteActiveContracts, player);
            self addSlider("Edit Rank",0, 0,999,1,::SetPlayerRank, undefined, undefined, player);
            self addOpt("Unlock Directors Cut", ::UnlockDC, player);
            self addOpt("Unlock All Talismans", ::UnlockTalismans, player);
            self addOpt("Unlock Soul Keys", ::SoulKeyUnlock, player);
            break;
        case "Equip Weaps Client":
            self addMenu("Equip Weaps Client", "Equipment and Weapons");
                for(t=0;t<level.trapNames.size;t++)
                    self addOpt("Give Trap: "+level.trapNames[t], ::giveTrap, level.trapNames[t], player);
             break;
        case "Trolling Options":
            self addMenu("Trolling Options", "Trolling Options");
            self addOpt("Send Player To Jail", ::ClientHandler, 5, player);
            self addOpt("Set Free From Jail", ::ClientHandler, 6, player);
            break;
        case "PAccess":
            self addMenu("PAccess", Name+" Verification");
            for(e=0;e<level.Status.size-1;e++)
                self addToggleOpt(GetAccessName(e), ::initializeSetup, player.access == e, e, player);
            break;
    }
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


test()
{
    
    self iPrintLnBold("Testing");
}

CompleteGnS()
{
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(5);
    self lib_0D59::use_activate_gns_machine("activate_gns_machine");
}

ActivateFAF(card, player)
{
    switch(card)
    {
        case "anywhere_but_here" : player thread lib_0D59::func_12FA2(undefined); break;
    }
}
MaxBank()
{
    level.var_2416 = 2147483647;
    self iPrintLnBold("The Bank is ^2BURSTING! ^0Balance Set to: ^2$2147483647");
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
            self iPrintLnBold(info[i]);
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
    if(level.wave_num < 1) {self iPrintLnBold("Fool, wait for the round to start"); return;}
    else{
        self iPrintLnBold("Round Changing to: "+newRoundNum+" in TWO SECONDS!");
        wait 2;
        level.wave_num = newRoundNum;
        thread killAllZombies();
    }
}
Godmode()
{
    self.godmode = !bool(self.godmode);
    if(self.godmode)
    {
        self iPrintLnBold("Godmode ^2Enabled");
    }
    else{
        self iPrintLnBold("Godmode ^1Disabled");
    }
    while(self.godmode)
    {
        self.health = self.maxHealth;
        wait .05;
    }
}
killAllZombies()
{
    level notify("wave_complete");
    zombies = scripts\cp\_agent_utils::func_7DB0("axis");
    if(isdefined(zombies))
    {
        for(i = 0; i < zombies.size; i++)
            zombies[i] DoDamage(zombies[i].health + 1, zombies[i].origin);
        wait 1;
    }
    self iPrintLnBold("All Zombies ^2Killed");
}

MaxRound()
{
    if(level.wave_num < 1) {self iPrintLnBold("Fool, wait for the round to start"); return;}
    else{
        level notify("wave_complete");
        self iPrintLnBold("Round Changing to: 2147483647 in TWO SECONDS!");
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
no_clip() {
    self.noclip = !bool(self.noclip);
    if(self.noclip) {
        self iPrintLnBold("No Clip [^2ON^7]");
        thread UpdateSessionState("spectator");
    } else {
    self iPrintLnBold("No Clip [^1OFF^7]");
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
    self iPrintLnBold("Awarded ^1"+amount+" Tickets");
}   

OpenAllDoors()
{
    if(level.script == "cp_final"){ self thread beast_open_sesame();}else{
    self scripts\cp\zombies\direct_boss_fight::func_C617();
    if(isdefined(level.fast_travel_spots))
    {
        foreach(var_05 in level.fast_travel_spots)
        {
            var_05.activated = 1;
            var_05.var_13068 = 1;
            if(isDefined(var_05.var_C626)) {
                var_05.var_C626 = 0;
            }
            if(level.script == "cp_zmb"){ flag_set("pap_portal_used");}
        }
    }}
}

PlayAudioToClients(audioFile)
{
    foreach(player in level.players)
    {
        thread force_song((649,683,254),audioFile);
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
    play_sound_in_space("zmb_jukebox_on",param_00);

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

GiveWeaponToPlayer(weapon, player) {
    if(player getCurrentWeapon() != weapon && player getWeaponsListPrimaries()[1] != weapon && player getWeaponsListPrimaries()[2] != weapon && player getWeaponsListPrimaries()[3] != weapon&& player getWeaponsListPrimaries()[4] != weapon) {
        
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

ToggleAmmo() {
    self.UnlimAmmo = !bool(self.UnlimAmmo);
    if(self.UnlimAmmo) {
        self iPrintLnBold("Infinite Ammo [^2ON^7]");
        enable_infinite_ammo(self.UnlimAmmo);
    } else {
        self iPrintLnBold("Infinite Ammo [^1OFF^7]");
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
    player iPrintLnBold("Hey, you just got ^2UNLOCK ALL");
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
    player iPrintLnBold("^2Your Contracts are now Complete. Sweet Keys and Salvage");
}

SetPlayerRank(rank, player)
{
    rank = (rank - 1);
        mode  = "cp";
        table = "cp/zombies/rankTable.csv";
    
    player SetPlayerData(mode, "progression", "playerLevel", "xp", Int(TableLookup(table, 0, rank, (rank == Int(TableLookup(table, 0, "maxrank", 1))) ? 7 : 2)));
    player iPrintLnBold("You are now Level "+rank);
}

SetPlayerPrestige(prestige, player)
{
    player SetPlayerData("cp", "progression", "playerLevel", "prestige", prestige);
    player iPrintLnBold("You are now Prestige "+prestige);
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
    self iprintlnbold("^2Director's cut given to "+player.name);
}
 
AddScore(amount, player)
{
    player setplayerdata("cp","alienSession", "currency", player getplayerdata("cp","alienSession","currency") + int(amount));
    player iPrintLnBold("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}
TakeScore(amount, player)
{
    player setplayerdata("cp","alienSession", "currency", player getplayerdata("cp","alienSession","currency") - int(amount) );
    player iPrintLnBold("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}
MaxScore( player )
{
    player setplayerdata("cp","alienSession", "currency", 2147483647 );
    player iPrintLnBold("Score Set To: "+player getplayerdata("cp","alienSession","currency"));
}

ClientHandler(func, player)
{
    switch(func)
    {
        case 1 : player thread Godmode(); break;
        case 2 : player thread no_clip(); break;
        case 3 : player thread ToggleAmmo(); break;
        case 4 : player thread MaxScore(player); break;
        case 5 : player setOrigin(level.jailPos); player iPrintLnBold("You have been sent to ^1JAIL"); break;
        case 6 : player setOrigin(level.freePos); player iPrintLnBold("You have been set free from ^2Jail"); break;
    }
}

PrintCoords()
{
    self iPrintLnBold("Current Coords: "+self.origin);
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
      player iprintlnBold("You Now have ^2ALL Soul Keys");
      wait 1;
      player thread setPlayerAtPoint((-10250, 875, -1630), (0, 90, 0));
      player iPrintLnBold("Interact with the ^2Soul Jar^7 to Unlock Directors Cut ^5Permanently");
}
  
giveTrap(trap, player)
{
    switch(trap)
    {
        case "Sentry Turret":
            scripts\cp\_weapon_autosentry::func_82BA(0, player);
            break;
        case "Fireworks Trap":
            scripts\cp\zombies\craftables\_fireworks_trap::func_82B5(0, player);
            break;
        case "Medusa Device":
            scripts\cp\zombies\craftables\_zm_soul_collector::func_82B8(0, player);
            break;
        case "Electric Trap":
            scripts\cp\zombies\craftables\_electric_trap::func_82BB(0, player);
            break;
        case "Boombox":
            scripts\cp\zombies\craftables\_boombox::func_82B4(0, player);
            break;
        case "Revocator":
            scripts\cp\zombies\craftables\_revocator::func_82B9(0, player);
            break;
        case "Kindle Pops":
            scripts\cp\zombies\craftables\_gascan::func_82B6(0, player);
            break;
        case "Lazer Window Trap":
            lib_0D43::func_DAFF(0, player);
            break;
    }
 }
    
outline_zombies() {
    self.outline_zombies = !bool(self.outline_zombies);
    if(self.outline_zombies) {
        self iPrintlnBold("Zombie Outlines [^2ON^7]");
        outline_zombies_loop();
    } else {
    self iPrintlnBold("Zombie Outlines [^1OFF^7]");
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
        wait 1.5;
        self set_outline_color(1);
        wait 1.5;
        self set_outline_color(2);
        wait 1.5;
        self set_outline_color(3);
        wait 1.5;
        self set_outline_color(4);
        wait 1.5;
        self set_outline_color(5);
        wait 1.5;
    }
}