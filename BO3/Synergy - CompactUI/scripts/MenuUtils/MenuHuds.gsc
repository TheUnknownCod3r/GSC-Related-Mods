drawMenu()
{  
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["UI"]))
        self.menu["UI"] = [];
    if(self.menu["Theme"]["Default"] == true){
        self.menu["UI"]["OPT_BG"] = self createRectangle("TOPLEFT", "TOP", -425, 90, 170, int(numOpts*15) + 45, self.menuSetting["BackgroundGradRainbow"], "white", 0, 0, true);
        self.menu["UI"]["OPT_BG"] affectElement("alpha", .2, .6);
    
        self.menu["UI"]["BGTitle"] = self createRectangle("TOPLEFT", "TOP", -425, 90, 170, 30, self.menuSetting["BannerNoneRainbow"], "white", 1, 0, true);
        self.menu["UI"]["BGTitle"] affectElement("alpha",.2,.6);
    
        self.menu["UI"]["BGTitle_Grad"] = self createRectangle("TOPLEFT", "TOP", -425, 90, 170, 30, self.menuSetting["BannerGradRainbow"], "white", 3, 0, true);
        self.menu["UI"]["BGTitle_Grad"] affectElement("alpha", .2, .6);
    
        self.menu["UI"]["CUR_TITLE"] = self createRectangle("LEFT", "CENTER", -425, -112, 170, 15, (0, 0, 0), "white", 4, 0, true);
        self.menu["UI"]["CUR_TITLE"] affectElement("alpha",.2, 1);
    
        self.menu["UI"]["SCROLL"] = self createRectangle("CENTER", "TOP", -340, 0, 170, 16, self.menuSetting["ScrollerGradRainbow"], "white", 3, 0, true);
        self.menu["UI"]["SCROLL"] affectElement("alpha", .2, .6);
    }
    else if(self.menu["Theme"]["Flex"] == true)
    {
        self.menu["UI"]["OPT_BG"] = self createRectangle("CENTER", "CENTER", 0, -185, 250, int(numOpts*15) + 100, self.menuSetting["BackgroundGradRainbow"], "white", 0, 0, true);
        self.menu["UI"]["OPT_BG"] affectElement("alpha", .2, .6);
    
        self.menu["UI"]["BGTitle"] = self createRectangle("CENTER", "CENTER", 0, -210, 250, 10, self.menuSetting["BannerNoneRainbow"], "white", 1, 0, true);
        self.menu["UI"]["BGTitle"] affectElement("alpha",.2,.6);
    
        self.menu["UI"]["BGTitle_Grad"] = self createRectangle("CENTER", "CENTER", 0, -210, 250, 12, self.menuSetting["BannerGradRainbow"], "white", 3, 0, true);
        self.menu["UI"]["BGTitle_Grad"] affectElement("alpha", .2, .6);
    
        self.menu["UI"]["CUR_TITLE"] = self createRectangle("CENTER", "CENTER", 0, -245, 250, 10, (0, 0, 0), "white", 4, 0, true);
        self.menu["UI"]["CUR_TITLE"] affectElement("alpha",.2, 1);
    
        self.menu["UI"]["SCROLL"] = self createRectangle("CENTER", "CENTER", 0, -203, 250, 12, self.menuSetting["ScrollerGradRainbow"], "white", 3, 0, true);
        self.menu["UI"]["SCROLL"] affectElement("alpha", .2, .6);
    }
}

