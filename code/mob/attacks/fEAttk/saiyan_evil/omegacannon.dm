fEAttk
	omegacannon
		name = "omegacannon"
		text = "{G0{x"
		display = "{G0{x"
		pColor = "{G"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 40;
		chTime = 3 SECONDS;
		mxCh = 6;
		mnCh = 1;
		speed = 5;
		minDmg = OMEGACANNON_MIN;
		maxDmg = OMEGACANNON_MAX;
		enPerTick = OMEGACANNON_EN_PERCH;
		dmgPerTick = OMEGACANNON_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = OMEGACANNON_COOLDOWN;

		New(){
			..()
			chargeMessages = list("[name] gathers energy", "[name] sparks and grows")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell OMEGA CANNON!", list());
				..()
		}