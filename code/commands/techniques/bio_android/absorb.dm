Command/Technique
	bio_absorb
		name = "absorb"
		internal_name = "bio absorb"
		format = "~absorb; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		canFinish = TRUE;
		needsSTUN = TRUE
		helpCategory = "Advanced Combat"
		helpDescription = "Bio Android's unique skill. Impale your enemy and absorb their life essence directly from their bodies."
		skillDatum = /atkDatum/bio_absorb

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){

				if(target.stunned){
					if(..(user,target)){
						return;
					}

					var/area = pick ("left leg", "right leg","left arm","right arm","stomach","face","chest");

					send("{B*{x {BYou thrust your tail into {x[target.raceColor(target.name)]{B's [area]...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] thrusts their tail into [target.raceColor(target.name)]'s [area]...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R thrusts their tail into your [area]...{x\n",target)

					new /atkDatum/bio_absorb(user,target,src,world.time)
				}else{
					send("They are not stunned!",user)
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}