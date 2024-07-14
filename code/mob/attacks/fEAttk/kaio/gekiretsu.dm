fEAttk
	gekiretsu
		name = "gekiretsu"
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
		minDmg = GEKIRETSU_MIN;
		maxDmg = GEKIRETSU_MAX;
		enPerTick = GEKIRETSU_EN_PERCH;
		//density = TRUE;
		cdTime = GEKIRETSU_COOLDOWN;
		dmgPerTick = GEKIRETSU_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("gekiretsu grows in size")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell I won't hold back!", list());
				..()
		}