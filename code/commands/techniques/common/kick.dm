Command/Technique
	kick
		name = "kick"
		internal_name = "kick"
		format = "~kick; ?word; ?~searc(mob@melee_range_0)";
		syntax = list("left | right", "mobile")
		priority = 5
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_LOW, DODGE_LEFT, DODGE_RIGHT, BARRIER)
		canFinish = FALSE;
		comboAble = TRUE;
		comboName = "k";
		comboOptions = list("l","r")
		helpCategory = "Basic Combat"
		helpDescription = "Basic melee attack. Launch a kick towards your opponent to one of his sides."
		skillDatum = /atkDatum/kick

		command(mob/user, direction, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			direction = determineDirection(direction);

			if(target && direction && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance) && (determineKick(direction) == KICK_LEFT || determineKick(direction) == KICK_RIGHT)){
				if(..(user,target)){
					return;
				}

				if(determineKick(direction) == KICK_LEFT){
					defenses = list(PARRY_LOW,DODGE_LEFT,BARRIER)
				}else{
					defenses = list(PARRY_LOW,DODGE_RIGHT,BARRIER)
				}

				send("{B*{x {BYou curl your [direction] leg...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] curls [user.determineSex(1)] [direction] leg...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R curls [user.determineSex(1)] [direction] leg...{x [target.defenseTips(src)]\n",target)

				comboName = comboOption(determineKick(direction));

				new /atkDatum/kick(user,target,src,getAttackDelay(src, user.fCombat, target),direction)
			}
			else{
				syntax(user, getSyntax())
			}
		}
