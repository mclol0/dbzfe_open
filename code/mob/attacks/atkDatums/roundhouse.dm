atkDatum/roundhouse

	name = "roundhouse";
	minDmg = 7
	maxDmg = 11
	cost = 2

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
		if(!user.unconscious){
			send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
			send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
		}
		user.fCombat.doDamage(target,minDmg,maxDmg,"roundhouse",command)
	}