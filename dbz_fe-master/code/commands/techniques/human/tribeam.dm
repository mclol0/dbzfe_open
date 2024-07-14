Command/Technique
	tri_beam
		name = "tribeam"
		internal_name = "tri-beam"
		format = "~tribeam; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,PARRY_HIGH,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Destructive KI Attack. Focus your energy in an area in front of you, aiming with your arms out and a form a diamond in your hands, then release that energy in the area"
		skillDatum = /fEAttk/tri_beam

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
					send("{B* You extend your arms out and form a diamond with your hands...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] extends [user.determineSex(1)] arms out and forms a diamond with [user.determineSex(1)] hands...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/tri_beam(user)
				}else{
					syntax(user,getSyntax());
				}
			}
		}