proc
	determineGender(sex){
		switch(sex){
			if(MALE){ return "{cMale{x"; }
			if(FEMALE){ return "{MFemale{x"; }
			if(UNKNOWN){ return "{RUnknown{x"; }
		}

		return "GENDER ERROR.";
	}

	determineDifficulty(difficultyLevel){
		switch(difficultyLevel){
			if(VERY_EASY) return "{CVERY EASY{x"
			if(EASY) return "{BEASY{x";
			if(MEDIUM) return "{YMEDIUM{x"
			if(HARD) return "{RHARD{x";
			if(VERY_HARD) return "{rVERY{x {RHARD{x"
			if(INSANE) return "{RIN{x{rSANE{x";
			if(FUSION) return "{DF{x{YU{x{DS{x{YI{x{DO{x{YN{x"
			if(GOD) return "{DG{x{YO{x{DD{x"
			if(HEROIC) return "{DH{x{WE{x{CRO{c{WI{x{DC{x"
			if(EVENT_MOB) return "{GEVENT MOB!{x"
		}

		return "DIFFICULTY ERROR.";
	}

	determineAlignment(alignment){
		switch(alignment){
			if(GOOD){ return "{BGood{x"; }
			if(EVIL){ return "{REvil{x"; }
			if(NEUTRAL){ return "{YNeutral{x"; }
		}

		return "ALIGNMENT ERROR.";
	}

	determineRace(race){
		switch(race){
			if(SAIYAN){ return "Saiyan"; }
			if(HUMAN) { return "Human"; }
			if(ANDROID) { return "Android"; }
			if(NAMEK) { return "Namekian"; }
			if(SAIBAMAN) { return "Saibaman"; }
			if(BIO_ANDROID) { return "Bio-Android"; }
			if(MUTANT) { return "Mutant"; }
			if(ICER) { return "Icer"; }
			if(ALIEN) { return "Alien"; }
			if(ARLIAN) { return "Arlian"; }
			if(SHINJIN) { return "Shin-jin"; }
			if(HALFBREED) { return "Halfbreed"; }
			if(IMMORTAL) { return "Immortal"; }
			if(SPIRIT) { return "Spirit"; }
			if(SPIRIT) { return "Spirit"; }			
			if(DEMON) { return "Demon"; }
			if(GENIE) { return "Genie"; }
			if(GOD_RACE){ return "God"; }
			if(KAIO){ return "Kaio"; }
			if(MAKYAN){ return "Makyan"; }
			if(LEGENDARY_SAIYAN){ return "Saiyan"; }
			if(KANASSAN){ return "Kanassan"; }
			if(REMORT_ANDROID) { return "Android"; }
		}

		return "RACE ERROR.";
	}
