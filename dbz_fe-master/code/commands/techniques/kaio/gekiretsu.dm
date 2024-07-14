Command/Technique
	gekiretsu
		name = "gekiretsu"
		internal_name = "gekiretsu"
		format = "~gekiretsu; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Send a rain of energy blasts to your enemy."
		skillDatum = /fEAttk/gekiretsu

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk){
				if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance || target && a_get_dist(user,target) <= _maxDistance && (target in user.fCombat.hostileTargets)){
					if(user.kiAttk:isReady() && ..(user,target,TRUE,name)){
						return;
					}
					var/fEAttk/x = user.kiAttk
					x.go(target,src)
					////if(x && user && target && user.loc == target.loc && x.chCount >= x.mnCh){x.hit(target)}
				}else{
					syntax(user, getSyntax());
				}
			}else{
				if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance || target && a_get_dist(user,target) <= _maxDistance && (target in user.fCombat.hostileTargets) || !target){
					if(..(user,target)) return
					send("{B* You horse stance as bright balls of energy form in your palms, crackling with energy...\n{x",user)
					send("{W*{x [user.raceColor(user.name)]{x{W horse stances as bright balls of energy form in [user.determineSex(1)] palms, crackling with energy...\n{x",_ohearers(0,user))
					user.kiAttk = new /fEAttk/gekiretsu(user)
				}else{
					syntax(user, getSyntax());
				}
			}
		}