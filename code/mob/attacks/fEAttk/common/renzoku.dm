fEAttk
	renzoku
		name = "renzoku"
		text = "{Yo{x"
		display = "{Yo{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 4;
		minDmg = RENZOKU_MIN;
		maxDmg = RENZOKU_MAX;
		enPerTick = RENZOKU_EN_PERCH;
		cdTime = RENZOKU_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 5
		maxBarrageLoad = 5
		dmgPerTick = RENZOKU_DAMAGE_PERCH;

		proc
			fire_renz(){
				set waitfor=FALSE

				Conc = TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 15);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/renzoku_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 12);
					}
					sleep(world.tick_lag)
				}


				send("You renzoku barrage dissipates!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			fire_renz()
		}

		Del(){
			..()
		}

	renzoku_projectile
		name = "renzoku"
		text = "{Yo{x"
		display = "{Yo{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 4;
		minDmg = RENZOKU_MIN;
		maxDmg = RENZOKU_MAX;
		enPerTick = RENZOKU_EN_PERCH;
		cdTime = RENZOKU_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		dmgPerTick = RENZOKU_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doEnergy(-5,TRUE)
			go(targetRef,cRef)
		}