drawText()
{
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["OPT"]))
        self.menu["OPT"] = [];
    if(!IsDefined(self.menu["OPT"]["OPTScroll"]))
        self.menu["OPT"]["OPTScroll"] = [];
    if(self.menu["Theme"]["Default"] == true){  
        self.menu["OPT"]["TITLE"] = self createText("default", 1.5, "CENTER", "TOP", -340, 105, 10, 0, "Synergy V3", (1, 1, 1), true);
        self.menu["OPT"]["TITLE"] affectElement("alpha",.4,1);
    
        self.menu["OPT"]["SUB_TITLE"] = self createText("default", 1, "LEFT", "TOP", -422, 127, 10, 0, self.menuTitle, (1, 1, 1), true);
        self.menu["OPT"]["SUB_TITLE"] affectElement("alpha", .4, 1);
    
        self.menu["OPT"]["OPTSize"] = self createText("default", 1, "RIGHT", "TOP", -260, 127, 10, 0, self getCursor() + 1 + "/" + self.eMenu.size, (1, 1, 1), true);
        self.menu["OPT"]["OPTSize"] affectElement("alpha",.4, 1);
    
        for(e=0;e<8;e++)
        {
            self.menu["OPT"][e] = self createText("default", 1, "LEFT", "TOP", -422, 142 + e*15, 4, 0, "", (1, 1, 1), true);
            self.menu["OPT"][e] affectElement("alpha",.4, 1);
        }
    }
    else if(self.menu["Theme"]["Flex"] == true)
    {
        self.menu["OPT"]["TITLE"] = self createText("default", 1.3, "CENTER", "CENTER", 0, -232, 10, 0, "Synergy V3", (1, 1, 1), true);
        self.menu["OPT"]["TITLE"] affectElement("alpha",.4,1);
    
        self.menu["OPT"]["SUB_TITLE"] = self createText("default", 1.2, "LEFT", "CENTER", -118, -210, 10, 0, self.menuTitle, (1, 1, 1), true);
        self.menu["OPT"]["SUB_TITLE"] affectElement("alpha", .4, 1);
    
        self.menu["OPT"]["OPTSize"] = self createText("default", 1.2, "CENTER", "CENTER", 112, -210, 10, 0, self getCursor() + 1 + "/" + self.eMenu.size, (1, 1, 1), true);
        self.menu["OPT"]["OPTSize"] affectElement("alpha",.4, 1);
    
        for(e=0;e<8;e++)
        {
            self.menu["OPT"][e] = self createText("default", 1.2, "LEFT", "CENTER", -121, -195 + e*12, 4, 0, "", (1, 1, 1), true);
            self.menu["OPT"][e] affectElement("alpha",.4, 1);
        }
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
        if(self.menu["Theme"]["Default"] == true){
            if(IsDefined(self.eMenu[ary + e].val))
                self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1, "RIGHT", "TOP", -260, 142 + e*15, 5, 1, "" + ((!isDefined(self.sliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].val : self.sliders[self getCurrentMenu() + "_" + (ary + e)]), (1, 1, 1), true);
        
            if(IsDefined(self.eMenu[ary + e].optSlide))
                self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1, "RIGHT", "TOP", -260, 142 + e*15, 5, 1, ((!isDefined(self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].optSlide[0] + " [" + 1 + "/" + self.eMenu[ary + e].optSlide.size + "]" : self.eMenu[ary + e].optSlide[self.Optsliders[self getCurrentMenu() + "_" + (ary + e)]] + " [" + ((self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])+1) + "/" + self.eMenu[ary + e].optSlide.size + "]"), (1, 1, 1), true);
        }
        else if(self.menu["Theme"]["Flex"] == true)
        {
            if(IsDefined(self.eMenu[ary+e].val))
                self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1.2, "CENTER", "CENTER", 121, -185 + e*12, 5, 1,"" + ((!isDefined(self.sliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].val : self.sliders[self getCurrentMenu() + "_" + (ary + e)]), (1, 1, 1), true);
            
            if(IsDefined(self.eMenu[ary+e].optSlide))
                self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1.2, "CENTER", "CENTER", 121, -185 + e*12, 5, 1, ((!isDefined(self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].optSlide[0] + " [" + 1 + "/" + self.eMenu[ary + e].optSlide.size + "]" : self.eMenu[ary + e].optSlide[self.Optsliders[self getCurrentMenu() + "_" + (ary + e)]] + " [" + ((self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])+1) + "/" + self.eMenu[ary + e].optSlide.size + "]"), (1, 1, 1), true);
        }
    }
}

resizeMenu()
{
    if(self.menu["Theme"]["Default"] == true){
        numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
        self.menu["UI"]["OPT_BG"] setShader("white", 170, int(numOpts*15) + 45);
    }
    else if(self.menu["Theme"]["Flex"] == true){
        numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
        self.menu["UI"]["OPT_BG"] setShader("white", -185, int(numOpts*15) + 100);
    }
}

refreshTitle()
{
    self.menu["OPT"]["SUB_TITLE"] setText(self.menuTitle);
}

refreshOPTSize()
{
    self.menu["OPT"]["OPTSize"] setText(self getCursor() + 1 + "/" + self.eMenu.size);
}