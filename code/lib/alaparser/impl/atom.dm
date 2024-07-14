atom
	proc
		getMatchKeywords() {
			if(istype(src,/obj/item)){
				return fa_split(rStrip_Escapes(src:DISPLAY)," ");
			}else{
				return fa_split(src.name," ");
			}
		}

client
	proc
		getMatchKeywords() {
			return fa_split(src.key," ");
		}