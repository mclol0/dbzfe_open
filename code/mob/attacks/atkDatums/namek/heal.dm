proc/locNamekHeal(mob/m){
	var/mob/mb = NULL;

	for(var/atkDatum/namek_heal/x){
		if(m == x.target){
			mb = x;
		}
	}

	if(mb){
		return mb;
	}else{
		return NULL;
	}
}

atkDatum/namek_heal

	name = "heal";
	utility = TRUE;

	var/tickCount = 0; // Our current tick count.
	
	maxRestoreStacks = 5; // Our maximum tick count.
	enMinRestore = 4
	enMaxRestore = 5
	staMinRestore = 4
	healDelay = 1 SECOND
	heal = TRUE
	cost = 10
	cdTime = 120 SECONDS

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

		while(!target.unconscious && tickCount < maxRestoreStacks){
			var/healAmount = ret_percent(rand_decimal(enMinRestore,enMaxRestore),target.getMaxPL());
			var/stamAmount = staMinRestore;
			target._doEnergy(stamAmount);
			target._doDamage(healAmount);
			send("{C+[commafy(healAmount)]{x PL {G+[commafy(stamAmount)]{x EN",target,TRUE);
			tickCount++;
			sleep(healDelay);
		}
	}