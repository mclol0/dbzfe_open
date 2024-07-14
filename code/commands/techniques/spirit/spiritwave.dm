Command/Technique
	spiritwave
		name = "spiritwave"
		internal_name = "spiritwave"
		format = "~spiritwave; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 5;
		_minDistance = 2;
		tType = ENERGY;
		defenses = list(DUCK,ROUNDHOUSE,ABSORB,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "A devestating wave of spiritual energy that can be charged and built up to unleach a massive amount of damage."
		skillDatum = /fEAttk/spiritwave

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
					syntax(user,getSyntax());
				}
			}else{
				if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance || target && a_get_dist(user,target) <= _maxDistance && (target in user.fCombat.hostileTargets) || !target){
					if(..(user,target)) return
					send("{B* You begin to collect your spiritual power and focus it into palm of your hand. It pulses ...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] collects [user.determineSex(1)] spiritual power and focuses it into the palm of [user.determineSex(1)] hand ...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/spiritwave(user)
				}else{
					syntax(user,getSyntax());
				}
			}
		}
