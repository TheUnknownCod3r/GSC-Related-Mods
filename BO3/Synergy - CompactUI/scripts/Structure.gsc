menuOptions()
{    
    switch(self getCurrentMenu())
    {
        case "main":
            self addMenu("main", "Main Menu");
            self addOpt("Personal Modifications", ::newMenu, "Personal Modifications");
            if(self.access >= 1){//verified stuff
            self addOpt("Menu Customization", ::newMenu, "MenuEdis", 1);
            #ifdef ZM 
            self addOpt("BGB Manipulation", ::newMenu, "BGB Manipulation");
            #endif 
            self addOpt("Profile Manipulation", ::newMenu, "Profile Manipulation");
            self addOpt("Fun Modifications", ::newMenu, "Fun Modifications");
            }
            if(self.access >= 2){
            self addOpt("Weapon Manipulation", ::newMenu, "Weapon Manipulation");
            self addOpt("Lobby Manipulation", ::newMenu, "Lobby Manipulation");
            }
            if (self.access >= 3){
            self addOpt("Clients [^2" + level.players.size + "^7]", ::newMenu, "Clients",4);
            self addOpt("All Clients", ::newMenu, "AllClients",4);
            }
            if(self IsHost()){ self addOpt("Host Debug Menu", ::newMenu, "Host Debug");}
            if (!isDefined(level.GameModeSelected) && self isHost()) self addOpt("GameModes", ::newMenu, "GameModes");
            break;
        case "Personal Modifications":
            self addMenu("Personal Modifications", "Personal Modifications");
                self addToggleOpt("Toggle God Mode", ::Godmode, self.godmode);
                self addToggleOpt("Toggle Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
                self addToggleOpt("Toggle Third Person", ::ThirdPersonToggle, self.ThirdPersonToggle);
                self addToggleOpt("Toggle All Perks", ::AllPerkToggle, self.HasAllPerks);
                #ifdef ZM
                self addToggleOpt("Toggle No Target", ::noTarget, self.ignoreme);
                self addOpt("Score Menu", ::newMenu, "Score Menu");
                #endif
                #ifdef MP
                self addToggleOpt("Toggle Advanced UAV", ::toggleUAV, self.AdvancedUAV);
                #endif
            break;
        #ifdef ZM
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
                self addOpt("Max Out Score", ::EditScore, 4194303, "Give", self);
                self addOpt("Take All Score", ::EditScore, 4194303, "Take", self);
                self addSlider("Add Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Give", self);
                self addSlider("Take Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Take", self);
            break;
        #endif
        case "MenuEdis":
            self addMenu("MenuEdis", "Menu Customization");
                self addOpt("Menu Colours", ::newMenu, "MenuColour");
            break;
        
        case "MenuColour":
            self addMenu("MenuColour", "Menu Colours");
                self addOpt("Background", ::newMenu, "BackgroundColour");
                self addOpt("Banner", ::newMenu, "BannerColour");
                self addOpt("Scroller", ::newMenu, "ScrollerColour");
            break;
        
        case "BackgroundColour":
            self addMenu("BackgroundColour", "Menu Background");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Background", true);
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Background");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["BackgroundGradRainbow"]), "Background");
            break;
            
        case "BannerColour":
            self addMenu("BannerColour", "Menu Banner");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Banner", true);
                self addOptSlider("Colour Presets", GetColoursSlider(),::MenuPreSetCol, undefined, true, "Banner");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, bool(self.menuSetting["HUDEdit"]) ? IsString(self.menuSetting["BannerNoneRainbow"]) : IsString(self.menuSetting["BannerGradRainbow"]), "Banner");
            break;
            
        case "ScrollerColour":
            self addMenu("ScrollerColour", "Menu Scroller");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Scroller", true);
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Scroller");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["ScrollerGradRainbow"]), "Scroller");
            break;
        #ifdef ZM
        case "BGB Manipulation":
            self addMenu("BGB Manipulation", "BGB Manipulation");
                self addOpt("BGB Selection", ::newMenu, "BGB Selection");
            break;
        case "BGB Selection":
            self addMenu("BGB Selection", "BGB Selection");
                for(e=0;e<level._SynBGB.size;e++)
                    self addOpt(level._BGBNames[e], ::GiveBGB, e);
            break;
        #endif
        case "Profile Manipulation":
            self addMenu("Profile Manipulation", "Profile Manipulation");
                self addOpt("Rank / Prestige Options", ::newMenu, "RankPrestige Options");
                self addOpt("Stat Manipulation", ::newMenu, "Stat Manipulation");
                self addOpt("Unlockables", ::newMenu, "Unlockables");
                self addOpt("ClanTag Options", ::newMenu, "ClanTag Options");
                self addToggleOpt("Currency Loop", ::CurrencyLoop, self.CurrencyLoop);
            break;
        case "RankPrestige Options":
            self addMenu("RankPrestige Options", "Rank / Prestige Options");
            #ifdef ZM
            self addToggleOpt("Max Rank", ::MaxRank, ((self.pers["plevel"] > 10) ? self getCurrentRank() == 1000 : self getCurrentRank() == 35));
            #endif
            #ifdef MP 
            self addToggleOpt("Max Rank", ::MaxRank, ((self.pers["plevel"] > 10) ? self getCurrentRank() == 1000 : self getCurrentRank() == 55));
            #endif
            self addSlider("Prestige", self GetPlayerData("plevel"), 0, (self.pers["plevel"] > 10 ? 12 : 10), 1, ::SetPrestige);
            
        break;
        case "Stat Manipulation":
            self addMenu("Stat Manipulation", "Stat Manipulation");
                #ifdef ZM
                self addOpt("Set Legit Stats", ::DoStats, 0, self);
                self addOpt("Set Professional Stats", ::DoStats, 1, self);
                self addOpt("Set Insane Stats (2147483647)", ::DoStats, 2, self);
                #endif
                
                #ifdef MP
                self addSlider("Score", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Kills", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Deaths", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Wins", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Losses", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Time Played", 0,0, 2000000000, 100000, ::TestInt);
                #endif
            break;
        case "Unlockables":
            self addMenu("Unlockables", "Unlockables");
                self addOpt("Unlock Everything", ::grab_stats_from_table, self);
                self addOpt("Complete Daily Contracts", ::test);
                self addOpt("Max Out Weapons", ::test);
            break;
        case "ClanTag Options":
            self addMenu("ClanTag Options", "ClanTag Options");
                self addOpt("Custom Tag Editor", ::CustomTagEditor);
            break;
        case "Fun Modifications":
            self addMenu("Fun Modifications", "Fun Modifications");
                self addOpt("Option 1");
            break;
        case "Weapon Manipulation":
            self addMenu("Weapon Manipulation", "Weapon Manipulation");
            #ifdef ZM
                self addOpt("Upgrade Current Weapon", ::UpgradeWeapon, self, self GetCurrentWeapon());
            #endif
                self addOpt("Weapon Selection", ::newMenu, "Weapon Selection");
            break;
        case "Weapon Selection":
            self addMenu("Weapon Selection", "Weapon Selection");
                for(e=0;e<level.WeaponCategories.size;e++)
                self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e] );
            break;
        case "Assault Rifles":
            self addMenu(level.WeaponCategories[0], "Assault Rifles");
                foreach(weap in level.weapons[0])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;        
        case "Submachine Guns":
            self addMenu(level.WeaponCategories[1], "Submachine Guns");
                foreach(weap in level.weapons[1])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Shotguns":
            self addMenu(level.WeaponCategories[2], "Shotguns");
                foreach(weap in level.weapons[2])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Light Machine Guns":
            self addMenu(level.WeaponCategories[3], "Light Machine Guns");
                foreach(weap in level.weapons[3])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Sniper Rifles":
            self addMenu(level.WeaponCategories[4], "Sniper Rifles");
                foreach(weap in level.weapons[4])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Launcher":
            self addMenu(level.WeaponCategories[5], "Launcher");
                foreach(weap in level.weapons[5])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Pistols":
            self addMenu(level.WeaponCategories[6], "Pistols");
                foreach(weap in level.weapons[6])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
            break;
        case "Specials":
            self addMenu(level.WeaponCategories[7], "Specials");
                foreach(weap in level.weapons[7]){
                    if(weap.name == "Beast Weapon" && GetTehMap() != "soe" || weap.name == "The Undead-Zapper" && GetTehMap() != "zm_factory" || weap.name == "H.I.V.E" || weap.name == "Skull of Nan Sepwe" && GetTehMap() != "zns") continue;
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
                }
            break;
        case "Lobby Manipulation":
            self addMenu("Lobby Manipulation", "Lobby Manipulation");
                self addToggleOpt("Toggle Force Host", ::ToggleForceHost, self.ForcingHost);
                #ifdef ZM
                self addSlider("Edit Round: ", level.round_number, 0, 255, 1, ::ChangeTehRound);
                self addOpt("Mystery Box Options", ::newMenu, "Mystery Box");
                self addOpt("Open All Doors / Debris", ::OpenAllDoors);
                #endif
            break;
        #ifdef ZM
        case "Mystery Box":
            self addMenu("Mystery Box", "Mystery Box Options");
                self addToggleOpt("Toggle All Boxes", ::toggle_all_boxes, level.show_all_boxes);
                self addOptSlider("Edit Box Price:", "Free|Default|-1337|1337|5000|-5000|10|-10", ::ChangeBoxPrice);
                self addToggleOpt("Freeze The Box", ::FreezeTheBox, level.BoxCantMove);
            break;
        #endif
        case "AllClients":
            AllOpts = StrTok("Toggle GodMode;Toggle Infinite Ammo;Toggle Third Person;Toggle All Perks;Toggle Currency Loop;Give All Max Rank",";");
            self addMenu("AllClients", "All Clients");
                self addOpt("Verification Level", ::newMenu, "AllAccess");
                for(g=0;g<AllOpts.size;g++)
                    self addOpt(AllOpts[g], ::ClientHandler2, g);
            break;
            
        case "AllAccess":
            self addMenu("AllAccess", "Verification Level");
                for(e=0;e<level.Status.size-1;e++)
                    self addOpt(level.Status[e], ::AllPlayersAccess, e);
            break; 
            
        
        case "Host Debug":
            self addMenu("Host Debug", "Host Debug Settings");
                self addOpt("End Game", ::FastEndGame);
                self addOpt("Music Player", ::newMenu, "Music Player");
                self addOpt("Print Map Name", ::PrintMapName);
                self addOpt("Change Theme To Physics N Flex", ::ChangeTheme, 1);
                self addOpt("Change Theme To Synergy V3", ::ChangeTheme, 0);
                self addOpt("Send Custom Message To All", ::CustomMessage);
                self addOpt("Fast Restart", ::FastRestartGame);
                #ifdef ZM
                if(GetTehMap() == "soe")
                {
                self addOpt("Shadows of Evil Options", ::newMenu, "Shadows Stuff");
                }
                #endif
            break;
        case "Music Player":
            self addMenu("Music Player", "Music Player");
                for(t=0;t<level.TrackNames.size;t++)
                    self addOpt(level.TrackNames[t], ::NewTrack, level.Tracks[t]);
            break;
        #ifdef ZM
        case "Shadows Stuff":
            self addMenu("Shadows Stuff", "Shadows Of Evil");
                self addOpt("Complete EE In One", ::ShadowsEEAll);
                self addOpt("Easter Egg Step Options", ::newMenu, "SOEEE");
                self addOpt("Grab The Summoning Key", ::SKeyGrab, self);
            break;
        case "SOEEE":
            self addMenu("SOEEE", "Shadows EE Options");
            self addOpt("Complete All Rituals", ::ShadowsEE, "Pack a Punch");
            self addOpt("Complete Eggs", ::ShadowsEE, "Eggs");
            self addOpt("Complete Sword Step", ::ShadowsEE, "Swords");
            self addOpt("Complete Upgraded Swords", ::ShadowsEE, "Swords Upgraded");
            self addOpt("Complete Flag Step", ::ShadowsEE, "Flag Step");
            self addOpt("Capture The ShadowMan", ::ShadowsEE, "Boss Fight");
            self addOpt("Kill The Giant Gateworm", ::ShadowsEE, "Full Egg");
            break;
        #endif
        case "GameModes":
            self addMenu("GameModes", "GameModes");
                self addOpt("Mod Menu Lobby", ::newMenu, "MMSettings");
                #ifdef MP
                self addOpt("All Or Nothing", ::GameModeSwitcher, undefined, "All Or Nothing");
                self addOpt("Quickscope Lobby", ::GameModeSwitcher, undefined, "Quickscoping");
                #endif
                #ifdef ZM
                self addOpt("Old School 10th Lobby", ::gameModeSwitcher, undefined, "OldSchool");
                self addOpt("Gun Game", ::gameModeSwitcher, undefined, "GunGame");
                #endif
            break;
        case "MMSettings":
            self addMenu("MMSettings", "Mod Menu Lobby");
                self addOpt("Mod Menu Lobby [All Verified]", ::GameModeSwitcher, "Verified", "ModMenu");
                self addOpt("Mod Menu Lobby [All VIP]", ::GameModeSwitcher, "VIP", "ModMenu");
                self addOpt("Mod Menu Lobby [All Admin]", ::GameModeSwitcher, "Admin", "ModMenu");
                self addOpt("Mod Menu Lobby [All Co-Host]", ::GameModeSwitcher, "Co-Host", "ModMenu");
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
            self addOpt("Give Player Currency", ::ClientHandler1, 4, player);
            if(self isHost()){
                self addOpt("Lock Client Menu", ::ClientHandler1, 13, player);
                self addOpt("Unlock Client Menu", ::ClientHandler1, 14, player);
            }
            break;
        case "Personal Modifications Client":
            self addMenu("Personal Modifications Client", "Personal Modifications "+Name);
                self addToggleOpt("Toggle God Mode", ::ClientHandler1, player.godmode, 0, player);
                self addToggleOpt("Toggle Infinite Ammo", ::ClientHandler1, player.UnlimAmmo, 1, player);
                self addToggleOpt("Toggle Third Person", ::ClientHandler1, player.ThirdPersonToggle, 2, player);
                self addToggleOpt("Toggle All Perks", ::ClientHandler1, player.HasAllPerks, 3, player);
                #ifdef ZM
                self addOpt("Upgrade Client Weapon", ::UpgradeWeapon, player, self GetCurrentWeapon());
                #endif
            break;
        case "Stat Manipulation Client":
            self addMenu("Stat Manipulation Client", "Stat Manipulation "+Name);
                self addOpt("Max Rank", ::ClientHandler1, 5, player);
                #ifdef ZM
                self addOpt("Max Prestige", ::ClientHandler1, 25, player);
                self addOpt("Set Client Legit Stats", ::DoStats, 0, player);
                self addOpt("Set Client Professional Stats", ::DoStats, 1, player);
                self addOpt("Set Client Insane Stats", ::DoStats, 2, player);
                self addOpt("Liquid Divinium Options", ::newMenu, "Liquid Options");
                #endif
                self addOpt("Client Unlock All", ::ClientHandler1, 15, player);
            break;
        #ifdef ZM case "Liquid Options":
            self addMenu("Liquid Options", "Liquid Divinium Options");
                self addOpt("Give 50k Divinium", ::ClientHandler1, 16, player);
                self addOpt("Give 40k Divinium", ::ClientHandler1, 17, player);
                self addOpt("Give 30k Divinium", ::ClientHandler1, 18, player);
                self addOpt("Give 20k Divinium", ::ClientHandler1, 19, player);
                self addOpt("Give 10k Divinium", ::ClientHandler1, 20, player);
                self addOpt("Give 5k Divinium", ::ClientHandler1, 21, player);
                self addOpt("Give 1k Divinium", ::ClientHandler1, 22, player);
                self addOpt("Give 500 Divinium", ::ClientHandler1, 23, player);
                self addOpt("Give 200 Divinium", ::ClientHandler1, 24, player);
                self addSlider("Give Custom Divinium",0,0,100000,1000, ::CustomDiviniumSlider,undefined, undefined, player);
            break;
        #endif
        case "Trolling Options":
            self addMenu("Trolling Options", "Trolling Options");
                self addOpt("Take Client Weapon", ::ClientHandler1, 6, player);
                self addOpt("Take All Client Weapons", ::ClientHandler1, 7, player);
                self addOpt("Drop Current Client Weapon", ::ClientHandler1, 8, player);
                #ifdef ZM
                self addOpt("Down Client", ::ClientHandler1, 10, player);
                #endif
                self addOpt("Kill The Client", ::ClientHandler1, 11, player);
                self addOpt("Kick The Client", ::ClientHandler1, 12, player);
            break;
        case "PAccess":
            self addMenu("PAccess", Name+" Verification");
            for(e=0;e<level.Status.size-1;e++)
                self addToggleOpt(GetAccessName(e), ::initializeSetup, player.access == e, e, player);
            break;
    }
}