Command/Technique/Form	
	ssjr
		name = "ssjr"
		internal_name = "ssjr"
		format = "~ssjr";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan Rose"
		helpDescription = "The Super Saiyan Rose is the evolution of an evil Super Saiyan God. This form grants the Saiyan with the same benefits of Super Saiyan Blue but it's only available to Evil users."

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Super Saiyan 2" && user.form != "Super Saiyan 3" && user.form != "Super Saiyan God" && user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked = TRUE
					send("{MA glow of dark energy surrounds your body as you focus your energy and begin tapping into your divinity...{x",user)
					send("{W*{x [user.raceColor(user.name)] {Mis surrounded by a glow of dark energy as they focus their energy...{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2" || user.form == "Super Saiyan 3" || user.form == "Super Saiyan God"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Super Saiyan Rose"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{MYour hair spikes and turns pink, your eyes turn grey and you're engulfed in a dark pink aura!{x",user);
					send("{W*{x {M[user.raceColor(user.name)]{x{M's hair spikes up and turns pink, [user.determineSex(1)] eyes turn grey and they're engulfed in a dark pink aura!{x",_ohearers(0,user))
					send("{W*{x {M[user.raceColor(user.name)]{x{M transforms in to Super Saiyan Rose!{x",_ohearers(0,user))
					send("{MYou transform in to Super Saiyan Rose!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{MPink{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{wGrey{x"
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