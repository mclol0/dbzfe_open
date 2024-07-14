atkDatum/wolf_fang_fist

	name = "wolf fang fist";
	minDmg = 2
	maxDmg = 3
	cost = 2
	costUsesDistance = FALSE
	stunChance = 70
	comboChance = 100


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
			alaparser.parse(user, "yell WOLF FANG FIST!", list());
			send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
			send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"wolf fang fist",command) && !target.unconscious && !target.stunned && prob(stunChance)) {
			stunned(target,user,comboChance=comboChance);
		}
	}