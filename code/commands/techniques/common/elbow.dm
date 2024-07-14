Command/Technique
	elbow
		name = "elbow"
		internal_name = "elbow"
		format = "~elbow; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 3
		_maxDistance = 8;
		_minDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DODGE_LEFT,DODGE_RIGHT,BARRIER)
		canFinish = FALSE;
		comboAble = TRUE;
		comboName = "el";
		helpCategory = "Advanced Combat"
		helpDescription = "Charge against your opponent ready to hit him your elbow."
		skillDatum = /atkDatum/elbow

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {
			if(target && a_get_dist(user,target) <= _maxDistance && a_get_dist(user,target) >= _minDistance){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou begin a elbow charging motion...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] begins a elbow charging motion...\n",a_oview_extra(0,user,target))
				send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a elbow charging motion...{x"] [target.defenseTips(src)]\n",target)

				new /atkDatum/elbow(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}
