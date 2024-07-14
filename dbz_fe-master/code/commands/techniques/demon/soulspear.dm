Command/Technique
	soulspear
		name = "soulspear"
		internal_name = "soulspear"
		format = "~soulspear; ?num; ?~searc(mob@planet)";
		priority = 1;
		_maxDistance = 4;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Impale your enemies with spears of pure spiritual energy."
		skillDatum = /fEAttk/soulspear

		command(mob/user, amount, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}


			if(amount < 0 || amount > 5){

				syntax(user, getSyntax());
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target){
				syntax(user,getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You create a spear and prepare to throw it at {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{R* [user.raceColor(user.name)] creates a spear in [user.determineSex(1)] hand and draws back to throw!{x [target.defenseTips(src)]\n",target)
			send("{W* [user.raceColor(user.name)] creates a spear in [user.determineSex(1)] hand and draws back to throw...\n{x",_ohearers(0,user))

			user.kiAttk = new /fEAttk/soulspear(user,target,src,amount)
		}