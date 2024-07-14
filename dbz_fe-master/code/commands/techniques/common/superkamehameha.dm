Command/Technique
	super_kamehameha
		name = "superkamehameha"
		internal_name = "super kamehameha"
		format = "~superkamehameha; ?~searc(mob@planet)";
		syntax = "{csuperkamehameha{x {c\[{x{Cmobile{x{c\]{x"
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		skillDatum = /fEAttk/super_kamehameha
		helpCategory = "KI Attacks"
		helpDescription = "Super charged version of the regular kamehameha."

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
					send("{B* You cup your hands together and form a violent ball of energy...\n{x",user)
					send("{W*{x [user.raceColor(user.name)] cups [user.determineSex(1)] hands together and forms a violent ball of energy...\n",_ohearers(0,user))
					alaparser.parse(user, "yell KAMEHAME...", list());
					user.kiAttk = new /fEAttk/super_kamehameha(user)
				}else{
					syntax(user,getSyntax());
				}
			}
		}