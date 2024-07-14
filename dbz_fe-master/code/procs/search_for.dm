proc
	searcFor(list/l, target){
		if((target in l) && target:visible){
			return TRUE;
		}
		return FALSE;
	}