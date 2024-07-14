proc
	format_text(text,WEB=FALSE){
		var/loc0 = findtextEx(text, "<a")
		while(loc0){
			var
				loc1 = findtextEx(text, "</a>", loc0+1)
				locend = findtextEx(text, ">", loc0+1)
				Align = ckey(copytext(text,loc0+2,loc0+3))
				width = text2num(copytext(text,loc0+3,locend))
				align = LEFT

			switch(Align){
				if("l") align = LEFT
				if("c") align = CENTER
				if("r") align = RIGHT
			}
			var/altext = align_text(copytext(text,locend+1, loc1),width,align,WEB)
			text = copytext(text,1,loc0) + altext + copytext(text, loc1+4)
			loc0 = findtextEx(text, "<a")
		}
		return text;
	}
