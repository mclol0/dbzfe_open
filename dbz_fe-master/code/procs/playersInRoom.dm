proc
	playersInRoom(loc, caller){
		if(locate(/mob/Player) in (loc - caller)) { return TRUE; }

		return FALSE;
	}