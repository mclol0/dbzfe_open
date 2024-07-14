proc
	/*
	This procedure determines how many fakes a mob can do in one fake process.
	*/
	fakeDifficulty(difficulty){
		switch(difficulty){
			if(VERY_EASY) return 0
			if(EASY) return 1
			if(MEDIUM) return 2
			if(HARD) return 3
			if(VERY_HARD) return 4
			if(INSANE) return 5
			if(FUSION) return 5
			if(GOD) return 7
			if(HEROIC) return 4
		}
	}