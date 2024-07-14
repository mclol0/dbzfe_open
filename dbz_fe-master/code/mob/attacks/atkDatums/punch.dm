atkDatum/punch

	name = "punch";
	minDmg = 4
	maxDmg = 8
	cost = 1

	var
		direction

	New(mob/caller,mob/objective,Command/c,gTime,hand){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			direction = hand
			user._doEnergy(-getCost())
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You throw a [direction]-handed [name] at [target.raceColor(target.name)]!",user)
			send("{R*{x [user.raceColor(user.name)] throws a [direction]-handed [name] at you!",target)
			send("{W*{x [user.raceColor(user.name)] throws a [direction]-handed [name] at [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
		}
		user.fCombat.doDamage(target,minDmg,maxDmg,"punch",command)
	}