atkDatum/stab

	name = "stab";
	cost = 2
	minDmg = 6
	maxDmg = 10
	bleedChance = 60
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
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"stab",command) && !target.unconscious && decimal_prob(bleedChance)) {
			send("{B*{x {CYou stab [target.raceColor(target.name)]{C straight in [target.determineSex(1)] stomach and [target.determineSex(3)] begins to{x {RBLEED{x {Cprofusely!{x",user)
			send("{B*{x {C[user.raceColor(user.name)]{C stabs you in the stomach and you begin to {x{RBLEED{x {Cprofusely!{x",target)
			send("{B*{x {C[user.raceColor(user.name)]{C stabs [target.raceColor(target.name)]{C in their stomach and they begin to {x{RBLEED{x {Cprofusely!{x",a_oview_extra(0,user,target))
			target.bleedDamage(user);
		}

		game.addCooldown(user.name,command.internal_name,cdTime);
	}