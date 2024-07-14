Command/Technique
	death_beam
		name = "deathbeam"
		internal_name = "death beam"
		format = "~deathbeam; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Focus your energy into a piercing beam meant to maim your opponents."
		skillDatum = /fEAttk/death_beam

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
					//if(x && user && target && user.loc == target.loc && x.chCount >= x.mnCh){x.hit(target)}
				}else{
					syntax(user, getSyntax());
				}
			}else{
				if(!target){
					if(..(user,target)) return
					send("{B* You raise your index finger into the air...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] points [user.determineSex(1)] index finger into the air...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/death_beam(user)
				}else if(target){
					if(..(user,target)) return
					send("{B* You raise your index finger into the air...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] points [user.determineSex(1)] index finger into the air...\n",_ohearers(0,user))
					user.kiAttk = new /fEAttk/death_beam(user)
					var/fEAttk/death_beam/x = user.kiAttk
					x.delayedDBeam(src,target)
					/*x.go(target,src)
					if(user.loc == target.loc && x.chCount >= x.mnCh){x.hit(target)}*/
				}else{
					syntax(user,getSyntax());
				}
			}
		}