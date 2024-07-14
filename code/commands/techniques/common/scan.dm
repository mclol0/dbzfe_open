Command/Technique
	scan
		name = "scan"
		internal_name = "scan"
		format = "~scan";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		canUseWhileRESTING = TRUE;
		helpCategory = "Utility"
		helpDescription = "Search for beings in your surroundings, pinpointing their location and their strength related to you.\n\n{YNote:{x {CWhen using a Scouter, a numeric representation of their power can be seen."

		command(mob/Player/user, argument) {
			var/buffer[] = list()

			if(user){

				var/c=0;

				for(var/mob/m in radius_out(6,34,user)){
					if(!m.canSense(user)){ continue; }
					buffer += format_text("[user.enCheck(m,TRUE)][user.checkSkill(m,TRUE)]<al23>[m.raceColor(m.name)]</a><al16>{D[uppertext(game.dir2text(a_get_dir(user,m)))]{x</a><al17>{D[coord(m:x,m:loc.loc:getMaxX())]{x.{D[coord(m:y,m:loc.loc:getMaxY())]{x</a><al30>([user.powerMark(m)])</a>\n");
					c++;
				}

				if(!c){ buffer += "You sense no one.."; }

				send(implodetext(buffer,""),user)

			}
		}