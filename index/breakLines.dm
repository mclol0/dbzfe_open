proc
	breakL(times as num){
		var/breaks = null;

		for(var/i=0,i<times,i++){
			breaks += "<br>";
		}

		return breaks;
	}