Command/Technique
	spin_kick
		name = "spinkick"
		internal_name = "spin kick"
		format = "~spinkick; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = TRUE;
		comboName = "spin";
		helpCategory = "Advanced Combat"
		helpDescription = "Jump in the air while doing a rotating motion to launch a powerful kick to your opponent."
		skillDatum = /atkDatum/spin_kick

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou jump up and start twisting in the air...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] jumps up and starts twisting in the air...\n",a_oview_extra(0,user,target))
				send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R jumps up and starts twisting in the air...{x"] [target.defenseTips(src)]\n",target)

				new /atkDatum/spin_kick(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}
