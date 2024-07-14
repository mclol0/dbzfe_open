proc
	format_list(list/l, amount=3, spacing=23, EXTRA=FALSE){
		var
			curLine = 0
			buffer=""

		for(var/listEnt in l){
			if(curLine != amount){
				buffer += listEnt
			}
			else{
				if(EXTRA) buffer += "\n"
				buffer += "\n[listEnt]"
				curLine = 0
			}

			for(var/newSpace = 1 to (spacing-(length(rStrip_Escapes(listEnt))*2-length(listEnt)))) buffer += " "

			curLine++
		}

		return buffer
	}