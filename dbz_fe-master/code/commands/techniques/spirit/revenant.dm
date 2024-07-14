Command/Technique/Form
    revenant
        name = "revenant"
        internal_name = "revenant"
        format = "~revenant";
        priority = 3
        _maxDistance = 0;
        iCommand = FALSE;
        tType = UTILITY;
        formName = "Revenant"
        helpDescription = "A revenant is a being who has tirelessly returned from death itself."
        getDescription() {
            return ..("Revenant")
        }

        command(mob/user) {
            if(user) {
                if(user.race != SPIRIT) {
                    send("{DYou are not spiritual enough for this corrupt transformation",user);
                } else if(user.form == "Revenant") {
                    send("{DYou already have the corrupted Revenant transformation consuming your soul",user);
                } else if(user.form != "Spectre") {
                    send("{DYou are not have the spiritual dimensions needed to transform into a Revenant",user);
                } else if(user.race == SPIRIT && user.hasSkill("revenant") && user.form == "Spectre") {
                    user.locked=TRUE;
                    var/c = percent(user.currpl,user.getMaxPL())
                    user.form = "Revenant"                    
                    user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
                    send("{mYou sheer {Messense{m begins to shake and twist with distorting power...{x",user)
                    send("{W*{x {M[user.raceColor(user.name)]{x{m starts distorting [user.determineSex(1)] {Messense{m as it begins to shake with sickening power...{x", _ohearers(0,user))
                    send("{WYour bloody aura flares violently out sickening the air around you.!{x",user);
                    send("{W*{x {W[user.raceColor(user.name)]{x{W's bloody aura flares violently out sickening the air around [user.determineSex(2)]!{x",_ohearers(0,user))                    

                    user._doEnergy(-10)
                    user.CheckForm()
                    mOuter("a sudden surge of energy",user,ov_out(1,12,user));
                    user.locked=FALSE;                    
                }
            } else {
                syntax(user,src);
            }
        }
