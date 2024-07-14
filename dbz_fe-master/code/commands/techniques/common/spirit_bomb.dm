Command/Technique
	spirit_bomb
		name = "spiritbomb"
		internal_name = "spirit bomb"
		format = "~spiritbomb; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 10;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "A focused ball of spiritual energy."
		skillDatum = /fEAttk/spirit_bomb

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
					send("{B* You raise your right hand in the air and begin to summon the lifeforce around you...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] raises [user.determineSex(1)] right hand into the air and begins to summon the lifeforce around [user.determineSex(2)]...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/spirit_bomb(user)
				}else{
					syntax(user,getSyntax());
				}
			}
		}