Command/Technique/Form
	focused
		name = "focused"
		internal_name = "focused"
		format = "~focused";
		priority = 1
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Focused"
		helpDescription = "A calm and calculated transformation that condenses your energy into razor-sharp control."

		command(mob/user) {
			if(user){
				if(user.form == "Focused"){
					send("You are already in [user.form] form!",user)
				}else{
					user.locked=TRUE;
					send("{cYou calm your breathing as your body sharpens, energy condensing into focused stillness...{x", user)
					send("{W*{x [user.raceColor(user.name)]{W's posture shifts subtly, their aura flickering with precision and control...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl, user.getMaxPL())
					user.form = formName
					user.currpl = clamp(ret_percent(c, user.getMaxPL()), 5, user.getMaxPL())
					send("{cYour eyes narrow, and a faint cyan light hums just beneath your skin.{x", user)
					send("{W*{x [user.raceColor(user.name)]{W's body takes on a subtle, {cglowing hue{x{W.{x", _ohearers(0,user))
					send("{W*{x [user.raceColor(user.name)]{W concentrates [user.determineSex(1)] energy and enters into a {CFocused{x {Wstate.{x", _ohearers(0,user))
					send("{cYou are now {CFocused{x{c.{x", user)
					mOuter("a quiet pulse of refined energy", user, ov_out(1,12,user))

					user.visuals["eye_color"] = "{cPale Blue{x"
					user._doEnergy(-8)
					user.CheckForm()
					user.locked = FALSE
				}
			}
		}