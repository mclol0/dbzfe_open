atkDatum/kaio_heal

	name = "heal";
	utility = TRUE;
	cost = 10
	enMinRestore = 11
	enMaxRestore = 14
	staMinRestore = 17
	staMaxRestore = 21
	maxRestoreStacks = 1
	cdTime = 120 SECONDS
	heal = TRUE

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			user._doEnergy(-getCost());
			game.addCooldown(user.name, command.internal_name, cdTime);
			..()
		}
	}

	go(){
		if(target.unconscious){
			target.regainConscious(TRUE);
		}

		var/healAmount = ret_percent(rand_decimal(enMinRestore,enMaxRestore),target.getMaxPL());
		var/stamAmount = rand(staMinRestore,staMaxRestore);
		target._doEnergy(stamAmount);
		target._doDamage(healAmount);
		send("{C+[commafy(healAmount)]{x PL {G+[commafy(stamAmount)]{x EN",target,TRUE);
	}