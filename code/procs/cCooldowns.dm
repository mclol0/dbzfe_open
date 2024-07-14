proc
	cCooldowns(name){
		for(var/x in game.coolDowns){
			if(findtextEx(x, name)){ game.coolDowns[x] = 0; }
		}
	}