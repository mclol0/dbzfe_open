Command/Technique/Form
	ssjb
		name = "ssjb"
		internal_name = "ssjb"
		format = "~ssjb";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan Blue"
		helpDescription = "Gathering the power earned through training, the Saiyan is able to continue increasing the power of the god within him through this transformation. The Super Saiyan Blue is basically a Super Saiyan God in Super Saiyan form which grants slighly more power to the god."

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Super Saiyan 2" && user.form != "Super Saiyan 3" && user.form != "Super Saiyan God" && user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked = TRUE
					send("{CYour aura disappears and you close your eyes, calming your energy and sealing all of it inside of you...{x",user)
					send("{W*{x [user.raceColor(user.name)] {Ccloses [user.determineSex(1)] eyes, calming [user.determineSex(1)] energy and sealing it inside...{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2" || user.form == "Super Saiyan 3" || user.form == "Super Saiyan God"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Super Saiyan Blue"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{CYour hair spikes and turns blue, your eyes turn blue and you're engulfed in a bright cyan aura!{x",user);
					send("{W*{x {C[user.raceColor(user.name)]{x{C's hair spikes up and turns blue, [user.determineSex(1)] eyes turn blue and they're engulfed in a bright cyan aura!{x",_ohearers(0,user))
					send("{W*{x {C[user.raceColor(user.name)]{x{C transforms in to Super Saiyan Blue!{x",_ohearers(0,user))
					send("{CYou transform in to Super Saiyan Blue!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{CCyan{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{CCyan{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a massive sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}
			}
			else{
				syntax(user,syntax);
			}
		}