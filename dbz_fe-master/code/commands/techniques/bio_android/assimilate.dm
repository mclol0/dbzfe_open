Command/Technique
	bio_assimilate
		name = "assimilate"
		internal_name = "bio assimilate"
		format = "~assimilate; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;
		helpCategory = "Finishers"
		helpDescription = " Assimilate a defeated enemies' energy into your body, making you stronger than before."
		skillDatum = /atkDatum/bio_assimilate

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					var/area = pick("STOMACH","SKULL");

					send("{B*{x {BYou stab your tail through [target.raceColor(target.name)]{B's{x {R[pick(area)]{B...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] stabs their tail through [target.raceColor(target.name)]'s {R[area]{x...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R stabs their tail into your [area]...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/bio_assimilate(user,target,src,20)
			}
			else{
				syntax(user, getSyntax())
			}
		}