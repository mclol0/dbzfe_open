Command/Technique
	kizan
		name = "kizan"
		internal_name = "kizan"
		format = "~kizan; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(JUMP)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Throw a focused slice of energy towards the legs of your opponent."
		skillDatum = /fEAttk/kizan

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || !target){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}

			send("{B* You cut your hand low across the air at {x[target.raceColor(target.name)]{B!\n{x",user)
			send("{R* {x[user.raceColor(user.name)]{R cuts [user.determineSex(1)] hand low across the air at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] cuts [user.determineSex(1)] hand low across the air at [target.raceColor(target.name)]!\n{x",a_oview_extra(0,user,target))

			user._doEnergy(-3,TRUE)

			user.kiAttk = new /fEAttk/kizan(user,target,src)
		}