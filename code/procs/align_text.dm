proc
	align_text(text, width, align, WEB=FALSE){
		if(length(text) > width){
			text = copytext(text,1,width)
		}
		if(WEB){
			if(length(text) < width){
				switch(align){
					if(RIGHT){
						for(var/i = 1 to width - length(text)) text = "&nbsp;"+text
					}
					if(LEFT){
						for(var/i = 1 to width - length(text)) text += "&nbsp;"
					}
					if(CENTER){
						for(var/i = 1 to round((width - length(text))/2)) text = "&nbsp;"+text+"&nbsp;"
						for(var/i = 1 to width - length(text)) text += "&nbsp;"
					}
				}
			}
		}else{
			if(length(text) < width){
				switch(align){
					if(RIGHT){
						for(var/i = 1 to width - length(text)) text = " "+text
					}
					if(LEFT){
						for(var/i = 1 to width - length(text)) text += " "
					}
					if(CENTER){
						for(var/i = 1 to round((width - length(text))/2)) text = " "+text+" "
						for(var/i = 1 to width - length(text)) text += " "
					}
				}
			}
		}
		return text;
	}