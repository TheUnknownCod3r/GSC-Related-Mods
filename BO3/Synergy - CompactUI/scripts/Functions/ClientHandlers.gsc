
ClientHandler1(Func, player)
{
    switch(Func)
    {
        case 0: player thread Godmode(); break;
        case 1: player thread ToggleAmmo(); break;
        case 2: player thread ThirdPersonToggle(); break;
        case 3: player thread AllPerkToggle(); break;
        case 4: player thread CurrencyLoop(); break;
        case 5: player thread MaxRank(); break;
        case 6: player thread WeaponOptions(0); break;
        case 7: player thread WeaponOptions(1); break;
        case 8: player thread WeaponOptions(2); break;
        case 9: break;
        case 10: 
        #ifdef ZM
        self thread DownClient(player); break;
        #endif
        case 11: self thread ExecuteClient(player); break;
        case 12: self thread KickPlayer(player); break;
        case 13: player thread lockMenu("lock"); break;
        case 14: player thread lockMenu("unlock"); break;
        case 15: self thread grab_stats_from_table(player);
        #ifdef ZM
        case 16: player thread GiveLiquidDiviniums(50000); player S("You Just Got ^250000 ^7Divinium"); break;
        case 17: player thread GiveLiquidDiviniums(40000); player S("You Just Got ^240000 ^7Divinium"); break;
        case 18: player thread GiveLiquidDiviniums(30000); player S("You Just Got ^230000 ^7Divinium"); break;
        case 19: player thread GiveLiquidDiviniums(20000); player S("You Just Got ^220000 ^7Divinium"); break;
        case 20: player thread GiveLiquidDiviniums(10000); player S("You Just Got ^210000 ^7Divinium"); break;
        case 21: player thread GiveLiquidDiviniums(5000); player S("You Just Got ^25000 ^7Divinium"); break;
        case 22: player thread GiveLiquidDiviniums(1000); player S("You Just Got ^21000 ^7Divinium"); break;
        case 23: player thread GiveLiquidDiviniums(500); player S("You Just Got ^2500 ^7Divinium"); break;
        case 24: player thread GiveLiquidDiviniums(200); player S("You Just Got ^2200 ^7Divinium"); break;
        #endif
        case 25: player thread MaxPrestige(); break;
    }
}

ClientHandler2(Func)
{
    foreach(client in level.players)
    {
        switch(Func)
        {
            case 0: if (client IsHost()){ client S("Everyone just got ^2God Mode");} else client thread Godmode(); break;
            case 1: if (client IsHost()){ client S("Everyone just got ^2Infinite Ammo");} else client thread ToggleAmmo(); break;
            case 2: if (client IsHost()){ client S("Everyone just got ^2Third Person");} else client thread ThirdPersonToggle(); break;
            case 3: if (client IsHost()){ client S("Everyone just got ^2All Perks");} else client thread AllPerkToggle(); break;
            case 4: if (client IsHost()){ client S("Everyone just got ^2Currency Loop");} else client thread CurrencyLoop(); break;
            case 5: if (client IsHost()){ client S("Everyone just got ^2Max Rank");} else client thread MaxRank(); break;
        }
    }
}