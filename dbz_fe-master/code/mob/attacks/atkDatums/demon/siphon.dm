atkDatum/siphon
	name="siphon"
	minDmg = 2
	maxDmg = 3
	cost = 2
	cdTime = 15 SECONDS
	staRecovery = 3
	enRecovery = 3
	drainSpeed = 1 SECONDS

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			locked = TRUE;
			user._doEnergy(-getCost(),TRUE)
			game.addCooldown(user.name,c.internal_name,cdTime);
			..()
		}
	}

	go(){
		var/goTime = (world.time + drainSpeed);

		while(target && target.stunned){
			if(world.time >= goTime){
				user.fCombat.doDamage(target,minDmg,maxDmg,"siphon",command)
				user._doEnergy(staRecovery,TRUE)
				target._doEnergy(-1,TRUE);
				user._doDamage(ret_percent(enRecovery,user.currpl));
				goTime=(world.time + drainSpeed);
			}
			sleep(world.tick_lag)
		}
	}