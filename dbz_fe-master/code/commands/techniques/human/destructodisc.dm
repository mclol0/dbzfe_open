Command/Technique
	destructodisc
		name = "destructodisc"
		internal_name = "destructo disc"
		format = "~destructodisc; ?num; ?~searc(mob@planet)";
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Raise your hand over your head and focus your KI in a spinning disc that can cut through anything on its path."
		skillDatum = /fEAttk/destructodisc

		command(mob/user, amount=1, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target || amount > 4 || amount < 1){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You raise your hand above your head and lock on to {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{W*{x [user.raceColor(user.name)] raises [user.determineSex(1)] hand above [user.determineSex(1)] head and locks on to [target.raceColor(target.name)]...\n",_ohearers(0,user))

			user.kiAttk = new /fEAttk/destructodisc(user,target,src,amount)
		}