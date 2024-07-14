Command/Technique
	retsuzan
		name = "retsuzan"
		internal_name = "retsuzan"
		format = "~retsuzan; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Genie's chargeable energy attack. Focusing their energy in their belly, they unleash a powerul beam attack that yields destruction in its wake."
		skillDatum = /fEAttk/retsuzan

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
					syntax(user,getSyntax());
				}
			}else{
				if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance || target && a_get_dist(user,target) <= _maxDistance && (target in user.fCombat.hostileTargets) || !target){
					if(..(user,target)) return
					send("{B* You inhale a huge amount of air...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] inhales a huge amount of air...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/retsuzan(user)
				}else{
					syntax(user,getSyntax());
				}
			}
		}