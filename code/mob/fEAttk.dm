fEAttk
	parent_type = /obj

	name = NULL;
	text = NULL;

	Cross(fEAttk/a){
		if(istype(a,/fEAttk) && a.mobRef != mobRef){
			send("Your [name] clashes with [a.mobRef:raceColor(a.mobRef:name)]'s [a.name]!",mobRef)
			send("Your [a.name] clashes with [mobRef:raceColor(mobRef:name)]'s [name]!",a.mobRef)
			if(powerRating > a.powerRating){
				send("Your [name] wins the power struggle!",mobRef)
				send("Your [a.name] lost the power struggle!",a.mobRef)
				minDmg += a.minDmg
				maxDmg += a.maxDmg
				powerRating += a.powerRating
				. = TRUE;
				a.loc = NULL;
				a.clean();
			}else{
				send("Your [a.name] wins the power struggle!",a.mobRef)
				send("Your [name] lost the power struggle!",mobRef)
				a.minDmg += minDmg
				a.maxDmg += maxDmg
				a.powerRating += powerRating
				. = FALSE;
				loc=NULL;
				clean();
			}
		}
		else{
			. = TRUE
		}
	}

	Move(new_loc, new_dir, step_x=0, step_y=0){
		var nx = x
		var ny = y

		if(new_dir & EAST){
			nx ++
		}
		else if(new_dir & WEST){
			nx --
		}
		if(new_dir & NORTH){
			ny ++
		}
		else if(new_dir & SOUTH){
			ny --
		}

		if(loc && isplanet(loc.loc)){
			if(nx > loc.loc:getMaxX()){
				nx = (loc.loc:x + x - loc.loc:getMaxX())
			}
			else if(nx < loc.loc:x){
				nx = (loc.loc:x - x + loc.loc:getMaxX())
			}
			if(ny > loc.loc:getMaxY()){
				ny = (loc.loc:y + y - loc.loc:getMaxY())
			}
			else if(ny < loc.loc:y){
				ny = (loc.loc:y - y + loc.loc:getMaxY())
			}
		}else{
			if(nx > world.maxx){
				nx -= world.maxx
			}
			else if(nx < 1){
				nx += world.maxx
			}
			if(ny > world.maxy){
				ny -= world.maxy
			}
			else if(ny < 1){
				ny += world.maxy
			}
		}

		..(locate(nx, ny, z), new_dir)
	}

	var
		tmp/mob/mobRef = NULL;
		tmp/targetRef = NULL;
		tmp/cRef = NULL;
		tmp/MULTI_PROJECTILE=FALSE;
		tmp/removalString;

		aID = NULL;

		powerRating = 0;

		//Type..
		pColor = NULL; // projectile trail color.
		isProjectile = FALSE; // Is a single projectile.
		isMultiProjectile = FALSE; // Is a multiple projectile.
		isCharge = FALSE; // Is a chargeable attack.
		isCharging = FALSE; // Is the attack charging or not.
		maxRange = 0; // Max amount of rooms it can travel.
		chCount = 0; // Charge count used for charge loop.
		chTime = 0; // Time in ticks per charge.
		mxCh = 0; //Max amount of charge ticks.
		mnCh = 0; //Minimum charge stacks required to fire attack.
		speed = 0; // Time to move from room to room in ticks. ( lower is faster )
		minDmg = 0; // Minimum % of damage
		maxDmg = 0; // Maximum % of damage.
		enPerTick = 0; // Energy drained per charge tick
		dmgPerTick = 0; // How much extra damage per charge.
		cdTime = 0; // Cooldown time before you can use the skill again.
		fired = FALSE; // Is the attack already fired?

		//Stun related variables
		stunChance = 0
		stunTime = DEFAULT_STUN_TIME
		comboChance = fightComboChance

		chargeMessages[] = list(); // A list of messages it will print to the room per charge tick.

		Conc = FALSE; // Our we concentrated to hold our attack if not dissipate.

		/* Mutli Projectile Variables */
		delayBetween = 1
		barrageLoad = 1
		currentBarrageLoad = 1
		maxBarrageLoad = 1
		/*								*/

		// Mine related variables
		mineLifeTime = 0
		mineDeathTime = 0

		// Consecrated Ground variables
		healLifeTime = 0;
		healDeathTime = 0;

		// Blind related variables
		blindTime = 0


	clean(){
		..()
		if(mobRef && !MULTI_PROJECTILE && mobRef:kiAttk != NULL && src == mobRef:kiAttk){ mobRef:kiAttk=NULL; }
		if(game.energyTargets.Find(removalString)){ game.removeTargeting(removalString, name, ENERGY); }
		mobRef=NULL;
		targetRef=NULL;
		cRef=NULL;
	}

	proc
		getHelp(Command/Technique/cRef) {
			var/list/buffer = list()

			var/defenses
			if (cRef.defenses) {
				for(var/v in cRef.defenses) {
					if (defenses && defenses != "") {
						defenses += ", "
					}
					defenses += "[translateDefense(v)]"
				}
			} else {
				defenses = "None"
			}

			var/techType = "Energy Attack"
			switch(cRef.tType) {
				if (UTILITY) techType = "Utility"
			}

			buffer += "\n[pColor][capFirstL(name)]{x {CDetails:\n"
			buffer += "<al2></a><al17>Technique Type</a>: [techType]\n"

			if (cRef.tType != UTILITY) {
				buffer += "<al2></a><al17>Defenses</a>: [defenses]\n"
				buffer += "<al2></a><al17>Range</a>: [cRef._minDistance] to [cRef._maxDistance] rooms\n"
				buffer += "<al2></a><al17>Min Damage</a>: [minDmg]%\n"
				buffer += "<al2></a><al17>Max Damage</a>: [maxDmg]%\n"
			}
			buffer += "<al2></a><al17>Cooldown</a>: [cdTime/10]s"

			if (maxBarrageLoad > 1) {
				var/barrMsg = cRef:canChangeBarrage ? "can" : "will"
				buffer += "\n\nThis attack [barrMsg] fire {YMultiple{x {Cprojectiles\n"
				buffer += "<al2></a><al17>Max Projectiles</a>: [maxBarrageLoad]\n"
				buffer += "<al2></a><al17>Delay</a>: [delayBetween/10]s"
			}

			if (isCharge && mxCh > 1) {
				var/chargeReq = mnCh > 1 ? "{WMUST{x{C" : "can"
				buffer += "\n\nThis attack [chargeReq] be {RCharged{x{C\n"
				buffer += "<al2></a><al17>Min Charges</a>: [mnCh]\n"
				buffer += "<al2></a><al17>Max Charges</a>: [mxCh]\n"
				buffer += "<al2></a><al17>Cost</a>: [enPerTick]% stamina per charge\n"
				buffer += "<al2></a><al17>Charge Time</a>: [chTime/10]s per charge\n"
				buffer += "<al2></a><al17>Extra Damage</a>: [dmgPerTick]% per charge"
			}

			if (mineLifeTime > 0) {
				buffer += "\n\nThis is a {rPASSIVE{x {Cattack.\n"
				buffer += "<al2></a><al17>Max Life Time</a>: [mineLifeTime/10]s"
			}

			if (stunChance > 0) {
				buffer += "\n\nThis attack can {WSTUN{x {Cyour enemy.\n"
				buffer += "<al2></a><al17>Stun Chance</a>: [stunChance]%.\n"
				buffer += "<al2></a><al17>Stun Time</a>: [stunTime/10]s.\n"
				buffer += "<al2></a><al17>Combo Chance</a>: [comboChance]%."
			}

			if (blindTime > 0) {
				buffer += "\n\nThis attack can cause {mBLINDNESS{x {Con your target. Blind opponents miss their attacks.\n"
				buffer += "<al2></a><al17>Blind Time</a>: [blindTime/10]s"
			}

			return implodetext(buffer, "")
		}

		rps(){
			switch(speed){
				if(1) { return 10.00; }
				if(2) { return 5.00; }
				if(3) { return 3.10; }
				if(4) { return 2.20; }
				if(5) { return 1.50; }
				if(6) { return 1.40; }
				if(7) { return 1.30; }
				if(8) { return 1.20; }
				if(9) { return 1.10; }
				if(10){ return 1.00; }
				if(11) { return 0.90; }
				if(12) { return 0.80; }
				if(13) { return 0.70; }
				if(14) { return 0.60; }
				if(15) { return 0.50; }
			}

			return 0;
		}

		special(mob/m)

		hit(mob/m){
			if(aID == mobRef:aID && !isProjectile && !MULTI_PROJECTILE){
				if(mobRef:fCombat.doDamage(m,minDmg,maxDmg,name,cRef,kiAttack=src)){
					special(m);
				}
			}else if(MULTI_PROJECTILE || isProjectile){
				if(mobRef:fCombat.doDamage(m,minDmg,maxDmg,name,cRef,kiAttack=src)){
					special(m);
				}
			}

			clean()
		}

		projectile(mob/target,Command/Technique/c){
			set waitfor = FALSE;
			set background = TRUE;

			fired = TRUE;
			loc = mobRef:loc
			powerRating = mobRef:currpl

			var
				travelTime = (a_get_dist(src,target) / rps());
				travelDist = 0;
				initialLoc = target.loc

			send("{B* You fire a [uppertext(copytext(name,1,2)) + copytext(name, 2)] at {x[target.raceColor(target.name)]{B, [num2text(travelTime,2)]s until it lands!{x",mobRef)
			send("{R*{x [mobRef:raceColor(mobRef:name)] {Rfires a [uppertext(copytext(name,1,2)) + copytext(name, 2)] at you, [num2text(travelTime,2)]s to defend! [target.defenseTips(c)]{x",target)
			send("{W*{x [mobRef:raceColor(mobRef:name)] fires a [uppertext(copytext(name,1,2)) + copytext(name, 2)] at [target.raceColor(target.name)]!",_ohearers(0,mobRef))

			var/lastDir=a_get_dir(src,target)

			while(src && mobRef){
				if(pColor){
					var/obj/trail/A = new(loc)
					A.setDisplay("[pColor]~{x")
				}
				if(!target || !ismob(target)){Move(get_step(src,lastDir),lastDir)}else{Move(get_step(src,a_get_dir(src,target)),a_get_dir(src,target));lastDir=a_get_dir(src,target)}

				if(target && target.loc != initialLoc){
					travelTime = (a_get_dist(src,target) / rps());
					send("{B*{x [mobRef:raceColor(mobRef:name)]{B's [uppertext(copytext(name,1,2)) + copytext(name, 2)] is approaching, {x[target.raceColor(target.name)] {B[num2text(travelTime,2)]s!{x",mobRef)
					send("{R*{x [mobRef:raceColor(mobRef:name)]{R's [uppertext(copytext(name,1,2)) + copytext(name, 2)] is approaching, [num2text(travelTime,2)]s to defend! [target.defenseTips(c)]{x",target)
					initialLoc = target.loc
				}

				travelDist++

				if(target && loc == target.loc){ hit(target) }

				if(travelDist>maxRange){break}

				sleep(speed)
			}

			if(src){ clean(); }
		}

		isReady(){
			if(chCount >= mnCh){
				return TRUE;
			}
			return FALSE;
		}

		go(mob/target,Command/Technique/c){
			if(isCharge){
				if(isReady()){
					if(cdTime > 0 && !game.checkCooldown(mobRef:name,c.internal_name)) game.addCooldown(mobRef:name,c.internal_name,cdTime);
					cRef = c
					targetRef = target
					mobRef:kiAttk = NULL
					isCharging = FALSE;
					if(targetRef){
						game.addTargeting(target.name, name, ENERGY);
						removalString = target.name;
					}
					if(isProjectile){
						projectile(target,c)
						. = TRUE;
					}
					mOuter(c.CAST_MSG,mobRef,ov_out(1,12,mobRef)); // message displayed if any from ability when casted. (Message that is viewed by nearby players)
				}else{
					send("[uppertext(copytext(name,1,2)) + copytext(name, 2)] is not ready!",mobRef)
					return FALSE;
				}
			}else if(isMultiProjectile){
				if(cdTime > 0 && !game.checkCooldown(mobRef:name,c.internal_name)) game.addCooldown(mobRef:name,c.internal_name,cdTime);
				cRef = c
				targetRef = target
				if(targetRef){
					game.addTargeting(target.name, name, ENERGY);
					removalString = target.name;
				}
				projectile(target,c)
				. = TRUE
			}
		}

		deCharge(){
			set waitfor = FALSE;

			var/goTime = (world.time + 60);

			while(src && !targetRef){
				if(world.time >= goTime;){
					chCount--
					minDmg -= dmgPerTick
					maxDmg -= dmgPerTick
					send("You feel your [uppertext(copytext(name,1,2)) + copytext(name, 2)] dissipating!",mobRef)
					goTime = (world.time + 30);
					if(chCount<mnCh){
						send("Your [uppertext(copytext(name,1,2)) + copytext(name, 2)] has fully dissipated!",mobRef)
						isCharging=FALSE
						sleep(1)
						clean()
					}
				}
				sleep(world.tick_lag)
			}
		}

		chargeAttk(){
			set waitfor = FALSE;
			isCharging=TRUE;

			var/goTime = (world.time + chTime)

			while(src && mobRef && isCharging){
				if(world.time >= goTime){
					chCount++;
					minDmg += dmgPerTick;
					maxDmg += dmgPerTick;
					send("[mobRef:raceColor(mobRef:name)]'s [pick(chargeMessages)]!",_ohearers(0,mobRef));
					send("{C*{x {BYour [pick(chargeMessages)]!{x",mobRef);
					mobRef:_doEnergy(-enPerTick,TRUE)
					goTime = (world.time + chTime);
					if(chCount>=mxCh){
						deCharge()
						isCharging=FALSE
						send("{C*{x {BYour [uppertext(copytext(name,1,2)) + copytext(name, 2)] has finished charging!{x",mobRef)
						break
					}
				}
				sleep(world.tick_lag)
			}

			send("You stop charging your [uppertext(copytext(name,1,2)) + copytext(name, 2)]!",mobRef)
		}


	New(mob/m){
		..()
		if (m) {
			mobRef = m
			mobRef.aID = ++mobRef.aID
			mOuter("a sudden increase of power",mobRef,ov_out(1,12,mobRef));
		}
	}

	Del(){
		..()
	}
