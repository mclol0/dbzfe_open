atkDatum/stonespit

	name = "stonespit";
	cost = 7
	stunChance = 70
	cdTime = 300 SECONDS

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
		if(!target.unconscious && !target.stunned){
			send("{B* You take a deep breath and prepare to spit at {x[target.raceColor(target.name)]{x",user,TRUE);
			send("{R* {x[user.raceColor(user.name)]{x{R takes a deep breath staring at you!{x",target,TRUE);
			alaparser.parse(user, "emote spits.", list());
			user._doEnergy(-getCost(),TRUE)
			send("{R* You spit a wad of medusa stone at [target.raceColor(target.name)]!{x",user,TRUE);
			send("{C[user.raceColor(user.name)] spits a wad of medusa stone at you!{x",target,TRUE);
			if(decimal_prob(stunChance)){
				stunned(target,user,(world.time + 40))
				game.addCooldown(user.name,command.internal_name, cdTime);
				send("{B* Your medusa spit turns {x[target.raceColor(target.name)]{B to stone!{x",user,TRUE);
				send("{R* {x[user.raceColor(user.name)]'s medusa spit turns you to stone!{x",target,TRUE);
			} else {
				send("[target.raceColor(target.name)]{R* resists your stonespit{R!{x",user,TRUE);
			}
		} else {
			send("[target.raceColor(target.name)] is not stunned!",user)
		}
	}