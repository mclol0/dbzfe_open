Command/Technique
	roundhouse
		name = "roundhouse"
		internal_name = "roundhouse"
		format = "~roundhouse|rh; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DUCK,SWEEP,BARRIER)
		comboAble = TRUE;
		comboName = "rh";
		helpCategory = "Basic Combat"
		helpDescription = "Basic melee attack. Turn around one of your legs and unleash a high kick to your enemy."
		skillDatum = /atkDatum/roundhouse

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou begin a high sweeping motion...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] begins a high sweeping motion...\n",a_oview_extra(0,user,target))
				send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a high sweeping motion...{x"] [target.defenseTips(src)]\n",target)

				new /atkDatum/roundhouse(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}
