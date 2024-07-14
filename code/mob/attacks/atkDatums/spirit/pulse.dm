atkDatum
	pulse
		name = "pulse"
		stunChance = 85
		comboChance = 0
		cost = 50
		cdTime = 100 SECONDS

		New(mob/caller,mob/objective,Command/c,gTime){
			if (caller && objective) {
				user = caller
				user.atkDat = src
				target = objective
				AID = ++user.aID
				goTime = gTime
				command = c
				user._doEnergy(-getCost())
				..()
			}
		}

		go(){
			send("{mAN IMMENSE SPIRITUAL PULSE HITS YOU!", target, TRUE);
			send("{mAN IMMENSE SPIRITUAL PULSE HITS YOU!", target, TRUE);
			send("{mAN IMMENSE SPIRITUAL PULSE HITS YOU!", target, TRUE);
			send("{R*{x You feel immobilized by [user.raceColor(user.name)]'s spiritual pressure pulsing over you!",target,TRUE);
			stunned(target,user,comboChance=comboChance);
			game.addCooldown(user.name,command.internal_name, cdTime);
		}
