mob
	proc
		checkTargeted(type=MELEE){
			switch(type){
				if(MELEE){
					if(game.meleeTargets.Find("[name]")){
						return TRUE;
					}
				}

				if(ENERGY){
					if(game.energyTargets.Find("[name]")){
						return TRUE;
					}
				}
			}

			return FALSE
		}

		checkEnergyTarget(){
			if(game.energyTargets.Find("[name]")){
				return TRUE;
			}

			return FALSE
		}

atkDatum

	var
		name = NULL;

		goTime = 0;
		AID = 0;

		tmp/mob/user;
		tmp/mob/target;
		tmp/Command/command;
		tmp/removalString;

		locked = FALSE;
		defense = FALSE;
		utility = FALSE;
		Conc = FALSE;

		maxRange = 0
		minDmg = 0
		maxDmg = 0
		minAttacks = 1
		maxAttacks = 1
		cdTime = 0
		cost = 0
		delayBetween = 0

		//Stun related variables
		stunChance = 0
		stunTime = DEFAULT_STUN_TIME
		comboChance = fightComboChance

		//Drain related variables
		staRecovery = 0
		enRecovery = 0
		drainSpeed = 0

		//Heal related variables
		staMinRestore = 0
		staMaxRestore = 0
		enMinRestore = 0
		enMaxRestore = 0
		maxRestoreStacks = 0
		healDelay = 1 SECOND
		heal = FALSE

		//SpecialEffects
		bleedChance = 0

		//Throw and Collision
		throwChance = 0
		throwMinDistance = 0
		throwMaxDistance = 0
		collisionMinDmg = 0
		collisionMaxDmg = 0

		costUsesDistance = FALSE

	proc/getCost() {
		if (user && target && command) {
			return command._maxDistance > 0 ? cost + a_get_dist(user,target) : cost
		}

		return cost
	}

	proc/getHelp(Command/Technique/cRef) {
		var/list/buffer = list()

		if (cRef.tType == DEFENSE) {
			buffer += "\n{YNote{x: {CThis is a {BDEFENSE{x {Cskill and it must be performed at the right moment to successfully nullify an attack.\n"
			buffer += "Failing to perform the defense at the right timing means you will be unable to act for a short period of time and open for attack.\n"
		}

		var/defenses = "None"
		if (cRef.defenses) {
			if (cRef.defenses.len > 0) {
				defenses = ""
				for(var/v in cRef.defenses) {
					if (defenses && defenses != "") {
						defenses += ", "
					}
					defenses += "[translateDefense(v)]"
				}
			}
		}

		if (cRef.needsSTUN && cRef.tType != FINISHER)
			buffer += "\n{YNote:{x {CThis attack requires the target to be {WSTUNNED{x{C.\n"

		buffer += "\n[capFirstL(name)] Details:\n"

		var/typeStr = "Melee Attack"
		switch(cRef.tType) {
			if(ENERGY) typeStr = "Energy Attack"
			if(FINISHER) typeStr = "Finisher"
			if(DEFENSE) typeStr = "Defense"
			if(UTILITY) typeStr = "Utility"
		}

		buffer += "<al2></a><al17>Technique Type</a>: [typeStr]"

		if (cRef.tType == MELEE)
			buffer += "\n<al2></a><al17>Defenses</a>: [defenses]"

		if (cRef._maxDistance)
			buffer += "\n<al2></a><al17>Range</a>: 0 to [cRef._maxDistance] rooms"

		if (minDmg > 0)
			buffer += "\n<al2></a><al17>Min Damage</a>: [minDmg]%\n"
			buffer += "<al2></a><al17>Max Damage</a>: [maxDmg]%"

		var/costStr = costUsesDistance ? "[cost]% Stamina + 1% Stamina per room to target" : "[cost]% Stamina"

		if (cRef.tType == DEFENSE) {
			if (cost > 0) {
				buffer += "\n\nFailing to defend successfully will make you lose some stamina\n"
				buffer += "<al2></a><al17>Cost</a>: [costStr]"
			}
		} else {
			buffer += "\n<al2></a><al17>Cost</a>: [costStr]"
		}

		if (cRef.tType == MELEE || cRef.tType == ENERGY)
			var/cooldownStr = cdTime > 0 ? cdTime/10 : 0
			buffer += "\n<al2></a><al17>Cooldown</a>: [cooldownStr]s"

		if (cRef.comboAble) {
			buffer += "\n\nThis attack might be used in combos\n"
			var/comboStr = cRef.comboName
			if (cRef.comboOptions) {
				comboStr = ""
				for(var/o in cRef.comboOptions) {
					if (comboStr != "") {
						comboStr += ", "
					}
					comboStr += "[o][cRef.comboName]"
				}
			}
			buffer += "<al2></a><al17>Combo Text</a>: [comboStr]"
		}

		if (stunChance > 0) {
			buffer += "\n\nThis attack can {WSTUN{x {Cyour enemy.\n"
			buffer += "<al2></a><al17>Stun Chance</a>: [stunChance]%.\n"
			buffer += "<al2></a><al17>Combo Chance</a>: [comboChance]%."
		}

		if (maxAttacks > 1) {
			buffer += "\n\nThis attack can hit {YMultiple{x {Ctimes\n"
			buffer += "<al2></a><al17>Max Attacks</a>: [maxAttacks]"
		}

		if (enRecovery > 0 || staRecovery > 0) {
			buffer += "\n\nThis attack will {yRestore{x {Cyour energy\n"
			buffer += "<al2></a><al17>Powerlevel</a>: [enRecovery]%\n"
			buffer += "<al2></a><al17>Stamina</a>: [staRecovery]%"
		}

		if (bleedChance > 0) {
			buffer += "\n\nThis attack can cause {RBLEEDING{x {Con your target\n"
			buffer += "<al2></a><al17>Bleed Chance</a>: [bleedChance]%"
		}

		if (throwMaxDistance > 0) {
			var/collisionDmgStr = collisionMinDmg > 0 ? " and cause {BCOLLISION{x {Cdamage" : ""
			buffer += "\n\nThis attack can throw your enemy out of the room[collisionDmgStr]\n"
			if (throwChance > 0)
				buffer += "<al2></a><al17>Throw Chance</a>: [throwChance]%\n"

			buffer += "<al2></a><al17>Max Distance</a>: [throwMaxDistance] rooms"

			if (collisionMinDmg > 0) {
				buffer += "\n<al2></a><al17>Min Damage</a>: [collisionMinDmg]%\n"
				buffer += "<al2></a><al17>Max Damage</a>: [collisionMaxDmg]%"
			}
		}

		if (cRef.canFinish)
			buffer += "\n\nThis attack can be used to {RFINISH{x {Can opponent."

		return implodetext(buffer, "")
	}

	clean(){
		if(user && src == user.atkDat){ user.atkDat=NULL; }
		if(game.meleeTargets.Find(removalString)){ game.removeTargeting(removalString, AID, MELEE); }
		user=NULL;
		target=NULL;
		command=NULL;
	}

	proc/go()

	proc/loop(){
		set waitfor = FALSE;

		while(src && user && target && !user.unconscious && !user.stunned && !user.resting && !user.sleeping){
			if(!(command.tType in list(DEFENSE,UTILITY)) && target && (!(target in user.fCombat.hostileTargets) && !user.isSafe() && !target.isSafe())){ break; }

			if(world.time >= goTime){
				if((command.tType in list(DEFENSE,UTILITY))){
					if(src && user && AID == user.aID || src && user && command.tType == DEFENSE){ go(); }
				}else{
					if(target && ((target in user.fCombat.hostileTargets) || user.isSafe() && target.isSafe())){
						if(src && user && target && AID == user.aID || src && user && target && command.tType == DEFENSE){ go(); }
					}
				}

				break;
			}

			sleep(world.tick_lag)
		}

		clean()
	}

	New(){
		..()

		if(target && !utility){
			game.addTargeting(target.name, AID, MELEE);
			removalString = target.name;
		}

		if(user.isConcBreak() && command.tType == MELEE){user.kiAttk:Conc=FALSE;user.kiAttk:isCharging=FALSE}
		loop()
	}
