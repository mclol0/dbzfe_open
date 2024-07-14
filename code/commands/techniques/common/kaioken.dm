Command/Technique/Form
	kaioken
		name = "kaioken"
		internal_name = "kaioken"
		format = "~kaioken; ?num|?word";
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;
		formName = list("Kaioken x2", "Kaioken x3", "Kaioken x4")
		helpDescription = "Focus your KI and engulf yourself in a crimsom aura that greatly boost your stats at the cost of stamina."

		command(mob/user, level) {
			if(user){
				if(user.hasSkill("fullkaioken")) {
					syntax = list("2-4 | full")
				}else{
					syntax = list("2-4")
				}

				if(isnum(level) && level <= 4 && level > 1){
					var/fC = "Kaioken x[level]";

					if(!(user.form in list("Super Saiyan Blue", "Legendary SSJ", "Legendary SSJ2", "Super Saiyan Rose", "Oozaru", "Super Saiyan", "Super Saiyan 2", "Super Saiyan 3", "Super Saiyan God", "Super Android", "Super Namek", "Enhanced Namek", "Kaioken", "Super Kaioken", fC))){

						var/c = percent(user.currpl,user.getMaxPL())

						switch(level){
							if(2){
								user.form = "Kaioken x2";
								user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
								alaparser.parse(user, "yell KAIOKEN TIMES 2!", list());
							}

							if(3){
								user.form = "Kaioken x3";
								user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
								alaparser.parse(user, "yell KAIOKEN TIMES 3!", list());
							}

							if(4){
								user.form = "Kaioken x4";
								user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
								alaparser.parse(user, "yell KAIOKEN TIMES 4!", list());
							}
						}
						user._doEnergy(-2*level);
						user.CheckForm();
					}else{
						send("You are already in the [user.form] form!",user);
					}
				}else if(TextMatch("full",level,1,1) && user.form == "Normal" && user.hasSkill("fullkaioken")){
					var/Command/Technique/Form/fk = new /Command/Technique/Form/fullkaioken
					fk.kaiokenTrans(user);
				}else{
					syntax(user,getSyntax());
				}
			}else{
				syntax(user,getSyntax());
			}
		}