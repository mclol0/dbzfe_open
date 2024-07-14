Command/Technique
	specialbeamcannon
		name = "specialbeamcannon"
		internal_name = "special beam cannon"
		format = "~specialbeamcannon; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Namek's unique skill. Placing two fingers to your forehead and focusing energy with your antennae, release a powerful energy attack in a straight line towards your front."
		skillDatum = /fEAttk/specialbeamcannon

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != internal_name){
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
					//if(x && user && target && user.loc == target.loc && x.chCount >= x.mnCh){x.hit(target)}
				}else{
					syntax(user, getSyntax());
				}
			}else{
				if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance || target && a_get_dist(user,target) <= _maxDistance && (target in user.fCombat.hostileTargets) || !target){
					if(..(user,target)) return
					send("{B* You put two fingers to your forehead...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] puts two fingers to [user.determineSex(1)] forehead...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/specialbeamcannon(user)
				}else{
					syntax(user, getSyntax());
				}
			}
		}