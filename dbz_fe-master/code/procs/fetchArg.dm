proc
	fetchArg(list/l, argx){
		if(argx > length(l)){
			return NULL;
		}

		return l[argx];
	}