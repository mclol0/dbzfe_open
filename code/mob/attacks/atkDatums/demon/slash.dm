atkDatum/slash

	name = "slash";
	minDmg = 6
	maxDmg = 10
	bleedChance = 60
	cost = 2
	cdTime = 10 SECONDS

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
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"slash",command) && !target.unconscious && prob(bleedChance)) {
			send("{B*{x {CYou slash [target.raceColor(target.name)]{C and [target.determineSex(3)] begins to{x {RBLEED{x {Cprofusely!{x",user)
			send("{B*{x {C[user.raceColor(user.name)]{C slashes you and you begin to {x{RBLEED{x {Cprofusely!{x",target)
			send("{B*{x {C[user.raceColor(user.name)]{C slashes [target.raceColor(target.name)]{C and they begin to {x{RBLEED{x {cprofusely!{x",a_oview_extra(0,user,target))
			target.bleedDamage(user);
		}

		game.addCooldown(user.name,command.internal_name, cdTime);
	}