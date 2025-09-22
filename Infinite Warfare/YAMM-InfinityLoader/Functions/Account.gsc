/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : An empty canvas for anything you want!
*    Date : 14/09/2025 03:30:48
*
*/

    
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
    player iPrintLnAlt("Hey, you just got ^2UNLOCK ALL");
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
    player iPrintLnAlt("^2Your Contracts are now Complete. Sweet Keys and Salvage");
}

SetPlayerRank(rank, player)
{
    rank = (rank - 1);
        mode  = "cp";
        table = "cp/zombies/rankTable.csv";
    
    player SetPlayerData(mode, "progression", "playerLevel", "xp", Int(TableLookup(table, 0, rank, (rank == Int(TableLookup(table, 0, "maxrank", 1))) ? 7 : 2)));
    player iPrintLnAlt("You are now Level "+rank);
}

SetPlayerPrestige(prestige, player)
{
    player SetPlayerData("cp", "progression", "playerLevel", "prestige", prestige);
    player iPrintLnAlt("You are now Prestige "+prestige);
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
    self iPrintLnAlt("Weapon Levels ^2Maxed");
}


UnlockDC(player)
{
    player setplayerdata("cp","dc", 1);
    self iPrintLnAlt("^2Director's cut given to "+player.name);
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
    player iPrintlnAlt("All Talismans ^2Unlocked");
}

GetKeyCount()
{
    keyCount = self GetPlayerData("cp","progression","keys");
if(!isDefined(keyCount)){ self iPrintLnAlt("Wrong Player Data"); return;}
    self iPrintLnAlt("You Currently Have: "+keyCount+" Keys");
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
      player iPrintLnAlt("You Now have ^2ALL Soul Keys");
      wait 1;
      player thread setPlayerAtPoint((-10250, 875, -1630), (0, 90, 0));
      player iPrintLnAlt("Interact with the ^2Soul Jar^7 to Unlock Directors Cut ^5Permanently");
}

  