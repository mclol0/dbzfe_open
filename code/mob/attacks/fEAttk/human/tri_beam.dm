fEAttk
	tri_beam
		name = "tri-beam"
		text = "{Y^{x"
		display = "{Y^{x"
		pColor = "{R"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 25;
		chTime = 3 SECONDS;
		mxCh = 6;
		mnCh = 1;
		speed = 5;
		minDmg = TRIBEAM_MIN;
		maxDmg = TRIBEAM_MAX;
		enPerTick = TRIBEAM_EN_PERCH;
		dmgPerTick = TRIBEAM_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = TRIBEAM_COOLDOWN;

		New(){
			..()
			chargeMessages = list("tri-beam glows", "tri-beam has bolts of energy arcing around it")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell TRI BEAM!", list());
				..()
		}