fEAttk
	erasercannon
		name = "erasercannon"
		text = "{Go{x"
		display = "{Go{x"
		pColor = "{G"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		speed = 7;
		minDmg = ERASERCANNON_MIN;
		maxDmg = ERASERCANNON_MAX;
		enPerTick = ERASERCANNON_EN_PERCH;
		cdTime = ERASERCANNON_COOLDOWN;
		delayBetween = 20
		chCount = 1;
		mnCh = 1;
		dmgPerTick = ERASERCANNON_DAMAGE_PERCH;

		proc/fire_blast(){
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
			fire_blast();
		}