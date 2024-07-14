fEAttk
	specialbeamcannon
		name = "special beam cannon"
		text = "{r-{x"
		display = "{r-{x"
		pColor = "{m"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 35;
		mxCh = 6;
		mnCh = 1;
		speed = 3;
		minDmg = SPECIALBEAMCANNON_MIN;
		maxDmg = SPECIALBEAMCANNON_MAX;
		enPerTick = SPECIALBEAMCANNON_EN_PERCH;
		//density = TRUE;
		cdTime = SPECIALBEAMCANNON_COOLDOWN;
		dmgPerTick = SPECIALBEAMCANNON_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("special beam cannon intensifies","special beam cannon pulsates with power")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell SPECIAL BEAM CANNON!", list());
				..()
		}