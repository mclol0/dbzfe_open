fEAttk
	soulspear
		name = "soulspear"
		text = "{r^{x"
		display = "{r^{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 5;
		minDmg = SOULSPEAR_MIN;
		maxDmg = SOULSPEAR_MAX;
		enPerTick = SOULSPEAR_EN_PERCH;
		cdTime = SOULSPEAR_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 5
		maxBarrageLoad = 5
		dmgPerTick = SOULSPEAR_DAMAGE_PERCH;

		proc
			fire_es(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 20);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/soulspear_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 15);
					}
					sleep(world.tick_lag)
				}


				send("Your essence spears dissipate!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			currentBarrageLoad = load
			Conc=TRUE
			fire_es()
		}

		Del(){
			..()
		}

	soulspear_projectile
		name = "soulspear"
		text = "{r^{x"
		display = "{r^{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 5;
		minDmg = SOULSPEAR_MIN;
		maxDmg = SOULSPEAR_MAX;
		enPerTick = SOULSPEAR_EN_PERCH;
		cdTime = SOULSPEAR_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 5
		maxBarrageLoad = 5
		dmgPerTick = SOULSPEAR_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doEnergy(-2,TRUE)
			user._doDamage(ret_percent(-1.50,user.currpl))
			go(targetRef,cRef)
		}

