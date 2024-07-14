Command/Technique
	aura_slide
		name = "auraslide"
		internal_name = "aura slide"
		format = "~auraslide; ?~searc(mob@melee_range_1)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 1;
		tType = MELEE;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Create a blade of energy in your hands and perform a series of quick slashes to your opponent."
		skillDatum = /atkDatum/aura_slide

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou begin forming ki around your hands in the shape of a blade...{x\n",user)
				send("{W*{x Ki begins to form a blade shape around {x[user.raceColor(user.name)]{R hand...\n",a_oview_extra(0,user,target))
				send("{R* {R Ki begins to form a blade shape around {x[user.raceColor(user.name)]{R hand...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/aura_slide(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}