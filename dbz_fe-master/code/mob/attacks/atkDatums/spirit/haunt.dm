atkDatum/haunt

	name = "haunt"
	minDmg = 1
	maxDmg = 3
	cdTime = 30 SECONDS
	cost = 0
	staRecovery = 1
	enRecovery = 5
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
			user._doEnergy(-cost)
			game.addCooldown(user.name,c.internal_name,cdTime);
			..()
		}
	}

	go(){
		var/goTime = (world.time + drainSpeed);

		while(target && target.stunned){
			if(world.time >= goTime){
				user.fCombat.doDamage(target,minDmg,maxDmg,"haunting",command)
				user._doEnergy(staRecovery,TRUE)
				target._doEnergy(-1,TRUE);
				user._doDamage(ret_percent(enRecovery,user.currpl));
				goTime=(world.time + drainSpeed);
			}
			sleep(world.tick_lag)
		}
	}
