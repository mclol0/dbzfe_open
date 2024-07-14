proc
	_getName(def){
		switch(def){
			if(SPECIAL_HEAD){return "forehead"}
			if(HEAD){return "head"}
			if(EYE){return "eye"}
			if(EARS){return "ears"}
			if(NECK){return "neck"}
			if(SHOULDERS){return "shoulders"}
			if(BACK){return "back"}
			if(CHEST){return "chest"}
			if(WAIST){return "waist"}
			if(ARMS){return "arms"}
			if(WRISTS){return "wrists"}
			if(HANDS){return "hands"}
			if(LEFT_FINGER){return "left finger"}
			if(RIGHT_FINGER){return "right finger"}
			if(FINGERS){return "fingers"}
			if(LEGS){return "legs"}
			if(KNEES){return "knees"}
			if(FEET){return "feet"}
			if(BODY){return "body"}
		}

		return "no slot"
	}