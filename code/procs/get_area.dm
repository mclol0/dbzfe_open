proc
	get_area(name){
		var/planet/A = NULL; // Our area pointer once we find it if we find it...

		for(var/planet/area){
			if(lowertext(name) == rStrip_Escapes(lowertext(area.name))){
				A = area;
				break;
			}
		}

		if(A){
			return A;
		}else{
			game.logger.error("No area found with name -> [name]")
			return NULL;
		}
	}