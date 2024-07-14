Command/Technique/Form
	ssj4
		name = "ssj4"
		internal_name = "ssj4"
		format = "~ssj4";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan 4"
		helpDescription = "As they continue to transform, their body once again starts shifting because of the amount of raw energy stored within them. At their fourth transformation, the saiyan acquries a considerable increase in their strength, resistance and overall power."

		getDescription() {
			return ..("Legendary SSJ4")
		}

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Super Saiyan 2" && user.form != "Super Saiyan 3" && user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else if(user.race == LEGENDARY_SAIYAN){
					user.locked=TRUE;
					mOuter("a disturbing sudden surge of energy",user,ov_out(1,12,user));
					send("{gBolts of lightning surge around you as your hair slowly starts to grow!{x",user)
					send("{W*{x {gBolts of lightning surge around [user.raceColor(user.name)]{x{g as [user.determineSex(1)] hair slowly starts to grow!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2" || user.form == "Super Saiyan 3"){ user.checkForm = FALSE; } else { user._doEnergy(-40); }
					user.form = "Legendary SSJ4"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{gYour hair grows down to your waist, and your eyebrows disappear!{x",user);
					send("{W*{x {g[user.raceColor(user.name)]{x{g's hair grows down to [user.determineSex(1)] waist, and [user.determineSex(1)] eyebrows disappear!{x",_ohearers(0,user))
					send("{W*{x {g[user.raceColor(user.name)]{x{g transforms in to a Legendary Super Saiyan 4!{x",_ohearers(0,user))
					send("{gYou transform in to a Legendary Super Saiyan 4!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{DBlack{x"
						user.visuals["hair_length"] = "Shoulder Length"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{YYellow{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a insanely explosive surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}else{
					user.locked=TRUE;
					send("{rBolts of lightning surge around you as your hair slowly starts to grow!{x",user)
					send("{W*{x {rBolts of lightning surge around [user.raceColor(user.name)]{x{r as [user.determineSex(1)] hair slowly starts to grow!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan" || user.form == "Super Saiyan 2" || user.form == "Super Saiyan 3"){ user.checkForm = FALSE; } else { user._doEnergy(-30); }
					user.form = "Super Saiyan 4"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{rYour hair grows down to your shoulders!{x",user);
					send("{W*{x {r[user.raceColor(user.name)]{x{r's hair grows down to [user.determineSex(1)] shoulders, and [user.determineSex(1)] body covered in fur!{x",_ohearers(0,user))
					send("{W*{x {r[user.raceColor(user.name)]{x{r transforms in to a Super Saiyan 4!{x",_ohearers(0,user))
					send("{rYou transform in to a Super Saiyan 4!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{DBlack{x"
						user.visuals["hair_length"] = "Shoulder Length"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{YYellow{x"
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