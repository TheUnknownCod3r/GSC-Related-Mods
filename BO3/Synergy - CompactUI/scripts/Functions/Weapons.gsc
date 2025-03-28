HideGunToggle()
{
    if(!isDefined(self.InvisGun)){self.InvisGun = true;SetDvar("cg_drawGun", "0");self S("Invisible Gun Enabled");}else{self.InvisGun=undefined;SetDvar("cg_drawGun", "1"); self S("Invisible Gun Disabled");}
}

WeaponOptions(i)
{
    weap = self GetCurrentWeapon();
    switch(i)
    {
        case 0: self TakeWeapon(weap); self S("You just had your Weapon ^1Taken"); break;
        case 1: self takeAllWeapons(); self S("You just lost All Your Weapons"); break;
        case 2: self dropItem(weap); self S("Did you just Drop your ^1"+weap); break;
    }
}

GiveWeaponToPlayer(WeaponName, player)
{
    player takeWeapon(player getCurrentWeapon());
    wait .1;
    player GiveWeapon(GetWeapon(WeaponName), player CalcWeaponOptions(randomInt(128), randomInt(5), 2), 0);
    wait .1;
    player switchToWeapon(GetWeapon(WeaponName));
    player S("You Just Got: ^2: "+WeaponName);
}