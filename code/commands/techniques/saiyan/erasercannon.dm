Command/Technique
	erasercannon
		name = "erasercannon"
		internal_name = "erasercannon"
		format = "~erasercannon; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Launch a ball of energy towards your opponent."
		skillDatum = /fEAttk/erasercannon

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

			send("{B* You clutch a ball of {Genergy and face {x[target.raceColor(target.name)]{B!{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R clutches {Genergy{x {Rin [user.determineSex(1)] hand and aims at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)]{R clutches {Genergy{x {Rin [user.determineSex(1)] hand and aims at [target.raceColor(target.name)]!\n",a_oview_extra(0,user,target))

			user._doEnergy(-4,TRUE)

			user.kiAttk = new /fEAttk/erasercannon(user,target,src)
		}