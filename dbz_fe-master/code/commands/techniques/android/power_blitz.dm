Command/Technique
	power_blitz
		name = "powerblitz"
		internal_name = "power blitz"
		format = "~powerblitz; ?~searc(mob@planet)";
		priority = 1;
		_maxDistance = 4;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		skillDatum = /fEAttk/power_blitz
		helpCategory = "KI Attacks"
		helpDescription = "Unleash a rain of energy blasts towards your enemy."

		command(mob/user, mob/target=user:fCombat._getLastTarget(), amount=3) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || !target || amount > 3 || amount < 3){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You extend your hand out and aim at {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{R* {x[user.raceColor(user.name)]{R extends their hand out and aims at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] extends their hand out and aims at [target.raceColor(target.name)]...\n",_ohearers(0,user))

			user.kiAttk = new /fEAttk/power_blitz(user,target,src,amount)
		}