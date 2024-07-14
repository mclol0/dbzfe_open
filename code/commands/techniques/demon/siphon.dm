Command/Technique
	siphon
		name = "siphon"
		internal_name = "siphon"
		format = "~siphon; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		canFinish = TRUE;
		needsSTUN = TRUE
		helpCategory = "Advanced Combat"
		helpDescription = "Gaze into your opponents eyes and drain their life force."
		skillDatum = /atkDatum/siphon

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){

				if(target.stunned){
					if(..(user,target)){
						return;
					}
					send("{B*{x {BYou lock eyes with {x[target.raceColor(target.name)]{B...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] stares into [target.raceColor(target.name)]'s eyes...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R stares right through you...{x\n",target)

					new /atkDatum/siphon(user,target,src,world.time)
				}else{
					send("They are not stunned!",user)
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}