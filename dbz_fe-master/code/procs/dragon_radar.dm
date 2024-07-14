proc
	closestDragonball(mob/Player/m){
		var/list/DragonBallZ = list();

		if(m.getArea() == get_area("earth")){
			for(var/obj/item/DRAGONBALLS/d in m.getArea()){
				DragonBallZ.Add(d);
			}
			for(var/obj/item/DRAGONBALLS/d in m.contents){
				DragonBallZ.Remove(d);
			}
		}else{
			for(var/obj/item/NAMEK_DRAGONBALLS/d in m.getArea()){
				DragonBallZ.Add(d);
			}
			for(var/obj/item/NAMEK_DRAGONBALLS/d in m.contents){
				DragonBallZ.Remove(d);
			}
		}

		return distance_order(m,DragonBallZ);
	}

	closesDragonballDirection(mob/Player/m){
		var/direction = NULL;
		var/DragonBallZ = closestDragonball(m);

		if(m.getArea() == get_area("earth")){
			for(var/obj/item/DRAGONBALLS/d in DragonBallZ){
				direction = a_get_dir(m,d);
				break;
			}
		}else{
			for(var/obj/item/NAMEK_DRAGONBALLS/d in DragonBallZ){
				direction = a_get_dir(m,d);
				break;
			}
		}

		return direction;
	}

	getDirectionText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{G?{x"; }

			switch(closesDragonballDirection(m)){
				if(0){
					return "{Y*{x";
				}
			}
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{G?{x"; }

			switch(closesDragonballDirection(m)){
				if(0){
					return "{Y*{x";
				}
			}
		}

		return "{C*{x";
	}

	getNorthDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(1){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getNorthEDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(5){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getNorthWDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(9){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getSouthDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(2){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getSouthEDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(6){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getSouthWDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(10){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getWestDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(8){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	getEastDBText(mob/Player/m){
		if(m.getArea() == get_area("earth")){
			if(!DBDatum.areActive()){ return "{g.{x"; }
		}else{
			if(!DBDatum_NAMEK.areActive()){ return "{g.{x"; }
		}
		switch(closesDragonballDirection(m)){
			if(4){
				return "{Y*{x";
			}
		}

		return "{g.{x";
	}

	drawRadar(mob/Player/m){
		var/obj/item/DRAGON_RADAR/d = locate(/obj/item/DRAGON_RADAR) in m.contents

		if(!d) { return NULL; }

		var/RadarBuffer = NULL;

		RadarBuffer += " {W___i___{x \n";
		RadarBuffer += "{W|{x[getNorthWDBText(m)]{g..{x[getNorthDBText(m)]{g..{x[getNorthEDBText(m)]{W|{x \n";
		RadarBuffer += "{W|{x{g.......{x{W|{x \n";
		RadarBuffer += "{W|{x[getWestDBText(m)]{g..{x{G[getDirectionText(m)]{x{g..{x[getEastDBText(m)]{W|{x \n";
		RadarBuffer += "{W|{x{g.......{x{W|{x \n";
		RadarBuffer += "{W|{x[getSouthWDBText(m)]{g..{x[getSouthDBText(m)]{g..[getSouthEDBText(m)]{x{W|{x \n";
		RadarBuffer += " {W-------{x \n";

		return RadarBuffer;
	}