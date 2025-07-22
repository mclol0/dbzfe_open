atkDatum/sweep

	name = "sweep";
	minDmg = 6
	maxDmg = 10
	stunChance = 15
	comboChance = 25
	cost = 2

	defense = TRUE;

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
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"sweep",command) && !target.unconscious && !target.stunned && decimal_prob(stunChance) && target.density == TRUE) {
			send("{B*{x {CYou sweep [target.raceColor(target.name)]{C off [target.determineSex(1)] feet!{x",user)
			send("{B*{x {C[user.raceColor(user.name)]{C sweeps you off your feet!{x",target)
			send("{B*{x {C[user.raceColor(user.name)]{C sweeps [target.raceColor(target.name)]{C off [target.determineSex(1)] feet!{x",a_oview_extra(0,user,target))
			stunned(target,user,comboChance=comboChance);
		}
	}