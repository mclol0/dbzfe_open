fEAttk
	kamehameha
		name = "kamehameha"
		text = "{B@{x"
		display = "{B@{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 3 SECONDS;
		mxCh = 5;
		mnCh = 1;
		speed = 5;
		minDmg = KAMEHAMEHA_MIN;
		maxDmg = KAMEHAMEHA_MAX;
		enPerTick = KAMEHAMEHA_EN_PERCH;
		//density = TRUE;
		cdTime = KAMEHAMEHA_COOLDOWN;
		dmgPerTick = KAMEHAMEHA_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("kamehameha grows in size")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell KAMEHAMEHA!", list());
				..()
		}