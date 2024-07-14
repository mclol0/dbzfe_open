Command/Technique
	burning_attack
		name = "burningattack"
		internal_name = "burning attack"
		format = "~burningattack; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 4;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Channeling energy into your hands, release a slash of energy that cuts through the air to your opponent."
		skillDatum = /fEAttk/burning_attack
		canChangeBarrage = FALSE

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
				syntax(user,getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You form your hands into claws and quickly swipe energy through the air at {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{R* [user.raceColor(user.name)] quickly swipes energy through the air at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] quickly swipes energy through the air...\n",_ohearers(0,user))

			user.kiAttk = new /fEAttk/burning_attack(user,target,src,amount)
		}