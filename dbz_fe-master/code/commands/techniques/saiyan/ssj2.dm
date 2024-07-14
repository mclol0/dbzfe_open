Command/Technique/Form	
	ssj2
		name = "ssj2"
		internal_name = "ssj2"
		format = "~ssj2";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan 2"
		helpDescription = "As the Saiyan power continues to rise, he's able to reach another level in their transformations that grants them even more strength than they previously had."

		getDescription() {
			return ..("Legendary SSJ2")
		}

		command(mob/user) {
			if(user){
				if(user.form != "Super Saiyan" && user.form != "Unlocked" && user.form != "Normal" && user.form != "Legendary SSJ"){
					send("You are already in the [user.form] form!",user)
				} else if(user.race == HALFBREED && user.hasSkill("mystic")) {
					user.locked=TRUE;
					send("{WYour muscles bulge and expand as you power up, engulfed in a violent silver aura!{x",user)
					send("{W*{x {W[user.raceColor(user.name)]{x{W's muscles bulge and expand as [user.determineSex(3)] powers up, engulfed in a violent silver aura!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Unlocked"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Mystic"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{WYour hair spikes up as you crackle with energy!{x",user);
					send("{W*{x {W[user.raceColor(user.name)]{x{W's hair spikes more as [user.determineSex(3)] crackles with energy!{x",_ohearers(0,user))
					send("{W*{x {W[user.raceColor(user.name)]{x{W unleashes [user.determineSex(1)] Mystic power!{x",_ohearers(0,user))
					send("{WYou unleash your Mystic power!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
					}
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				} else if(user.race == LEGENDARY_SAIYAN) {
					user.locked=TRUE;
					send("{YYour muscles bulge, and your skin splits as {GGreen energy{x{Y pulsates beneath your skin..{x",user)
					send("{W*{x {x[user.raceColor(user.name)]{x{Y's muscles bulge and [user.determineSex(1)] skin splits as a {x{Ggreen{x{Y aura engulfs [user.determineSex(2)]...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Legendary SSJ"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Legendary SSJ2"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{YYour hair turns golden, your eyes turn white and your energy explodes!{x",user);
					send("{W*{x {x[user.raceColor(user.name)]{x{Y's aura flares violently out around [user.determineSex(2)], laced with bolts of {x{Ggreen{x{Y energy!{x",_ohearers(0,user))
					send("{W*{x {x[user.raceColor(user.name)]{x{Y transforms in to a {x{GLegendary{x{Y Super Saiyan 2!{x",_ohearers(0,user))
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
						user.visuals["hair_color"] = "{GGreen{x"
					}
					user.visuals["height"] = "Giant"
					user.visuals["build"] = "Muscular"
					user.visuals["eye_color"] = "{WWhite{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}else{
					user.locked=TRUE;
					send("{YYour muscles increase in size a little, as you are engulfed in a golden aura!{x",user)
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y's muscles increase in size a little, as [user.determineSex(3)] is engulfed in a golden aura!{x",_ohearers(0,user))
					sleep(10);
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "Super Saiyan"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "Super Saiyan 2"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{YYour hair spikes more and your eyes turn {x{gemerald{x{Y as you crackle with energy!{x",user);
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y's hair spikes more and [user.determineSex(1)] eyes turn {x{Gemerald{x{Y as [user.determineSex(3)] crackles with energy!{x",_ohearers(0,user))
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y transforms in to a Super Saiyan 2!{x",_ohearers(0,user))
					send("{YYou transform in to a Super Saiyan 2!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{YGolden{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{gEmerald{x"
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