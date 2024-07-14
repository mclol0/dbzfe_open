Command/Technique
	candy_beam
		name = "candybeam"
		internal_name = "candybeam"
		format = "~candybeam; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;
		helpCategory = "Finishers"
		helpDescription = "Genie's unique skill. Use your anntenae's to transform a defeated opponent into a tasty candy for your delight."
		skillDatum = /atkDatum/candy_beam

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(user && target && isloc(user,target) && isinstance(user,target)){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					send("{B*{x {BYou stare intently at {x[target.raceColor(target.name)]'s{x {Bunconscious body...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] stares intently at [target.raceColor(target.name)]'s unconscious body...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R stares intently at you...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/candy_beam(user,target,src,20)
			}
			else{
				syntax(user, getSyntax())
			}
		}