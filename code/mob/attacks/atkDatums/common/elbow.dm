atkDatum/elbow

	name = "elbow";
	minDmg = 6
	maxDmg = 10
	cost = 4

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
			if(user.getArea() == target.getArea() && a_get_dist(user,target) <= 16){
				send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
				user.density=target.density
				if(user.getArea() == target.getArea()){ user.loc = target.loc; }
				send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
				user.fCombat.doDamage(target,minDmg,maxDmg,"elbow",command)
			}
		}
	}