atkDatum/kick

	name = "kick";
	minDmg = 7
	maxDmg = 11
	cost = 1

	var
		direction

	New(mob/caller,mob/objective,Command/c,gTime,leg){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			direction = leg
			user._doEnergy(-getCost())
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You launch a [direction]-legged [name] at [target.raceColor(target.name)]!",user)
			send("{R*{x [user.raceColor(user.name)] launches a [direction]-legged [name] at you!",target)
			send("{W*{x [user.raceColor(user.name)] launches a [direction]-legged [name] at [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
		}
		user.fCombat.doDamage(target,minDmg,maxDmg,"kick",command)
	}