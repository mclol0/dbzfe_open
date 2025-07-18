Command/Technique
	revert
		name = "revert"
		internal_name = "revert"
		format = "~revert";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Go back to your normal appearance and form. This can only be used on temporary forms."

		command(mob/user) {
			if(user){
				if(user.form in list("FORM 1","FORM 2","FORM 3","FORM 4","GOLDEN FORM 4","FORM 5","GOLDEN FORM 5")){
					if(user.form in list("FORM 2","FORM 3","FORM 4","GOLDEN FORM 4","FORM 5","GOLDEN FORM 5")){
						var/c = percent(user.currpl,user.getMaxPL())
						user.form = "FORM 1"
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
					}else{
						send("You're not transformed!",user)
					}
				} else if(user.form in list("Ultra Instinct","Ultra Instinct Omen")){
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Normal"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
					if(!user.fCombat.hostileTargets.len){ user.activatedUI = FALSE; }
				} else if(user.form in list("Phantasm", "Shade", "Shadow", "Spectre", "Revenant")){
					if(user.form != "Revenant") {
						send("You cannot revert from your [user.form] form!",user)
					} else {
						var/c = percent(user.currpl,user.getMaxPL())
						user.form = "Spectre"
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
						send("{mYou allow your {Mbloodlust{m to subside. You feel your essence return into a calm state", user)
						send("{WYou revert back to your [user.form] form!",user)
					}
				} else if(user.form in list("NeoMachine", "Overclocked")){
					if(user.form != "Overclocked") {
						send("You cannot revert from [user.form]!",user)
					} else {
						var/c = percent(user.currpl,user.getMaxPL())
						user.form = "NeoMachine"
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
						send("{mYou revert your overclocked CPU to it's factory default settings.", user)
					}
				} else {
					if(user.form != "Normal"){
						// Special message for Alien forms
						if(user.form in list("Focused", "Phase-Shift", "Enhanced")){
							send("{BYou exhale slowly as your power fades, your aura dissolving into the air.{x", user)
							send("{B[user.raceColor(user.name)]'s aura flickers and fades as [user.determineSex(3)] returns to normal.{x", _ohearers(0, user))
						}
						var/c = percent(user.currpl,user.getMaxPL())
						user.form = "Normal"
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						if(user.curreng > user.getMaxEN()){ user.curreng = user.getMaxEN(); }
					}else{
						send("You're not transformed!",user)
					}
				}
			}else{
				syntax(user,getSyntax());
			}
		}
