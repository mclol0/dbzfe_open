Command/Technique/Form
	fullkaioken
		name = "fullkaioken"
		internal_name = "fullkaioken"
		tType = UTILITY;
		formName = "Kaioken"
		helpDescription = "Kaio's racial trait. Being the creators and masters of kaioken, focus your KI an unlock the full potential of Kaioken."

		getSyntax() {}

	proc
		kaiokenTrans(mob/user) {
			if(user){
				if(user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				} else if(user.race == KAIO && user.hasSkill("mystic")) {
					user.locked=TRUE;
					send("{WYour mind snaps as time stands still as you're engulfed in a violent silver aura!{x",user)
					send("{W*{x {W[user.raceColor(user.name)]{x{W's face goes blank as [user.determineSex(3)] is engulfed in a violent silver aura!{x",_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Mystic"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{WYou take a deep breath calming yourself!{x",user);
					send("{W*{x {W[user.raceColor(user.name)]{x{W takes a deep breath as [user.determineSex(3)] crackles with energy!{x",_ohearers(0,user))
					send("{W*{x {W[user.raceColor(user.name)]{x{W unleashes [user.determineSex(1)] Mystic power!{x",_ohearers(0,user))
					send("{WYou unleash your Mystic power!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Mowhawk"
					}
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}else{
					user.locked=TRUE;
					send("{RYour hair spikes up as you are engulfed in a crimson aura...{x",user)
					send("{W*{x [user.raceColor(user.name)]{x{Y's hair spikes up as [user.determineSex(3)] is engulfed in a crimson aura...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Kaioken"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{RYour eyes turn cyan, and your hair turns fiery red!{x",user);
					send("{W*{x [user.raceColor(user.name)]{x{R's eyes turn cyan and [user.determineSex(1)] turns hair fiery red!{x",_ohearers(0,user))
					send("{W*{x [user.raceColor(user.name)]{x{R unlocks the full potential of kaioken!{x",_ohearers(0,user))
					send("{RYou unlock the full potential of kaioken!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{RRed{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{cCyan{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
					//user.changeTurf(/turf/earth/sand,5)
				}
			}
			else{
				syntax(user,syntax);
			}
		}

/*		kaiokenRevert(mob/user) {
			if(user){
				if((user.form in list("Kaioken"))){
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Normal"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
				}else{
					send("You're not transformed!",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}*/