fEAttk
	spiritwave
		name = "spiritwave"
		text = "{B@{x"
		display = "{B@{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 50;
		chTime = 1.3 SECONDS;
		mxCh = 10;
		mnCh = 1;
		speed = 7;
		minDmg = SPIRITWAVE_MIN;
		maxDmg = SPIRITWAVE_MAX;
		enPerTick = SPIRITWAVE_EN_PERCH;
		//density = TRUE;
		cdTime = SPIRITWAVE_COOLDOWN;
		dmgPerTick = SPIRITWAVE_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("spirit wave pulses with devestating power", "spirit wave ripples with increasing power")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell Spirit Wave!", list());
				..()
		}
