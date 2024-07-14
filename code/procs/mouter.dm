proc
	mOuter(message, mob/m, range){
		if(!message){
			game.logger.error("mOuter: NULL message.");
			return NULL;
		}

		for(var/mob/Player/p in range){

			if(!m.canSense(p)) { continue; }

			var/obj/item/i = p.equipment[EYE]

			if(i && isScanner(i,FALSE) || p.race == ANDROID){
				p.senseDat.addMessage(m.ID,"{gYour scouter has detected " + message + " from {x[m.raceColor(m.name)] {gto the{x {G[game.dir2text(a_get_dir(p,m))]{x{g.{x")
			}else{
				p.senseDat.addMessage(m.ID,"You sense " + message + " to the [game.dir2text(a_get_dir(p,m))].")
			}
		}
	}