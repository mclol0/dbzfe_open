proc
	printGravty(num){
		if(num > 1){
			return "[num]Gs";
		}else{
			return "[num]G";
		}
	}

	buildMap(mob/Player/user, _LEFT, _RIGHT, _TOP, _BOTTOM){

		if(!isplayer(user) || user.blind){ return FALSE; }

		_LEFT = user.insideBuilding ? INSIDE_MAP_X : _LEFT
		_RIGHT = user.insideBuilding ? INSIDE_MAP_X : _RIGHT
		_TOP = user.insideBuilding ? INSIDE_MAP_Y : _TOP
		_BOTTOM = user.insideBuilding ? INSIDE_MAP_Y : _BOTTOM

		var
			list/map = list();
			list/nearby = list();
			list/buffer = list();
			list/RoomUsers = user.getRoom();
			list/RoomItems = user.getItemRoom();
			_Y;
			_X;
			CT = _TOP;
			CT2 = 1;
			PT = 1;
			turf/T;
			mob/M;
			fEAttk/X;
			obj/O;
			obj/spacepod/SP;

		_LEFT = user.x-_LEFT
		_RIGHT = user.x+_RIGHT
		_TOP = user.y+_TOP
		_BOTTOM = user.y-_BOTTOM

		var/playerTurfName = NULL
		if (houseSystem.isPlayerTurf(user.loc) && (istype(user.loc, houseSystem.TURFS[houseSystem.ENTRANCE]) || user.insideBuilding)) {
			playerTurfName = user.loc:getName()
		}

		buffer += "Where: {D({x{Y[user.loc && user.loc.loc ? printGravty(user.getGravity()) : "ERROR"]{x{D){x [user.loc && user.loc.loc ? user.loc.loc:name : "ERROR"][playerTurfName ? " - [playerTurfName]" : ""]"

		if(!user.insideBuilding && user.loc && user.loc.loc && user.loc.loc:moons && user.loc.loc:moons.len > 0){
			var/moon/Moon = user.loc.loc:moons[1];

			buffer += " (Moon Cycle: {W[Moon.CYCLES[Moon.currentCycle]]{x)\n";
		}else{
			buffer += "\n";
		}

		if(user.loc && user.loc.loc){
			for(var/YY in _TOP to _BOTTOM step -1){
				for(var/XX in _LEFT to _RIGHT){
					_Y = Wrap(YY,user.loc.loc:y,user.loc.loc:getMaxY(),user.loc.loc:hideEdges)
					_X = Wrap(XX,user.loc.loc:x,user.loc.loc:getMaxX(),user.loc.loc:hideEdges)
					T = locate(_X,_Y,user.z)
					M = locate() in T
					X = locate() in T
					O = locate() in T
					SP = locate() in T

					for(var/mob/m in T){ if(!m.invisible){ nearby.Add(m); } }

					if(!user.disableMap){
						if(searcFor(T,user)){map += user.map_mobMark(user)}
						else if(M && M.visible && !M.invisible && isplayer(M) && (user.insideBuilding == M.insideBuilding)) {map += user.map_mobMark(M)}
						else if(M && M.visible && !M.invisible && isnpc(M) && (user.insideBuilding == M.insideBuilding)){map += user.map_mobMark(M)}
						else if(X && X.visible){map += X.display}
						else if(SP && SP.visible && SP:SHOW_IN_MAP && (user.insideBuilding == SP.insideBuilding)){ map += SP.display; }
						else if(O && O.visible && O:SHOW_IN_MAP && (user.insideBuilding == O.insideBuilding)){ map += O.display }
						else if(T && T.visible){if(length(T.possibleDisplay) > 0){ if(!user.insideBuilding) { map += pick(T.possibleDisplay) } else if(user.insideBuilding && houseSystem.isPlayerTurf(T) && T:instanceId == user.insideBuilding) { map += pick(T.possibleDisplay) } else { map += " " } } else { if(!user.insideBuilding) { map += T.showDisplay() } else if(user.insideBuilding && houseSystem.isPlayerTurf(T) && T:instanceId == user.insideBuilding){ map += T.showDisplay() } else { map += " " } }}
					}
				}

				if(!user.disableMap){
					if(CT > 0 && PT == 1){map += " \[{r[CT]{x\]";CT--}
					else if(CT == 0 && PT == 1){map += " \[{R!{x\]";PT = 2}
					else if(PT == 2){map += " \[{r[CT2]{x\]";CT2++}

					map += "\n"
				}
			}
		}

		buffer = (buffer + compressMap(map,user.compression))

		buffer += "Location: [user.loc ? user.loc:returnLocation(user) : "ERROR"] [user.loc && user.loc.loc ? coord(user.getX(),user.loc.loc:getDX()) : "ERROR"]{C.{x[user.loc && user.loc.loc ? coord(user.getY(),user.loc.loc:getDY()) : "ERROR"]{x\n"

		nearby = user.loc && user.loc.loc ? get_nearby(user,nearby) : list();

		if(length(nearby) > 0){
			buffer += "Nearby:[user.loc && user.loc.loc ? view_list(stackList(distance_order(user,nearby), list("name", "type")),"nearby") : "ERROR"]\n"
		}

		buffer += "Exits: {g[user.loc && user.loc.loc ? view_list(user.Exits(),"blank") : "ERROR"]{x\n"

		if(length(RoomUsers) > 0){
			buffer += "\n[user.loc && user.loc.loc ? view_list(RoomUsers,"room",user) : "ERROR"]"
		}

		if(length(RoomItems) > 0){
			buffer += "\n[user.loc && user.loc.loc ? view_list(RoomItems,"item_room",user) : "ERROR"]"
		}

		send(implodetext(buffer,""),user)
	}