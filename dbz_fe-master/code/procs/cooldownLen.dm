proc
	cooldownLen(name){
		var/c = 0;

		for(var/x in game.coolDowns){
			if(findtextEx(x, name)){ c++; }
		}

		return c;
	}