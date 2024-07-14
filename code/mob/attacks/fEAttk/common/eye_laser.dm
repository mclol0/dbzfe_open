fEAttk
	eye_laser
		name = "eye laser"
		text = "{R-{x"
		display = "{R-{x"
		pColor = NULL
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		speed = 4;
		minDmg = EYE_LASER_MIN;
		maxDmg = EYE_LASER_MAX;
		enPerTick = EYE_LASER_EN_PERCH;
		cdTime = EYE_LASER_COOLDOWN;
		delayBetween = 20
		chCount = 1;
		mnCh = 1;
		dmgPerTick = EYE_LASER_DAMAGE_PERCH;

		proc/fire_laser(){
			set waitfor=FALSE;

			if(a_get_dist(mobRef,targetRef) < 4){
				isCharging=TRUE;
				delayBetween = (world.time + 30);
			}else{
				delayBetween = 0;
			}

			while(src && mobRef && targetRef && Conc){
				if(world.time >= delayBetween){
					isProjectile = TRUE;
					go(targetRef,cRef);
					Conc=FALSE;
				}
				sleep(world.tick_lag)
			}
		}

		New(mob/user, mob/target, Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE;
			fire_laser();
		}