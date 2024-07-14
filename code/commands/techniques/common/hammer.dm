Command/Technique
	hammer
		name = "hammer"
		internal_name = "hammer"
		format = "~hammer; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = TRUE;
		comboName = "ham";
		helpCategory = "Advanced Combat"
		helpDescription = "Hit your opponent with a powerful hammer technique by clasping your hands above your head."
		skillDatum = /atkDatum/hammer

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou clasp your hands above your head...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] clasps [user.determineSex(1)] hands above [user.determineSex(1)] head...\n",a_oview_extra(0,user,target))
				send("{R*{x [user.raceColor(user.name)]{R clasps [user.determineSex(1)] hands above [user.determineSex(1)] head...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/hammer(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}