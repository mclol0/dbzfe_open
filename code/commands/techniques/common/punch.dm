Command/Technique
	punch
		name = "punch"
		internal_name = "punch"
		format = "~punch; ?word; ?~searc(mob@melee_range_0)";
		syntax = list("left | right", "mobile")
		priority = 6
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH, DODGE_LEFT, DODGE_RIGHT, BARRIER)
		canFinish = FALSE;
		comboAble = TRUE;
		comboName = "p";
		comboOptions = list("l","r")
		helpCategory = "Basic Combat"
		helpDescription = "Throw a high punch towards your opponent."
		skillDatum = /atkDatum/punch

		command(mob/user, direction, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			direction = determineDirection(direction);

			if(target && direction && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance) && (determinePunch(direction) == PUNCH_LEFT || determinePunch(direction) == PUNCH_RIGHT)){
				if(..(user,target)){
					return;
				}

				if(determinePunch(direction) == PUNCH_LEFT){
					defenses = list(PARRY_HIGH,DODGE_LEFT)
				}else{
					defenses = list(PARRY_HIGH,DODGE_RIGHT)
				}

				send("{B*{x {BYou retract your [direction] arm...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] retracts [user.determineSex(1)] [direction] arm...\n",a_oview_extra(0,user,target))
				send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R retracts [user.determineSex(1)] [direction] arm...{x"] [target.defenseTips(src)]\n",target)

				comboName = comboOption(determinePunch(direction));

				new /atkDatum/punch(user,target,src,getAttackDelay(src, user.fCombat, target),direction)

			}
			else{
				syntax(user, getSyntax())
			}
		}
