/proc/_params2list(var/list/L){
	. = params2list(L);

	for(var/x in .){
		if(isnum(text2num(.[x]))){
			.[x] = text2num(.[x]);
		}
	}
}