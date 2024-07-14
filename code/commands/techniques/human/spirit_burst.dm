Command/Technique/Form
	spirit_burst
		name = "spiritburst"
		internal_name = "spirit_burst"
		format = "~spiritburst";
		priority = 1
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Spirit Burst"
		helpDescription = "Reach into your inner strength and tap into your spiritual energy to unlock higher limits of your power. A white aura will surround your body while you are in this state."

		command(mob/user) {

			if(user){

				/*if(user.form == "Spirit Burst"){
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Normal"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
				}else */if(user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else{
					var/c = percent(user.currpl,user.getMaxPL())
					user.locked=TRUE;
					send("{WYou take a horse stance...{x",user);
					send("{W*{x [user.raceColor(user.name)] {Wtakes a horse stance...{x",_ohearers(0,user))
					sleep(10);
					send("{B*{x {WA white aura bursts around you!{x",user);
					send("{W*{x {WA white aura bursts around{x [user.raceColor(user.name)]{W!{x",_ohearers(0,user))
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.form = "Spirit Burst";
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					user._doEnergy(-8)
					user.CheckForm()
					user.locked=FALSE;
				}

			}
			else{
				syntax(user, getSyntax())
			}
		}