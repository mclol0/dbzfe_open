fEAttk
	death_beam
		name = "deathbeam"
		text = "{R.{x"
		display = "{r-{x"
		pColor = "{R"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 8;
		chTime = 3 SECONDS;
		mxCh = 3;
		mnCh = 1;
		speed = 3;
		minDmg = DEATHBEAM_MIN;
		maxDmg = DEATHBEAM_MAX;
		enPerTick = DEATHBEAM_EN_PERCH;
		dmgPerTick = DEATHBEAM_DAMAGE_PERCH;
		cdTime = DEATHBEAM_COOLDOWN;

		New(){
			..()
			chargeMessages = list("[name] pulsates")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell DIE FOOL!", list());
				..()
		}

		proc/delayedDBeam(Command/Technique/TC,mob/target){
			set waitfor=FALSE;

			var/delayBetween = NULL;

			if(a_get_dist(mobRef,target) < 4){
				delayBetween = (world.time + 30);
			}else{
				delayBetween = 0;
			}

			while(src && mobRef && target){
				if(world.time >= delayBetween){
					go(target,TC)
					if(mobRef && target && mobRef:loc == target.loc && chCount >= mnCh){hit(target)}
					break;
				}
				sleep(world.tick_lag);
			}
		}