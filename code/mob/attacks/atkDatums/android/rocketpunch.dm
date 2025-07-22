atkDatum/rocketpunch

	name = "rocketpunch";
	minDmg = 3.00
	maxDmg = 6.00
	cdTime = 8 SECONDS
	stunChance = 40
	comboChance = 0
	cost = 8.00


	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			user._doEnergy(-cost)
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
			send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"rocketpunch",command) && !target.unconscious && !target.stunned && decimal_prob(stunChance)) {
			send("{B*{x {CYou detonate your rocketpunch in [target.raceColor(target.name)]{C's face, causing [target.determineSex(1)] to flinch!{x",user)
			send("{B*{x {C[user.raceColor(user.name)]{C detonates their rocketpunch in your face!{x",target)
			send("{B*{x {C[user.raceColor(user.name)]{C detonates their rocketpunch in [target.raceColor(target.name)]{C's face, causing [target.determineSex(1)] to flinch!{x",a_oview_extra(0,user,target))
			stunned(target,user,comboChance=comboChance);
		}
		game.addCooldown(user.name,command.internal_name, cdTime);
	}
