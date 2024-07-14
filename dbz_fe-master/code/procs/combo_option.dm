proc
	/*
	This procedure just translated combo's from punch left and punch right.
	*/
	comboOption(type){
		if(type == PUNCH_LEFT){
			return "lp";
		}

		if(type == PUNCH_RIGHT){
			return "rp";
		}

		if(type == KICK_RIGHT){
			return "rk";
		}

		if(type == KICK_LEFT){
			return "lk";
		}

		return type;
	}