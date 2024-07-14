Command/Technique/Form
    overclock
        name = "overclock"
        internal_name = "overclock"
        format = "~overclock";
        priority = 3
        _maxDistance = 0;
        iCommand = FALSE;
        tType = UTILITY;
        formName = "Overclocked"
        helpDescription = "The revival form of a Neo Machine."
        getDescription() {
            return ..("Overclocked")
        }

        command(mob/user) {

            if(user) {
                if(user.race != REMORT_ANDROID) {
                    send("{DYou do not have the parts to overclock yourself.",user);
                } else if(user.form == "overclock") {
                    send("{DYou components are already overclock to their maximum.",user);
                } else if(user.race == REMORT_ANDROID && user.hasSkill("overclock") && user.form == "NeoMachine") {
                    user.locked=TRUE;
                    var/c = percent(user.currpl,user.getMaxPL())
                    user.form = "Overclocked"                    
                    user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
                    send("{rYou overclock your components and feel a surge of power flow through your circuits.{x",user)
                    send("{W*{x {r[user.raceColor(user.name)]{x{m overclocks [user.determineSex(1)] components and a surge of power flows through them...{x", _ohearers(0,user))            

                    user._doEnergy(-10)
                    user.CheckForm()
                    mOuter("a sudden surge of energy",user,ov_out(1,12,user));
                    user.locked=FALSE;                    
                }
            } else {
                syntax(user,src);
            }
        }
