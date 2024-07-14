proc
	view_list(list/X, format, m)
		var
			ry = ""
			rx = ""
			rz = ""

		switch(format){
			if("divide")
				for(var/a in X)
					ry += " [a] /"
			if("room"){
				for(var/l = 1 to X.len)
					var/C = X[l]
					if(C:MULTI){
						ry += "[m:enCheck(C)][m:checkSkill(C)][C:raceColor("a [C:single_name]")][gForm.getAbbr(C:form)] ([m:powerMark(C)]) is [C:getStatus()] here.\n"
					}else{
						ry += "[m:enCheck(C)][m:checkSkill(C)][C:raceColor(C:name)][gForm.getAbbr(C:form)] ([m:powerMark(C)]) is [C:getStatus()] here.\n"
					}
			}
			if("item_room"){
				for(var/l = 1 to X.len)
					var/C = X[l]
					if(istype(C,/obj/item)){
						if (checkPlane(m, C) || !C:insideBuilding) {
							if(X[C] > 1){
								if(C:MULTI){
									ry += "[X[C]] [C:MULTI_DISPLAY]'s are [C:_getStatus()] here.\n"
								}else{
									ry += "[X[C]] [C:PREFIX][C:DISPLAY] are [C:_getStatus()] here.\n"
								}
							}
							else{
								if(C:MULTI){
									ry += "[C:PREFIX][C:DISPLAY] is [C:_getStatus()] here.\n"
								}else{
									ry += "[C:PREFIX][C:DISPLAY] is [C:_getStatus()] here.\n"
								}
							}
						}
					}else if(istype(C,/obj/spacepod)){
						if(isplayer(m) && m:spacePod && m:spacePod == C && (m in m:spacePod:passengers) || m:insideBuilding) continue
						ry += "[C:DISPLAY] is [C:getStatus()] here.\n"
					}
			}
			if("nearby")
				for(var/l = 1 to X.len)
					var/C = X[l]
					if(X[C] > 1){
						if(C:MULTI){
							ry += " ([X[C]]) [C:raceColor(C:multi_name)] /"
						}else{
							ry += " ([X[C]]) [C:raceColor(C:name)] /"
						}
					}
					else{
						if(C:MULTI){
							ry += " [C:raceColor("a [C:single_name]")] /"
						}else{
							ry += " [C:raceColor(C:name)] /"
						}
					}
			if("inventory"){
				ry += "{YInventory:{x\n {WW: {x{D[m:inventoryWeight()] kgs.{x\n"
				if(!X.len){
					ry += " {DEmpty.{x "
				}else{
					for(var/l = 1 to X.len){
						var/C = X[l]
						if(istype(C,/obj/item)){
							if(X[C] > 1){
								if(C:MULTI){
									ry += " x[X[C]] [C:SINGLE_DISPLAY]'s\n"
								}else{
									ry += " x[X[C]] [C:PREFIX][C:DISPLAY]\n"
								}
							}
							else{
								ry += " x1 [C:PREFIX][C:DISPLAY]\n"
							}
						}
					}
				}
			}
			if("blank")
				for(var/a in X)
					ry += "[a] "
			if("break")
				for(var/a in X)
					ry += " [a]\n"
			if("website")
				for(var/a in X)
					ry += " [a]<br />"
			if("monitor")
				for(var/a in X)
					ry += " [a]\n"
			if("flat")
				for(var/a in X)
					ry += "[a]"
			if("comma")
				for(var/a in X)
					ry += "[a],"
			if("combo")
				for(var/a in X)
					ry += "{R[a]{x "
			if("defense")
				rx += "{B({x"
				for(var/a in X)
					if((translateDefenseSKILL(a) in m:techniques)){ ry += "{R[translateDefense(a)]{x {B/{x "; }
				ry = copytext(ry,1,length(ry)-6)
				rz += "{B){x"
				return rx + ry + rz
			if("syntax")
				for(var/a in X)
					ry += "{C'[a]'{x{c|{x"
				ry = copytext(ry,1,length(ry)-6)
				return ry
			if("divider")
				rx += "{c({x"
				for(var/a in X)
					ry += "{Y[a]{x {C|{x "
				ry = copytext(ry,1,length(ry)-6)
				rz += "{c){x"
				return rx + ry + rz
		}

		ry = copytext(ry,1,length(ry))
		return ry