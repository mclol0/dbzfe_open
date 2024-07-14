fEAttk
	super_kamehameha
		name = "super kamehameha"
		text = "{B@{x"
		display = "{B@{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 40;
		chTime = 4 SECONDS;
		mxCh = 6;
		mnCh = 1;
		speed = 5;
		minDmg = SUPER_KAMEHAMEHA_MIN;
		maxDmg = SUPER_KAMEHAMEHA_MAX;
		enPerTick = SUPER_KAMEHAMEHA_EN_PERCH;
		dmgPerTick = SUPER_KAMEHAMEHA_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = SUPER_KAMEHAMEHA_COOLDOWN;

		New(){
			..()
			chargeMessages = list("super kamehameha grows in size", "super kamehameha has bolts of energy arcing around it")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell HAAAAAAAAAAAAA!!!", list());
				..()
		}