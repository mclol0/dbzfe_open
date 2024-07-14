proc/locGenieHeal(mob/m){
	var/mob/mb = NULL;

	for(var/atkDatum/genie_heal/x){
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

atkDatum/genie_heal

	name = "mend";
	utility = TRUE;
	cdTime = 120 SECONDS
	cost = 8
	staMinRestore = 8
	maxRestoreStacks = 5
	heal = TRUE

	var/tickCount = 0; // Our current tick count.

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			game.addCooldown(user.name,command.internal_name,cdTime);
			..()
		}
	}

	go(){
		if(target.unconscious){
			target.regainConscious(TRUE);
		}

		while(!target.unconscious && tickCount < maxRestoreStacks){
			user._doEnergy(-getCost());
			target._doEnergy(staMinRestore);
			send("{G+[commafy(staMinRestore)]{x EN",target,TRUE);
			tickCount++;
			sleep(healDelay);
		}
	}