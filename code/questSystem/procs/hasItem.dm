fQuest_Factory
	hasItem(mob/m as mob, type){
		if(locate(type) in m.contents){
			return TRUE;
		}

		return FALSE;
	}