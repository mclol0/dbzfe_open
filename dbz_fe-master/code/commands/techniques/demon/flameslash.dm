Command/Technique
	flameslash
		name = "flameslash"
		internal_name = "flameslash"
		format = "~flameslash; ?num; ?~searc(mob@planet)";
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Energy attack unique to Demons. Unleash energy waves that transform into pure flame against an enemy."
		skillDatum = /fEAttk/flameslash

		command(mob/user, amount, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}


			if(amount < 0 || amount > 3){

				syntax(user,getSyntax());
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target){
				syntax(user,getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* Your hands begin to glow as you face {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{W*{x [user.raceColor(user.name)] faces you as [user.determineSex(1)] hands begin to glow...{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] faces [target] as [user.determineSex(1)] hands begin to glow...\n",_ohearers(0,user))

			user._doEnergy(-2,TRUE)
			user.kiAttk = new /fEAttk/flameslash(user,target,src,amount)
		}