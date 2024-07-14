Command/Technique/Form	
	ssj3
		name = "ssj3"
		internal_name = "ssj3"
		format = "~ssj3";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan 3"
		helpDescription = "Continuing their transformations, Saiyans are able to gather their Ki condensing it into every fiber of their body. On this form, their body is affected by the energy they store within them, giving them even more strength than ever before and making their hair grows down and their eyebrows dissapear."

		getDescription() {
			return ..("Legendary SSJ3")
		}

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Super Saiyan 2" && user.form != "Normal" && user.form != "Legendary SSJ" && user.form != "Legendary SSJ2"){
					send("You are already in the [user.form] form!",user)
				}else if(user.race == LEGENDARY_SAIYAN){
					user.locked=TRUE;
					mOuter("a disturbing sudden surge of energy",user,ov_out(1,12,user));
					send("{gBolts of lightning surge around you as your hair slowly starts to grow!{x",user)
					send("{W*{x {gBolts of lightning surge around [user.raceColor(user.name)]{x{g as [user.determineSex(1)] hair slowly starts to grow!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2"){ user.checkForm = FALSE; } else { user._doEnergy(-40); }
					user.form = "Legendary SSJ3"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{gYour hair grows down to your waist, and your eyebrows disappear!{x",user);
					send("{W*{x {g[user.raceColor(user.name)]{x{g's hair grows down to [user.determineSex(1)] waist, and [user.determineSex(1)] eyebrows disappear!{x",_ohearers(0,user))
					send("{W*{x {g[user.raceColor(user.name)]{x{g transforms in to a Legendary Super Saiyan 3!{x",_ohearers(0,user))
					send("{gYou transform in to a Legendary Super Saiyan 3!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{YGolden{x"
						user.visuals["hair_length"] = "Long"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["height"] = "Giant"
					user.visuals["build"] = "Muscular"
					user.visuals["eye_color"] = "{WWhite{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a insanely explosive surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}else{
					user.locked=TRUE;
					send("{YBolts of lightning surge around you as your hair slowly starts to grow!{x",user)
					send("{W*{x {YBolts of lightning surge around [user.raceColor(user.name)]{x{Y as [user.determineSex(1)] hair slowly starts to grow!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2"){ user.checkForm = FALSE; } else { user._doEnergy(-20); }
					user.form = "Super Saiyan 3"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{YYour hair grows down to your waist, and your eyebrows disappear!{x",user);
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y's hair grows down to [user.determineSex(1)] waist, and [user.determineSex(1)] eyebrows disappear!{x",_ohearers(0,user))
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y transforms in to a Super Saiyan 3!{x",_ohearers(0,user))
					send("{YYou transform in to a Super Saiyan 3!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{YGolden{x"
						user.visuals["hair_length"] = "Long"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{GGreen{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}
			}
			else{
				syntax(user,src);
			}
		}