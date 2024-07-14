proc
	/*
	This procedure looks for a reference inside a list and returns true or false if found or not.
	*/
	findIn(ref, list/l){
		if((ref in l)){
			return TRUE;
		}
		return FALSE;
	}