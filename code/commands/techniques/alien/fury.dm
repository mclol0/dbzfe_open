Command/Technique
	fury
		name = "fury"
		internal_name = "fury"
		format = "~fury; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = NULL;
		comboAble = FALSE;
		needsSTUN = TRUE;
		helpCategory = "Advanced Combat"
		helpDescription = "Release a burst of energy and unleash a flurry of blows against your opponent that throws him off the room at the end."
		skillDatum = /atkDatum/alien_fury

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				if(target.stunned){
					send("{B*{x {BYou take an aggressive stance and begin to {x{Wglow{x...\n",user)
					send("{W*{x [user.raceColor(user.name)] takes an aggressive stance and begins to {Wglow{x...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R takes an aggressive stance and begins to {Wglow{x{R...{x [target.defenseTips(src)]\n",target)

					//user._doEnergy(-(5 + a_get_dist(user,target)))
					new skillDatum(user,target,src,world.time,pick(NORTH,SOUTH,EAST,WEST))

					return TRUE;
				}else{
					send("They're not stunned!",user,TRUE);
					return FALSE;
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}