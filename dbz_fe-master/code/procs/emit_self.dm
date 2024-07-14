proc
	emitSelf(mob/m, range){
		for(var/mob/Player/p in range){

			if(!m.canSense(p)) { continue; }

			var/obj/item/i = p.equipment[EYE]

			if(i && isScanner(i,FALSE) || p.race == ANDROID){
				p.senseDat.addMessage(m.ID,"{gYour scouter has detected {x[m.raceColor(m.name)]{g to the{x {G[game.dir2text(a_get_dir(p,m))]{x {gwith a powerlevel of{x {G[p.general_mark(m)]{x{g.{x",TRUE)
			}else{
				p.senseDat.addMessage(m.ID,"You sense a [p.general_mark(m)] powerlevel to the [game.dir2text(a_get_dir(p,m))].",TRUE)
			}
		}

		return TRUE;
	}
