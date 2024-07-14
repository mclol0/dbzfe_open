fEAttk
	kizan
		name = "kizan"
		text = "{bo{x"
		display = "{bo{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		speed = 7;
		minDmg = KIZAN_MIN;
		maxDmg = KIZAN_MAX;
		enPerTick = KIZAN_EN_PERCH;
		cdTime = KIZAN_COOLDOWN;
		delayBetween = 20
		chCount = 1;
		mnCh = 1;
		dmgPerTick = KIZAN_DAMAGE_PERCH;

		proc/fire_kizan(){
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
			fire_kizan();
		}