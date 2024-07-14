Command/Technique/Form	
	ssjg
		name = "ssjg"
		internal_name = "ssjg"
		format = "~ssjg";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan God"
		helpDescription = "Channeling the power of fellow saiyans and the inner strength of himself, the saiyan is able to tap into their divinity and join the ranks of the gods. This form grants them a considerable increase of power, making them stronger and more resistant."

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Super Saiyan 2" && user.form != "Super Saiyan 3" && user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked = TRUE
					send("{RA faint white glow surrounds your body as you focus your energy and begin tapping into your divinity...{x",user)
					send("{W*{x [user.raceColor(user.name)] {Ris surrounded by a faint white glow as they focus their energy...{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2" || user.form == "Super Saiyan 3"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Super Saiyan God"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{RYour hair and eyes turn red and you're engulfed in a huge, fiery aura!{x",user);
					send("{W*{x {R[user.raceColor(user.name)]{x{R's hair and eyes turn red and they're engulfed in a huge, fiery aura!{x",_ohearers(0,user))
					send("{W*{x {R[user.raceColor(user.name)]{x{R transforms in to a Super Saiyan God!{x",_ohearers(0,user))
					send("{RYou transform in to a Super Saiyan God!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{RRed{x"
					}
					user.visuals["hair_color"] = "{RRed{x"
					user.visuals["eye_color"] = "{RRed{x"
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