fEAttk
	power_blitz
		name = "power blitz"
		text = "{oo{x"
		display = "{oo{x"
		pColor = "{Y"
		isMultiProjectile = TRUE;
		isCharge = FALSE;
		maxRange = 20;
		speed = 4;
		minDmg = POWERBLITZ_MIN;
		maxDmg = POWERBLITZ_MAX;
		enPerTick = POWERBLITZ_EN_PERCH;
		delayBetween = 5
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		cdTime = POWERBLITZ_COOLDOWN;
		dmgPerTick = POWERBLITZ_DAMAGE_PERCH;

		proc
			fire_pb(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 30);

				while(src && mobRef && targetRef && Conc){
					if (!mobRef.fCombat._hostiles())
						break

					if(world.time>=delayBetween){
						i++
						new /fEAttk/power_blitz_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){
							mobRef.loc=targetRef:loc;
							mobRef.density=targetRef:density;
							send("{B*{x {BYou appear before {x[targetRef:raceColor(targetRef:name)]{B!{x",mobRef);
							send("{W*{x [mobRef.raceColor(mobRef.name)] appears before you out of thin air!",_ohearers(0,mobRef))
							break;
						}
						delayBetween = (world.time + 3);
					}
					sleep(world.tick_lag)
				}

				send("You halt your blitz!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			currentBarrageLoad = load
			Conc=TRUE
			fire_pb()
		}

		Del(){
			..()
		}


	power_blitz_projectile
		name = "power blitz"
		text = "{oo{x"
		display = "{oo{x"
		pColor = "{Y"
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 2;
		minDmg = POWERBLITZ_MIN;
		maxDmg = POWERBLITZ_MAX;
		enPerTick = POWERBLITZ_EN_PERCH;
		cdTime = POWERBLITZ_COOLDOWN;
		delayBetween = 5
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		dmgPerTick = POWERBLITZ_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doEnergy(-1,TRUE)
			go(targetRef,cRef)
		}