proc
	determineDirection(text){
		if(TextMatch("left", text, 1, 1) || text == DODGE_LEFT){
			return "left";
		}
		else if(TextMatch("right", text, 1, 1) || text == DODGE_RIGHT){
			return "right";
		}
		else if(TextMatch("high", text, 1, 1) || text == DUCK){
			return "high";
		}
		else if(TextMatch("low", text, 1, 1) || text == JUMP){
			return "low";
		}
		else {
			return NULL;
		}
	}

	determineThrow(text){
		if(TextMatch("north", text, 1, 1)){
			return "north";
		}
		else if(TextMatch("northeast", text, 1, 1) || TextMatch("ne", text, 1, 1)){
			return "northeast";
		}
		else if(TextMatch("northwest", text, 1, 1) || TextMatch("nw", text, 1, 1)){
			return "northwest";
		}
		else if(TextMatch("south", text, 1, 1)){
			return "south";
		}
		else if(TextMatch("southeast", text, 1, 1) || TextMatch("se", text, 1, 1)){
			return "southeast";
		}
		else if(TextMatch("southwest", text, 1, 1) || TextMatch("sw", text, 1, 1)){
			return "southwest";
		}
		else if(TextMatch("east", text, 1, 1)){
			return "east";
		}
		else if(TextMatch("west", text, 1, 1)){
			return "west";
		}else{
			return pick("west","east","north","south");
		}
	}

	determineParryHighLow(text){
		if(TextMatch("high", text, 1, 1)){
			return PARRY_HIGH;
		}
		else if(TextMatch("low", text, 1, 1)){
			return PARRY_LOW;
		}
		else {
			return NULL;
		}
	}

	determineDodge(text){
		if(TextMatch("left", text, 1, 1)){
			return DODGE_LEFT;
		}
		else if(TextMatch("right", text, 1, 1)){
			return DODGE_RIGHT;
		}
		else {
			return NULL;
		}
	}

	determinePunch(text){
		if(TextMatch("left", text, 1, 1)){
			return PUNCH_LEFT;
		}
		else if(TextMatch("right", text, 1, 1)){
			return PUNCH_RIGHT;
		}
		else {
			return NULL;
		}
	}

	determineKick(text){
		if(TextMatch("left", text, 1, 1)){
			return KICK_LEFT;
		}
		else if(TextMatch("right", text, 1, 1)){
			return KICK_RIGHT;
		}
		else {
			return NULL;
		}
	}