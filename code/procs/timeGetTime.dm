proc
	timeGetTime(request){
		var/
			list/time = text2list(ClearSpaces(systemTime())," ");
			n = 1;

		switch(lowertext(request)){
			if("day"){
				n = 1;
			}
			if("month"){
				n = 2;
			}
			if("date"){
				n = 3;
			}
			if("time"){
				n = 4;
			}
			if("year"){
				n = 5;
			}
		}

		return ClearSpaces(time[n]);
	}