Command/Technique/Form
	ssj
		name = "ssj"
		internal_name = "ssj"
		format = "~ssj";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Super Saiyan"
		helpDescription = "The first step on the evolution of Saiyans, they break through their barriers increasing their power and strength while giving them the signature yellow hair that has become an indication of strength throughout the galaxy."
		getDescription() {
			return ..("Legendary SSJ")
		}

		command(mob/user) {
			if(user){
				if(user.form != "Normal" && user.form != "Kaioken x4"){
					send("You are already in the [user.form] form!",user)
				} else if(user.race == HALFBREED && user.hasSkill("mystic")) {
					user.locked=TRUE;
					send("{WYou start to calm your mind and focus your power as a silver flares aura around you...{x",user)
					send("{W*{x {W[user.raceColor(user.name)]{x{W starts to calm [user.determineSex(1)] mind and focus [user.determineSex(1)] power as a silver aura flares around [user.determineSex(1)]...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Unlocked"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{WYour silver aura flares violently out around you, bolts of energy interlacing it!{x",user);
					send("{W*{x {W[user.raceColor(user.name)]{x{W's aura flares violently out around [user.determineSex(2)], laced with bolts of energy!{x",_ohearers(0,user))
					send("{W*{x {W[user.raceColor(user.name)]{x{W unlocks [user.determineSex(1)] dormant power!{x",_ohearers(0,user))
					send("{WA calm comes over you as you unlock your dormant power...{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
					}
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				} else if(user.race == LEGENDARY_SAIYAN) {
					user.locked=TRUE;
					send("{YYour rage overtakes your mind as you're engulfed in a {x{YGolden{x{Y aura..{x",user)
					send("{W*{x {x[user.raceColor(user.name)]{x{Y screams as [user.determineSex(1)] hair spikes as a {x{YGolden{x{Y aura engulfs [user.determineSex(2)]...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Legendary SSJ"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{YYour hair turns golden, your eyes turn {x{Ggreen{x{Y as your {x{Genergy{x{Y explodes!{x",user);
					send("{W*{x {x[user.raceColor(user.name)]{x{Y's aura flares violently out around [user.determineSex(2)], laced with bolts of {x{Ggreen{x{Y energy!{x",_ohearers(0,user))
					send("{W*{x {x[user.raceColor(user.name)]{x{Y transforms in to a {x{GLegendary{x{Y Super Saiyan!{x",_ohearers(0,user))
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
						user.visuals["hair_color"] = "{YGolden{x"
					}
					user.visuals["height"] = "Giant"
					user.visuals["build"] = "Muscular"
					user.visuals["eye_color"] = "{GGreen{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				} else if(user.form == "Kaioken x4") {
					user.locked=TRUE;
					user.form = "Normal";
					send("{RYour rage overtakes your mind as you're engulfed in a {x{RRed{x{R aura..{x",user)
					send("{W*{x {x[user.raceColor(user.name)]{x{R screams as [user.determineSex(1)] hair spikes as a {x{RRed{x{R aura engulfs [user.determineSex(2)]...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Super Kaioken"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					alaparser.parse(user, "yell SUPER KAIOKEN!!!!!", list());
					send("{rYou explode with energy!{x",user);
					send("{W*{x {x[user.raceColor(user.name)]{x{R's aura flares violently out around [user.determineSex(2)], laced with bolts of {x{Rred{x{R energy!{x",_ohearers(0,user))
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
						user.visuals["hair_color"] = "{RRed{x"
					}
					user._doEnergy(-5)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
				}else{
					user.locked=TRUE;
					send("{YYour hair spikes up and your muscles bulge as you are engulfed in a golden aura...{x",user)
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y's hair spikes up as [user.determineSex(3)] is engulfed in a golden aura...{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Super Saiyan"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{YYour eyes turn {x{Ggreen{x{Y, and your hair golden!{x",user);
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y's eyes turn {x{Ggreen{x{Y, and [user.determineSex(1)] hair golden!{x",_ohearers(0,user))
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y transforms in to a Super Saiyan!{x",_ohearers(0,user))
					send("{YYou transform in to a Super Saiyan!{x",user)
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{YGolden{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{GGreen{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE;
					//user.changeTurfs(5,"{y,{x");
					//user.changeTurf(/turf/earth/sand,5)
				}
			}
			else{
				syntax(user,src);
			}
		}