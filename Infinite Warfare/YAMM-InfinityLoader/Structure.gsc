/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : 
*    Game : Call of Duty: Infinite Warfare
*    Description : An empty canvas for anything you want!
*    Date : 13/09/2025 01:16:53
*
*/

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
            self addOpt("Fun Modifications", ::newMenu, "Fun Menu", 2);
            self addOpt(GetTehMap()+" Options", ::newMenu, GetTehMap());
            }
            if (self.access >= 3){
            self addOpt("Clients [^2" + level.players.size + "^7]", ::newMenu, "Clients",4);
            self addOpt("All Clients", ::newMenu, "AllClients",4);
            }
            if(self IsHost()){ self addOpt("Host Debug Menu", ::newMenu, "Host Debug");
            self addOpt("GameModes", ::newMenu, "GameModes");}
            break;
        case "Personal Modifications":
            self addMenu("Personal Modifications", "Personal Modifications");
            self addToggleOpt("Toggle God Mode", ::Godmode, self.godmode);
            self addToggleOpt("Toggle No Clip", ::no_clip, self.noclip);
            self addToggleOpt("Toggle Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
            self addOpt("Score Menu", ::newMenu, "Score Menu");
            self addOpt("Random Teleport", ::ActivateFAF, "anywhere_but_here", self);
            self addOpt("Give All Perks", ::AllPerks, self);
            self addSlider("Edit Movement Speed", 0,0,15,1,::EditSpeed);
            self addToggleOpt("Toggle Speed Change", ::SpeedToggle, self.speedToggle);
            break;
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
            self addSlider("Add Score", self getplayerdata("cp","alienSession","currency"), 0, self.var_B48A, 1000, ::AddScore, undefined, undefined, self);
            self addSlider("Remove Score", self getplayerdata("cp","alienSession","currency"), 0, self.var_B48A, 1000, ::TakeScore, undefined, undefined, self);
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
                self addOpt("Pillaged Loot", ::newMenu, "Pillaged Loot");
            break;
        case "Pillaged Loot":
            self addMenu("Pillaged Loot", "Pillaged Loot");
                for(i=0;i<level.pickupLootName.size;i++)
                    self addOpt("Give "+level.pickupLootName[i], ::givePillagedLoot, level.pickupLoot[i]);
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
                self addOpt("Zombies Options", ::newMenu, "Zombies Options");
                if(level.script != "cp_town")
                {
                    self addOpt("Open All Doors", ::ClearDoorsAndDebris);
                    self addOpt("Turn On Power", ::TurnOnPower);
                }
                self addSlider("Edit Round", level.wave_num,1,999,1,::EditRound);
                self addOpt("Max Round", ::MaxRound);
                self addToggleOpt("Freeze the Wheel", ::NoMovingWheel, level.noMoveBox);
                self addToggleOpt("Toggle Force Host", ::ToggleForceHost, self.ForcingHost);
                break;
        case "Zombies Options":
            self addMenu("Zombies Options", "Zombies Options");
                self addOpt("Kill All Zombies", ::killAllZombies);
                self addToggleOpt("Toggle Outlines", ::outline_zombies, self.outline_zombies);
                self addOpt("Rainbow Outlines", ::RainbowOutlines);
                self addSlider("Set Outline Color", self.outline_color,0,5,1,::ChangeOutlineColor);
                self addToggleOpt("One Shot Zombies", ::oneShotKillZombies, self.oneShotKillZombies);
                self addToggleOpt("Freeze Zombies", ::freezeZombies, self.freezeZombies);
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
        case "Fun Menu":
            self addMenu("Fun Menu", "Fun Modifications");
                self addToggleOpt("Toggle Kill Aura", ::ToggleKillAura, self.killAura, self);
                self addOpt("Sky Trip", ::skyTrip);
            break;
        case "Zombies in Spaceland":
            self addMenu("Zombies in Spaceland", "Zombies in Spaceland");
                self addSlider("Give Tickets", 50,50,950, 50, ::GiveTickets);
                self addOpt("Quest Options", ::newMenu, "SLQuests");
                self addOpt("Trigger MW1 Song", ::PlayAudioToClients, "mus_pa_mw1_80s_cover");
                self addOpt("Trigger MW2 Song", ::PlayAudioToClients, "mus_pa_mw2_80s_cover");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
                self addOpt("Play Knight Rider", ::PlayAudioToClients, "mus_pa_sp_knightrider");
                self addOpt("Play Scattered Lies", ::PlayAudioToClients, "mus_pa_final_hidden_track");
            break;
        case "SLQuests":
            self addMenu("SLQuests", "Quest Options");
                self addOptSlider("Grab Neil Part","Head|Battery|Firmware", ::GetNeilPart);
                self addOpt("Grab SetiCom Parts", ::GrabSetiComParts);
                self addOpt("Take the Seticom", ::GrabTheSeticom);
                self addOpt("Get The Speakers", ::GetThoseSpeakers);
            break;
        case "Rave in the Redwoods":
            self addMenu("Rave in the Redwoods", "Rave in the Redwoods");
            self addOpt("Play Puppet Strings", ::PlayAudioToClients, "mus_pa_rave_hidden_track");
                self addOpt("Activate Ghosts N Skulls", ::CompleteGnS);
            break;
        case "Shaolin Shuffle":
            self addMenu("Shaolin Shuffle", "Shaolin Shuffle");
                self addOpt("Play Beat of the Drum", ::PlayAudioToClients, "mus_pa_disco_hidden_track");
                self addOpt("Complete Kung Fu", ::CompleteAllKungFu, self);
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
        case "AllClients":
            self addMenu("AllClients", "All Client Options");
                self addOpt("All God Mode", ::AllClientHandler, 1);
                self addOpt("All No Clip", ::AllClientHandler, 2);
                self addOpt("All Infinite Ammo", ::AllClientHandler, 3);
                self addOpt("All Max Score", ::AllClientHandler, 4);
                self addOpt("Give everyone Perks", ::AllClientHandler, 5);
                self addOpt("Give All Kill Aura", ::AllClientHandler, 6);
                self addOpt("Send All To Jail", ::AllClientHandler, 7);
                self addOpt("Free All from Jail", ::AllClientHandler, 8);
            break;
        case "AllAccess":
            self addMenu("AllAccess", "Verification Level");
                for(e=0;e<level.Status.size-1;e++)
                    self addOpt(level.Status[e], ::AllPlayersAccess, e);
            break;
        case "GameModes":
            self addMenu("GameModes", "Gamemodes");
                self addOpt("Mod Menu Lobby", ::newMenu, "ModLobbyOpt");
                self addOpt("Old School Stat Lobby", ::GameModeSwitcher, undefined, "OldSchool");
            break;
        case "ModLobbyOpt":
            self addMenu("ModLobbyOpt", "Menu Lobby Options");
                self addOpt("Mod Menu Lobby [All Verified]", ::GameModeSwitcher, "Verified", "ModMenu");
                self addOpt("Mod Menu Lobby [All VIP]", ::GameModeSwitcher, "VIP", "ModMenu");
                self addOpt("Mod Menu Lobby [All Admin]", ::GameModeSwitcher, "Admin", "ModMenu");
                self addOpt("Mod Menu Lobby [All Co-Host]", ::GameModeSwitcher, "Co-Host", "ModMenu");
            break;
        case "Host Debug":
            self addMenu("Host Debug", "Host Debug Settings");
            self addOpt("Fast Restart", ::FastRestartGame);
            self addOpt("Merry Go Round Options", ::newMenu, "MerryOpt");
            self addOpt("End The Game", ::EndGameHost);
            self addSlider("Send Client Message",1,1,5,1,::ClientMessages);
            self addOpt("Print Coords", ::PrintCoords);
            self addSlider("Set XP Scale",getdvarint("online_zombies_xpscale"),1,99,1,::SetXPScale);
            self addSlider("Set Lobby Timer",level.TimerTime,1,99,1,::setLobbyTimer);
            self addOpt("Start Timed Lobby", ::startLobbyTimer);
            break;
        case "MerryOpt":
            self addMenu("MerryOpt", "Merry Go Round Options");
            self addOpt("Spawn Merry Go Round", ::spawn_merry, "Merry Go Round");
            self addOpt("Increase Speed", ::merryrotate, +1);
            self addOpt("Decrease Speed", ::merryrotate, -1);
            self addOpt("Nuke The Merry Go Round", ::ride_destroy2, "merrynuke");
            self addOpt("Delete The Merry Go Round", ::ride_destroy2, "merrydestroy");
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
            self addOpt("Testing Keys", ::KeyGiving);
            break;
        case "Personal Modifications Client":
            self addMenu("Personal Modifications Client", "Personal Modifications "+Name);
            self addToggleOpt("Toggle God Mode", ::ClientHandler, player.Godmode, 1, player);
            self addToggleOpt("Toggle NoClip", ::ClientHandler, player.noclip, 2, player);
            self addToggleOpt("Toggle Infinite Ammo", ::ClientHandler, player.UnlimAmmo, 3, player);
            self addOpt("Max Player Score", ::ClientHandler, 4, player);
            self addOpt("Give All Perks", ::ClientHandler, 7, player);
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
                self addOpt("Weapon Selection", ::newMenu, "Weaps Client");
             break;
        case "Weaps Client":
            self addMenu("Weaps Client", "Weapon Selection");
                for(e=0;e<level.WeaponCategories.size;e++)
                self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e] + " Client");
            break;
        case "Assault Rifles Client":
            self addMenu(level.WeaponCategories[0]+" Client", "Assault Rifles");
                for(i=0;i<level.ARNames.size;i++){
                    self addOpt(level.ARNames[i], ::GiveWeaponToPlayer, level.Assault[i], player);
                }
            break;        
        case "Sub Machine Guns Client":
            self addMenu(level.WeaponCategories[1]+" Client", "Sub Machine Guns");
                for(i=0;i<level.SMGNames.size;i++){
                    self addOpt(level.SMGNames[i], ::GiveWeaponToPlayer, level.SMG[i], player);
                }
            break;
        case "Shotguns Client":
            self addMenu(level.WeaponCategories[4]+" Client", "Shotguns");
                for(i=0;i<level.ShotgunNames.size;i++){
                    self addOpt(level.ShotgunNames[i], ::GiveWeaponToPlayer, level.Shotguns[i], player);
                }
            break;
        case "Light Machine Guns Client":
            self addMenu(level.WeaponCategories[2]+" Client", "Light Machine Guns");
                for(i=0;i<level.LMGNames.size;i++){
                    self addOpt(level.LMGNames[i], ::GiveWeaponToPlayer, level.LMG[i], player);
                }
            break;
        case "Sniper Rifles Client":
            self addMenu(level.WeaponCategories[3]+" Client", "Sniper Rifles");
                for(i=0;i<level.SniperNames.size;i++){
                    self addOpt( level.SniperNames[i], ::GiveWeaponToPlayer, level.Snipers[i],player); 
                }
            break;
        case "Launchers Client":
            self addMenu(level.WeaponCategories[6]+ " Client", "Launchers");
                for(i=0;i<level.LauncherNames.size;i++){
                    self addOpt( level.LauncherNames[i], ::GiveWeaponToPlayer, level.Launchers[i], player ); 
                }
            break;
        case "Pistols Client":
            self addMenu(level.WeaponCategories[5]+" Client", "Pistols");
                for(i=0;i<level.PistolNames.size;i++){
                    self addOpt( level.PistolNames[i], ::GiveWeaponToPlayer, level.Pistols[i], player );
                    }
            break;
        case "Classic Weapons Client":
            self addMenu(level.WeaponCategories[7]+"Client", "Classic Weapons");
                for(i=0;i<level.ClassicNames.size;i++){
                    self addOpt(level.ClassicNames[i], ::GiveWeaponToPlayer, level.Classics[i], player);
                }
            break;
        case "Melee Weapons Client":
            self addMenu(level.WeaponCategories[8]+" Client", "Melee Weapons");
            for(i=0;i<level.MeleeNames.size;i++){
                self addOpt(level.MeleeNames[i], ::GiveWeaponToPlayer, level.Melee[i], player);
            }
            break;
        case "Specialist Weapons Client":
            self addMenu(level.WeaponCategories[9] + "Client", "Specialist Weapons");
                for(i=0;i<level.SpecialNames.size;i++){
                    self addOpt(level.SpecialNames[i], ::GiveWeaponToPlayer, level.Specials[i], player);
                }
            break;
        case "Map Specific Weapons Client":
            self addMenu(level.WeaponCategories[10] +" Client", "Map Specific Weapons");
                if(level.mapName == "cp_zmb"){
                    for(i=0;i<level.SpacelandNames.size;i++){
                        self addOpt(level.SpacelandNames[i], ::GiveWeaponToPlayer, level.SpacelandWeaps[i], player);
                    }
                }
                else if(level.mapName == "cp_rave"){
                    for(i=0;i<level.RaveNames.size;i++){
                        self addOpt(level.RaveNames[i], ::GiveWeaponToPlayer, level.RaveWeaps[i], player);
                    }
                }
                else if(level.mapName == "cp_disco"){
                    for(i=0;i<level.ShaolinNames.size;i++){
                        self addOpt(level.ShaolinNames[i], ::GiveWeaponToPlayer, level.ShaolinWeaps[i], player);
                    }
                }
                else if(level.mapName == "cp_town"){
                    for(i=0;i<level.AttackNames.size;i++){
                        self addOpt(level.AttackNames[i], ::GiveWeaponToPlayer, level.AttackWeaps[i], player);
                    }
                }
                else if(level.mapName == "cp_final")
                {
                    for(i=0;i<level.BeastNames.size;i++){
                        self addOpt(level.BeastNames[i], ::GiveWeaponToPlayer, level.BeastWeaps[i], player);
                    }
                }
            break;
        case "Other Weapons Client":
            self addMenu(level.WeaponCategories[11]+ " Client", "Other Weapons");
                for(i=0;i<level.OtherNames.size;i++){
                    self addOpt(level.OtherNames[i], ::GiveWeaponToPlayer, level.otherWeaps[i], player);
                }
            break;
        case "Trolling Options":
            self addMenu("Trolling Options", "Trolling Options");
            self addOpt("Send Player To Jail", ::ClientHandler, 5, player);
            self addOpt("Set Free From Jail", ::ClientHandler, 6, player);
            self addOpt("Drop Player Weapon", ::dropweapon, player);
            break;
        case "PAccess":
            self addMenu("PAccess", Name+" Verification");
            for(e=0;e<level.Status.size-1;e++)
                self addToggleOpt(GetAccessName(e), ::initializeSetup, player.access == e, e, player);
            break;
    }
}
