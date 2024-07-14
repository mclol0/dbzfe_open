fEAttk
	vanishing_beam
		name = "vanishing beam"
		text = "{Mo{x"
		display = "{Mo{x"
		pColor = "{m"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		speed = 6;
		minDmg = VANISHBEAM_MIN;
		maxDmg = VANISHBEAM_MAX;
		enPerTick = VANISHBEAM_EN_PERCH;
		cdTime = VANISHBEAM_COOLDOWN;
		delayBetween = 20
		chCount = 1;
		mnCh = 1;
		dmgPerTick = VANISHBEAM_DAMAGE_PERCH;

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