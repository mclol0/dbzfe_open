fEAttk
	big_bang
		name = "big bang"
		text = "{BO{x"
		display = "{BO{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 40;
		chTime = 4 SECONDS;
		mxCh = 4;
		mnCh = 1;
		speed = 6;
		minDmg = BIGBANG_MIN;
		maxDmg = BIGBANG_MAX;
		enPerTick = BIGBANG_EN_PERCH;
		dmgPerTick = BIGBANG_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = BIGBANG_COOLDOWN;

		New(){
			..()
			chargeMessages = list("big bang grows in size", "big bang has bolts of energy arcing around it")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell BIG BANG ATTACK!", list());
				..()
		}