Command/Technique
	gack
		name = "gack"
		internal_name = "gack"
		format = "~gack; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,DEFLECT,ABSORB,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Genie's unique skill. Fire an energy blast from your mouth."
		skillDatum = /fEAttk/gack

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

			send("{B* You open your mouth and aim at {x[target.raceColor(target.name)]{B!{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R opens [user.determineSex(1)] mouth and aims at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] opens [user.determineSex(1)] mouth and aims at [target.raceColor(target.name)]!\n",a_oview_extra(0,user,target))

			user._doEnergy(-6,TRUE)

			user.kiAttk = new /fEAttk/gack(user,target,src)
		}