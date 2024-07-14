fEAttk
	finish_buster
		name = "finish buster"
		text = "{BO{x"
		display = "{BO{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 20;
		mxCh = 5;
		mnCh = 1;
		speed = 4;
		minDmg = FINISH_BUSTER_MIN;
		maxDmg = FINISH_BUSTER_MAX;
		enPerTick = FINISH_BUSTER_EN_PERCH;
		//density = TRUE;
		cdTime = FINISH_BUSTER_COOLDOWN;
		dmgPerTick = FINISH_BUSTER_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("finish buster grows in size","finish buster grows in intensity")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell FINISH BUSTER!!", list());
				..()
		}