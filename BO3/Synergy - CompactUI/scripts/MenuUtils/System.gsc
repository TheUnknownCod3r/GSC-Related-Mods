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
    player.menu["Theme"]["Default"] = true;
    player.menu["Theme"]["Flex"] = false;
    
    if(!isDefined(player.menu["current"]))
        player.menu["current"] = "main";
        
    player.access = access;
    
    if(player.access != 0)
    {
        player thread menuMonitor();
        player menuOptions();
        player.menuSetting["HUDEdit"] = true;
        player thread MenuLoad();
        player thread PrintMenuControls();
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